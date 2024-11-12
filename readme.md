# data stack

## Overview
This 

## Data Stack

- Nifi for ingestion
- Nifi registry for control version
- Minio for object storage (S3 AWS)
- Dremio as query engine
- Apache Nessie for metastore


- DBT for transformation, basic tests and documentation

- Jupyter notebook for data quality
- Airflow orchestration

# Environment setup

## Install docker
Download and install the docker desktop.

## Python install (optional)

### create a venv environment
```sh
py -m venv venv
````

### install the requirements
```sh
pip install -r requirements.txt
```

# Pipeline

## From a local folder to S3

Execute the bellow command to launch Nifi.
```sh
docker compose --profile nifi up -d
````
- https://localhost:8443/nifi/#/login
- user: nifi
- password: nifi12345678


On Nifi add a new Process group and import the json file according the following the steps below.

1. Drag and drop the Process group icon

<img src="docs/img/nifi-1.png">

2. Click on the icon browser and import the json file presented on the path "nifi/Ingestion_raw_data.json"

<img src="docs/img/nifi-2.png">

<img src="docs/img/nifi-3.png">

3. Open the group Ingestion_raw_data, after open the file_ingestion_to_s3 group process.


<img src="docs/img/nifi-4.png">

4. Open the process PutS3Object, go to the properties tab, on AWS Credentials Provider Services, select the option 'Go to Service'

<img src="docs/img/nifi-5.png">
<img src="docs/img/nifi-6.png">

5. Add the Access and Secret Keys. Apply the changes.

<img src="docs/img/nifi-7.png">
<img src="docs/img/nifi-8.png">

6. Enable the service using the scope 'Service and referencing components'. 

<img src="docs/img/nifi-9.png">
<img src="docs/img/nifi-10.png">

7. Close returning to the group process. The PutS3Object now is ready to send files to s3.

8. Return to the first level and start the Ingestion_raw_data process group.

<img src="docs/img/nifi-11.png">

9. Paste the csv file ("docs/requirement/Invoices_Year_2009-2010.csv") inside the folder datasources on the project repository. It will be automatically sent to Minio on under the bucket landing-zone and delete the file.

<img src="docs/img/nifi-12.png">

Notes:
- this approach took in consideration only the file sent for the assessment. For a different file is needed an adjustment in the flow.

## From a Landing Zone on S3 to a Bronze layer

Execute the bellow command to launch Dremio.
```sh
docker compose --profile dremio up -d
````
- http://localhost:9047/

1. Access Dremio UI and set the admin properties as per the images below.

<img src="docs/img/dremio-1.png">
<img src="docs/img/dremio-2.png">

2. On the project repository, 

2.1. Execute the Python script "scripts/dremio_add_sources.py" to add the sources through Dremio API.

<img src="docs/img/dremio-3.png">

2.2. Execute the Python script "scripts/dremio_converting_to_table.py" to convert the csv file into a table.

## Tools and credentials

### Nifi
https://localhost:8443/nifi/#/login
user: nifi
password: nifi12345678

### Minio IO
http://localhost:9001/
user:minio
password: minio123

