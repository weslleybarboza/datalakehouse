import requests
import json
import urllib.parse

DREMIO_API_URL = 'http://localhost:9047/'
DREMIO_USERNAME = 'dremio'
DREMIO_PASSWORD = 'dremio123'

folder_path = ["landing-zone","invoices"] 
id_dremio = "dremio:/landing-zone/invoices"
id = urllib.parse.quote(id_dremio, safe='')

payload = {
    "entityType": "dataset",
    "path": folder_path,
    "type": "PHYSICAL_DATASET",
    "format": {
        "type": "Text",
        "fieldDelimiter": ",",
        "quote": "\"",
        "lineDelimiter": "\r\n",
        "escape": "\"",
        "comment": "#",
        "extractHeader": True,
        "trimHeader": True,
        "skipFirstLine": False,
        "autoGenerateColumnNames": False
    }
}

def authenticate():
    auth_url = f"{DREMIO_API_URL}/apiv2/login"
    response = requests.post(auth_url, json={"userName": DREMIO_USERNAME, "password": DREMIO_PASSWORD})
    if response.status_code == 200:
        token = response.json()['token']
        return token
    else:
        raise Exception(f"Failed to authenticate: {response.text}")

# Send request to set folder format

def format_folder(token):
    headers = {
    "Authorization": f"_dremio {token}",
    "Content-Type": "application/json"
    }
    
    url = f"{DREMIO_API_URL}/api/v3/catalog/{id}"
    response = requests.post(url, headers=headers, data=json.dumps(payload))

    # Check the response
    if response.status_code == 200:
        print("Successfully set format options for the dataset.")
    else:
        print(f"Failed to set format options: {response.text}")

# Main
if __name__ == "__main__":
    token = authenticate()
    format_folder(token)