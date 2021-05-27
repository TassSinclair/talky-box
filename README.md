# Talky Box

A Festival instance running inside a Docker container. Plays sound effects and speech in response to posted MQTT messages.

I'm using it as part of my home automation setup. Might not suit your purpose well, but you're welcome to use this as an example.

## Dependencies
* Docker
* MQTT broker
* Linux machine with audio device

## Example via Mosquitto

```
mosquitto_pub -t "talky-box/post/say" -m "{\"message\":\"The coffee machine has finished brewing.\", \"playSoundBefore\": \"announce\"}"
```

<audio controls="controls" src="example.mp3">
    <a href="example.mp3">example.mp3</a>
</audio>

## Example via Home Assistant

`scripts.yaml`
```yaml
announce:
  alias: announce
  sequence:
   - service: script.speak
     data_template:
       message: "{{ message }}"
       soundBefore: announce
speak:
  alias: say
  sequence:
   - service: mqtt.publish
     data:
       topic: "talky-box/post/say"
       payload_template: '{"message":"{{ message }}", "playSoundBefore": "{{ soundBefore }}"}'
```