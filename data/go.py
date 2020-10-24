import os
from subprocess import Popen, PIPE
import json
import paho.mqtt.client as mqtt

# festival_server = Popen(["festival", "--server"])
# print(festival_server.pid)
# subprocess.call(["festival_client", "--ttw", "--output", "/src/egg.wav"])
# festival_server.terminate()

def on_connect(client, userdata, flags, rc):
    print("Connected with result code {}".format(rc))
    client.subscribe("talky-box/#")

def on_message(client, userdata, msg):
    print(msg.topic+" "+str(msg.payload))
    data = json.loads(msg.payload)
    message = data["message"]
    text2wave = Popen(["text2wave", "-o", "/src/{}.wav".format(data["output"])], stdin=PIPE)
    text2wave.communicate(input=message.encode("utf-8"))

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect(os.environ.get('MQTT_HOST'), os.environ.get('MQTT_PORT'), 60)

client.loop_forever()