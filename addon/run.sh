#!/usr/bin/env bashio

set +x


# Create main config
CONFIG_MQTT_HOST=$(bashio::config 'mqtt_broker_address')
CONFIG_MQTT_PORT=$(bashio::config 'mqtt_port')
CONFIG_MQTT_TOPIC=$(bashio::config 'mqtt_topic')
CONFIG_MQTT_USERNAME=$(bashio::config 'mqtt_username')
CONFIG_MQTT_PASSWORD=$(bashio::config 'mqtt_password')
CONFIG_API_URL=$(bashio::config 'api_url')
CONFIG_API_USERNAME=$(bashio::config 'api_username')
CONFIG_API_PASSWORD=$(bashio::config 'api_password')

echo "Preparing to run violett-mqtt-ha-addon"
echo "MQTT_HOST: $CONFIG_MQTT_HOST:$CONFIG_MQTT_PORT"
echo "MQTT_TOPIC: $CONFIG_MQTT_HOST:$CONFIG_MQTT_TOPIC"
echo "MQTT_USERNAME: $CONFIG_MQTT_USERNAME"
echo "API_URL: $CONFIG_API_URL"
echo "API_USERNAME: $CONFIG_API_USERNAME"

sed -i "s/__MQTT_HOST__/${CONFIG_MQTT_HOST}/g" ./options.yaml
sed -i "s/__MQTT_PORT__/${CONFIG_MQTT_PORT}/g" ./options.yaml
sed -i "s/__MQTT_TOPIC__/${CONFIG_MQTT_TOPIC}/g" ./options.yaml
sed -i "s/__MQTT_USERNAME__/${CONFIG_MQTT_USERNAME}/g" ./options.yaml
sed -i "s/__MQTT_PASSWORD__/${CONFIG_MQTT_PASSWORD}/g" ./options.yaml
sed -i "s/__API_URL__/${CONFIG_API_URL}/g" ./options.yaml

echo "Generated Config"
cat ./options.yaml

python addon.py
