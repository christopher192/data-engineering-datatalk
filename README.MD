## Data Engineering Zoomcamp
### Introduction
While working in a manufacturing environment, realizing that data engineering play a critical role in manufacturing operation. When data become large and complex, it is data engineering take part in organizing, processing, and making it usable. This course will give solid foundation to fully understand these techniques, so can apply them effectively in real-world scenarios when needed. Additionally, data engineering is vital in machine learning application, where clean, structured, up-to-date, and scalable data pipeline is key to successful model deployment.

### How Data Engineering Supporting Manufacturing Application
1. Data Source
    - Data come from multiple systems, such as MES (Manufacturing Execution System), PLC/ SCADA, ERP, and IoT sensor on machine.
    - Each system store data in different format and update at different interval.
2. Data Pipeline Setup
    - build ETL/ ELT pipeline to
        - `Extract` data from machine and system (via API, log files, other channel)
        - `Transform` it (cleaning, aggregating, calculating, etc)
        - `Load` it into a central warehouse or real-time database (TimescaleDB, InfluxDB)
3. Real-Time Data Streaming
    -  Tools like Apache Kafka or AWS Kinesis are used to stream data in real time for time-sensitive project/ app
4. Backend in Production Application
    - The backend will query the clean, ready-to-use data store and serves data via API.
    - Frontend dashboards built with React, Angular, or Power BI pull this data live.
5. Monitoring & Reliability
    - Setup monitoring to detect pipeline failure or data delay, ensuring production application reliability.
6. Outcome
    - Plant supervisor monitor production data in real time.
    - Alert will be triggered automatically if defect rate spike or machine efficiency drop.
    - Decision is made quickly, reducing waste and improving efficiency.

### ETL/ ELT Technique
ETL (Extract, Transform, Load) and ELT (Extract, Load, Transform) are two key approaches in data engineering for processing and preparing data for analytics.

### ETL (Extract, Transform, Load) vs ELT (Extract, Load, Transform)

| Feature               | **ETL** | **ELT** |
|----------------------|-----------------------------------|-----------------------------------|
| **Process**          | Extract → Transform → Load       | Extract → Load → Transform       |
| **Where Transformation Happens?** | Before loading (staging area) | Inside the Data Warehouse/ Lake  |
| **Speed**            | Slower (preprocessing required)  | Faster |
| **Flexibility**      | Less flexible     | More flexible     |
| **Scalability**      | Limited by ETL tool capacity     | Highly scalable (cloud-based)   |
| **Data Volume**      | Best for structured, smaller data | Handles large unstructured data |
| **Common Tools**     | Informatica, Talend, SAP DS      | dbt, Snowflake, BigQuery, Redshift |

### When to Use **ETL**?
- When data **must be cleaned** before loading.
- For **structured, relational** databases.
- When **compliance & security** require pre-processed data.

### When to Use **ELT**?
- When working with **big data** or **cloud-based** architectures.
- If transformation needs to be **on-demand** and flexible.
- For **scalability and cost efficiency** in modern data pipelines.

### Real-World Use Case of ETL vs ELT
ETL Use Case (Extract → Transform → Load)
- Healthcare & Insurance
    - Use Case: Hospitals extract patient records from multiple systems, clean and standardize formats (transformation), and then store/ load them into data warehouse.
    - Why ETL? Ensures data privacy, accuracy, and compliance before storing in a structured format for reporting and analysis.

ELT Use Case (Extract → Load → Transform)
- IoT & Sensor Data (Smart Device, Factory)
    - Use Case: Tesla processes live vehicle sensor data to monitor battery performance and predict failure.
    - Why ELT? Raw IoT data is stored in a cloud warehouse, and transformation is done dynamically for real-time insight.

### Data Warehouse vs Data Lake
| **Feature** | **Data Warehouse** | **Data Lake** |
|----------------------|----------------------|----------------------|
| **Data Type** | Structured (SQL tables, relational) | Raw, unstructured & structured (JSON, logs, images, videos) |
| **Processing Speed** | Faster (optimized for analytics) | Slower (raw data processing required) |
| **Storage Cost**    | Expensive (high-performance storage) | Cheaper (scalable cloud storage) |
| **Use Case**        | Business Intelligence (BI), reporting, dashboards | AI, machine learning, big data analytics |
| **Common Tools**    | Snowflake, Redshift, BigQuery, Teradata | AWS S3, Azure Data Lake, Google Cloud Storage |
| **Best For**       | Structured business reporting and analysis | Flexible big data storage and exploratory analysis |