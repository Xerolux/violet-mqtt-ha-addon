import json
import requests
import paho.mqtt.publish as publish
import time
import os

def get_json_from_api(api_url, username, password):
    try:
        response = requests.get(api_url, auth=(username, password), verify=True)

        if response.status_code == 200:
            json_data = response.json()
            return json_data
        else:
            print(f"Error: {response.status_code}")
            return None

    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
        return None

def publish_to_mqtt(broker_address, port, base_topic, payload, username, password):
    for key, value in payload.items():
        topic = f"{base_topic}/{key}"
        publish.single(topic, payload=json.dumps(value), qos=1, retain=False,
                       hostname=broker_address, port=port, auth={'username': username, 'password': password})

def main():
    config_path = "/config/config.json"
    config = json.load(open(config_path))

    while True:
        json_data = get_json_from_api(config["api_url"], config["mqtt_username"], config["mqtt_password"])

        if json_data:
            publish_to_mqtt(config["mqtt_broker_address"], config["mqtt_port"], config["base_mqtt_topic"],
                            json_data, config["mqtt_username"], config["mqtt_password"])
            print("Data published to MQTT successfully.")
        else:
            print("Failed to retrieve JSON data from the API.")

        time.sleep(30)

if __name__ == "__main__":
    main()
