## 

### Running Postgres with Docker
1. Windows
```
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v C:/Users/tellw/OneDrive/Documents/GitHub/data-engineering-datatalk/01-docker-terraform/docker_sql/postgres_data:/var/lib/postgresql/data \
  -p 5435:5432 \
  postgres:13
```

2. 

### Download Dataset
https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz 
https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page
https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv