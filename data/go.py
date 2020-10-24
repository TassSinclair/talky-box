import os
import subprocess
from subprocess import Popen, PIPE
import json
import paho.mqtt.client as mqtt

# festival_server = Popen(["festival", "--server"])
# print(festival_server.pid)
# subprocess.call(["festival_client", "--ttw", "--output", "/src/egg.wav"])
# festival_server.terminate()

def on_connect(client, userdata, flags, rc):
    print("Connected with result code {}".format(rc))
    client.subscribe(os.environ.get('MQTT_SUBSCRIBE_TOPIC'))

def on_message(client, userdata, msg):
    data = json.loads(msg.payload)
    message = data["message"]
    if "playSoundBefore" in data:
         play_sound_before = data["playSoundBefore"]
         subprocess.run(["aplay", "/data/{}.wav".format(play_sound_before)])
    # text2wave = Popen(["text2wave", "-o", "/src/{}.wav".format(data["output"])], stdin=PIPE)
    # text2wave.communicate(input=message.encode("utf-8"))
    festival = Popen(["festival", "--tts",], stdin=PIPE)
    festival.communicate(input = message.encode("utf-8"))
    if "playSoundAfter" in data:
         play_sound_before = data["playSoundAfter"]
         subprocess.run(["aplay", "/data/{}.wav".format(play_sound_before)])

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message
client.connect(os.environ.get('MQTT_HOST'), int(os.environ.get('MQTT_PORT')), 60)

client.loop_forever()
