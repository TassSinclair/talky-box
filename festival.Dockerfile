FROM debian:buster-slim
#ADD http://festvox.org/packed/festival/2.5/voices/festvox_cmu_us_awb_cg.tar.gz /root
#ADD http://festvox.org/packed/festival/2.5/voices/festvox_cmu_us_slt_cg.tar.gz /root
ENV APLAY_DEVICE="sysdefault:CARD=PCH"
RUN apt-get update \
  && apt-get install -y festival festlex-cmu festlex-poslex python3 python3-pip festvox-us-slt-hts \
  && rm -rf /var/lib/apt/lists/* \
#  && for t in `ls /root/ | grep '.tar.gz'` ; do tar xf /root/$t -C /root/; done \
#  && mv /root/festival/lib/voices/* /usr/share/festival/voices/ \
#  && echo "(set! voice_default 'voice_cmu_us_slt_cg)" >> /etc/festival.scm \
  && echo "(Parameter.set 'Audio_Command \"aplay -q -c 1 -t raw -f s16 -D ${APLAY_DEVICE} -r \$SR \$FILE\")" >> /etc/festival.scm \
  && echo "(set! voice_default 'voice_cmu_us_slt_arctic_hts)" >> /etc/festival.scm \
  && echo "(audio_mode 'async)" >> /etc/festival.scm \
  && pip3 install paho-mqtt
ENV MQTT_HOST="localhost"
ENV MQTT_PORT="1883"
ENV MQTT_SUBSCRIBE_TOPIC_ROOT="talky-box"
CMD ["python3", "/data/go-festival.py"]
