FROM debian:buster-slim
RUN apt-get update \
  && apt-get install -y festival festvox-us-slt-hts python3 python3-pip \
  && rm -rf /var/lib/apt/lists/* \
  && echo "(set! voice_default 'voice_cmu_us_slt_arctic_hts)" >> /etc/festival.scm \
  && pip3 install paho-mqtt
RUN echo "defaults.pcm.card 2\ndefaults.ctl.card 2" > /etc/asound.conf
ENV MQTT_HOST="localhost"
ENV MQTT_PORT="1883"
ENV MQTT_SUBSCRIBE_TOPIC_ROOT="talky-box"
CMD ["python3", "/data/go.py"]
