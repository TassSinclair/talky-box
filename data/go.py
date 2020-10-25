import os
import subprocess
from subprocess import Popen, PIPE
import json
import paho.mqtt.client as mqtt

def on_connect(client, userdata, flags, rc):
    print("connected with result code {}".format(rc))
    print("subscribing to topic root {}".format(os.environ.get('MQTT_SUBSCRIBE_TOPIC_ROOT')))
    client.subscribe("{}/#".format(os.environ.get('MQTT_SUBSCRIBE_TOPIC_ROOT')))

def on_message(client, userdata, msg):
    print("receieved message on topic {}".format(msg.topic))
    if msg.topic == "{}/post/say".format(os.environ.get('MQTT_SUBSCRIBE_TOPIC_ROOT')):
        on_say(json.loads(msg.payload))
    elif msg.topic == "{}/post/play".format(os.environ.get('MQTT_SUBSCRIBE_TOPIC_ROOT')):
        on_play(json.loads(msg.payload))

def on_say(data):
    if "playSoundBefore" in data:
         play_sound_before = data["playSoundBefore"]
         subprocess.run(["aplay", "/data/{}.wav".format(play_sound_before)])
    if "message" in data:
        message = data["message"]
        festival = Popen(["festival", "--tts",], stdin=PIPE)
        festival.communicate(input = message.encode("utf-8"))
    if "playSoundAfter" in data:
         play_sound_after = data["playSoundAfter"]
         subprocess.run(["aplay", "/data/{}.wav".format(play_sound_after)])

def on_play(data):
    if "play" in data:
         play_sound = data["play"]
         subprocess.run(["aplay", "/data/{}.wav".format(play_sound)])

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message
client.connect(os.environ.get('MQTT_HOST'), int(os.environ.get('MQTT_PORT')), 60)

client.loop_forever()
