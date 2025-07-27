## Docker & PostgreSQL

### Installation
1. Download and install Miniconda
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```
2. Install Docker and Docker Compose
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Install the Docker package
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

To run docker without `sudo`
```
sudo groupadd docker
sudo usermod -aG docker $USER
```

Reboot GCP instance
```
sudo reboot
```

3. Create a new Conda environment for this project
```
# Restart shell
source ~/.bashrc
# Create conda environment
conda create -n data-engineering python=3.10
```

4. Manually Install Required Python Packages
```
conda activate data-engineering

pip install pandas
pip install pyarrow
pip install pgcli
pip install sqlalchemy
pip install psycopg2-binary
```

### Dataset Preparation
Download the yellow taxi trip data for September 2023 from the NYC TLC website https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page. Scroll to the `Yellow Taxi Trip Records` section and select the Parquet file for that month. Save the downloaded file in the `data/` folder of your project directory. This dataset is required by the `data-loading-parquet.ipynb` notebook for loading.

```
wget https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2023-09.parquet
wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz
```

### Step-by-Step to Run Data Ingestion
1. Start a PostgreSQL, pgAdmin container using Docker
```
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v $(pwd)/postgresql_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13

# detached mode
docker run -it -d \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v $(pwd)/postgresql_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13

# pgAdmin
docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  dpage/pgadmin4

# Running PostgreSQL and pgAdmin together
docker network create pg-network

docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v $(pwd)/postgresql_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:13

docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  --network=pg-network \
  --name pgadmin-2 \
  dpage/pgadmin4

# stop/ remove docker container
docker ps
docker stop <container id/ name>
docker rm <container id/ name>

# delete volume
docker volume ls
docker volume rm <volumne name>

# remove local volumne
sudo rm -rf <local volumne name>
```

2. Run `data-loading-parquet.ipynb` for Testing<br>
This notebook read the dataset and test the ingestion pipeline by inserting the data into a PostgreSQL database. It ensure that the connection, table creation, and batch insertion work as expected. The lookup table is also merged with the trip data. 

3. Run `data-loading-parquet.py` for Testing<br>
This script is primarily used for data ingestion. It download the dataset from a given URL and insert it into a PostgreSQL database in chunks, for example, the data is processed and inserted in smaller part only (100,000 row at a time) instead of loading the entire file into memory at once.
```
URL="https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2023-09.parquet"

python data-loading-parquet.py \
  --user=root \
  --password=root \
  --host=localhost \
  --port=5432 \
  --db=ny_taxi \
  --tb=yellow_tripdata \
  --url=${URL}
```

4. Run `ingest_data.py`

Run it locally
```
URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"

python ingest_data.py \
  --user=root \
  --password=root \
  --host=localhost \
  --port=5432 \
  --db=ny_taxi \
  --table_name=yellow_taxi_trips \
  --url=${URL}
```

Build The Docker Image for The Ingestion Script<br>
Refer `Dockerfile`
```
docker build -t taxi_ingest:v001 .
```

Run The Script with Docker<br>
```
URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"

docker run -it \
  --network=pg-network \
  taxi_ingest:v001 \
    --user=root \
    --password=root \
    --host=pg-database \
    --port=5432 \
    --db=ny_taxi \
    --table_name=yellow_taxi_trips \
    --url=${URL}
```

### Step-by-Step to Run Data Ingestion (Docker Compose)<br>
Build Docker Compose
```
# create so all pgAdmin server connections, history, and settings are stored in ./data_pgadmin
# survive container shutdown, restart, or rebuild
mkdir data_pgadmin

# ensure pgAdmin has permission to read/ write to this folder
sudo chown 5050:5050 data_pgadmin

# up container
docker-compose up

# detached mode
docker compose up -d

# shutting down
docker compose down
```

Build the Docker image for the ingestion script
```
docker build -t taxi_ingest:v001 .
```

Run the script with Docker
```
# check network
docker network ls

docker run -it \
  --network=docker_sql_default \
  taxi_ingest:v001 \
  --user=root \
  --password=root \
  --host=pgdatabase \
  --port=5432 \
  --db=ny_taxi \
  --table_name=yellow_taxi_trips \
  --url=https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz
```

### SQL