import requests
import json

DREMIO_API_URL = 'http://localhost:9047/'
DREMIO_USERNAME = 'dremio'
DREMIO_PASSWORD = 'dremio123'

# List of data sources to add on Dremio
sources = [
    {
        "name": "lakehouse",
        "type": "NESSIE",
        "config": {
            "nessieEndpoint": "http://nessie:19120/api/v2",
            "nessieAuthType": "NONE",
            "asyncEnabled": True,
            "isCachingEnabled": True,
            "maxCacheSpacePct": 100,
            "credentialType": "ACCESS_KEY",
            "awsAccessKey": "minio",
            "awsAccessSecret": "minio123",
            "awsRootPath": "lakehouse",
            "propertyList": [
            {
                "name": "fs.s3a.path.style.access",
                "value": "true"
            },
            {
                "name": "fs.s3a.endpoint",
                "value": "http://minio:9000"
            },
            {
                "name": "dremio.s3.compat",
                "value": "true"
            }
            ],
            "secure": False,
            "isCachingEnabled": True,
            "maxCacheSpacePct": 100,
            "refreshEvery": { "unit": "HOURS", "duration": 1 },
            "expiration": { "unit": "HOURS", "duration": 3 }
        }
    },
    {        
        "name": "landing-zone",
        "type": "S3",
        "config": {
            "accessKey": "minio",
            "accessSecret": "minio123",
            "secure": False,
            "propertyList": [
            {
                "name": "fs.s3a.path.style.access",
                "value": "true"
            },
            {
                "name": "fs.s3a.endpoint",
                "value": "minio:9000"
            },
            ],
            "rootPath": "/",
            "enableAsync": False,
            "compatibilityMode": True,
            "isCachingEnabled": True,
            "maxCacheSpacePct": 100,
            "whitelistedBuckets": [
            "landing-zone"
            ],
            "requesterPays": False,
            "enableFileStatusCheck": True,
            "defaultCtasFormat": "ICEBERG",
            "isPartitionInferenceEnabled": False,
            "credentialType": "ACCESS_KEY"
        }
    }
]

# Authenticate and get token
def authenticate():
    auth_url = f"{DREMIO_API_URL}/apiv2/login"
    response = requests.post(auth_url, json={"userName": DREMIO_USERNAME, "password": DREMIO_PASSWORD})
    if response.status_code == 200:
        token = response.json()['token']
        return token
    else:
        raise Exception(f"Failed to authenticate: {response.text}")

# Add source using Dremio API
def add_source(token, source):
    headers = {
        'Authorization': f'_dremio {token}',  # Space between _dremio and token
        'Content-Type': 'application/json'
    }
    url = f"{DREMIO_API_URL}/api/v3/source"
    response = requests.post(url, headers=headers, data=json.dumps(source))
    if response.status_code == 200 or response.status_code == 201:
        print(f"Successfully added source {source['name']}")
    else:
        print(f"Failed to add source {source['name']}: {response.text}")

# Main
if __name__ == "__main__":
    token = authenticate()
    for source in sources:  # Iterate over the list of sources
        add_source(token, source)
