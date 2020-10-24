FROM debian:buster-slim
RUN apt-get update \
  && apt-get install -y festival festvox-us-slt-hts python3 python3-pip \
  && rm -rf /var/lib/apt/lists/* \
  && echo "(set! voice_default 'voice_cmu_us_slt_arctic_hts)" >> /etc/festival.scm \
  && pip3 install paho-mqtt
ENV MQTT_HOST="mqtt.eclipse.org"
ENV MQTT_PORT="1883"
ENV MQTT_SUBSCRIBE_TOPIC="talky-box/post/say"
CMD ["python3", "/data/go.py"]