FROM debian:buster-slim
ADD http://festvox.org/packed/festival/2.5/voices/festvox_cmu_us_awb_cg.tar.gz /root
RUN apt-get update \
  && apt-get install -y festival festlex-cmu festlex-poslex python3 python3-pip \
  && rm -rf /var/lib/apt/lists/* \
  && tar xf /root/festvox_*.tar.gz -C /root/ \
  && mv /root/festival/lib/voices/* /usr/share/festival/voices/ \
  && echo "(set! voice_default 'voice_cmu_us_awb_cg)" >> /etc/festival.scm \
  && pip3 install paho-mqtt
ENV APLAY_DEVICE="sysdefault:CARD=PCH"
RUN echo "(Parameter.set 'Audio_Command \"aplay -q -c 1 -t raw -f s16 -D ${APLAY_DEVICE} -r \$SR \$FILE\")" >> /etc/festival.scm
ENV MQTT_HOST="localhost"
ENV MQTT_PORT="1883"
ENV MQTT_SUBSCRIBE_TOPIC_ROOT="talky-box"
CMD ["python3", "/data/go.py"]
