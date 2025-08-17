## Workflow Orchestration (Kestra)

### Exploring Docker
1. `docker/postgres/docker-compose.yml`
    - Set up PostgreSQL database
2. `docker/kestra/docker-compose.yml`
    - Run Kestra for workflow orchestration
3. `docker/combined/docker-compose.yml`
    - Integrate Kestra with PostgreSQL

### Flow

### Step-by-step
1. Run this command prompt to start service
```
cd 02-workflow-orchestration-kestra/docker/combined
docker compose up -d
```
2. Access the Kestra UI
    - http://localhost:8080
3. 

### Build Data Pipeline with Kestra
1. Step 1
    - Extract data from https://github.com/DataTalksClub/nyc-tlc-data/releases
2. Step 2: Load it into Postgres
3. Step 2: Load it into Google Cloud (GCS + BigQuery)
4. Scheduling and backfilling workflow