# check_dremio_status.py
import requests
import time

def check_dremio_status():
    url = "http://localhost:9047/api/"
    while True:
        try:
            response = requests.get(url)
            if response.status_code == 200:
                print("Dremio is up and running!")
                return True
            else:
                print(f"Waiting for Dremio... Status code: {response.status_code}")
        except requests.ConnectionError:
            print("Dremio is not reachable. Retrying...")
        time.sleep(5)