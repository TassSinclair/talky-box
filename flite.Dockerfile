FROM debian:buster-slim
RUN apt-get update \
  && apt-get install -y alsa-utils flite python3 python3-pip \
  && rm -rf /var/lib/apt/lists/* \
  && pip3 install paho-mqtt
ENV APLAY_DEVICE="sysdefault:CARD=PCH"
ENV MQTT_HOST="localhost"
ENV MQTT_PORT="1883"
ENV MQTT_SUBSCRIBE_TOPIC_ROOT="talky-box"
CMD ["python3", "/data/go-flite.py"]