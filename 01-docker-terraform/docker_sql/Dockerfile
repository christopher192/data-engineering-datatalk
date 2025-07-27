FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    gcc \
    libpq-dev \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir pandas sqlalchemy psycopg2-binary

COPY ingest_data.py .

ENTRYPOINT ["python", "ingest_data.py"]