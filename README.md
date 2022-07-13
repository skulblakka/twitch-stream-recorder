# twitch-stream-recorder
A Docker container to automatically record Twitch streams.

## Description
This repository hosts the source code for a Docker container that can automatically record livestreams from Twitch as they go live.
The main component is from [Ancalentari Twitch Stream Recorder](https://github.com/ancalentari/twitch-stream-recorder).

## Requirements
To run this container and record streams from Twitch,
you need to register a dummy app and get a client_id and client_secret. Both is explained in the setup section.

## Setup
Create a `config.py` file in a directory of your choice (you will need to mount this file into the container later):

```bash
root_path = "/opt/recordings"
username = "gronkh"
client_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
client_secret = "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
```

`root_path` - path in the container to where your VODs will be saved to (Don't change this!)  
`username` - name of the streamer you want to record by default (Change this accordingly!)  
`client_id` - you can grab this from [here](https://dev.twitch.tv/console/apps) once you register your application (Replace with your own!)  
`client_secret` - you generate this [here](https://dev.twitch.tv/console/apps) as well, for your registered application (Replace with your own!)

## Usage
Start the container with the following `docker run` command:  
```bash
docker run \
   -v /path/to/config.py:/opt/config.py \
   -v /path/to/recordings:/opt/recordings \
   ghcr.io/stefomat/twitch-stream-recorder:master
```
The options in this command:  
`-v /path/to/config.py:/opt/config.py` Map the created config file to a defined location in the container, so the python script can find it.  
`-v /path/to/recordings:/opt/recordings` Map a folder of your choice to a defined location in the container. This is the place where all recordings will be saved to.  
`ghcr.io/stefomat/twitch-stream-recorder:master` Use the "master" tag for the latest version, that's the GitHub branch from which the Docker images will be built.

You can also run it as a `docker-compose` setup.

```bash
---
version: "2"

services:
  twitch-stream-recorder:
    image: ghcr.io/mkody/twitch-stream-recorder:master
    container_name: twitch-stream-recorder
    volumes:
      - /path/to/config.py:/opt/config.py
      - /path/to/recordings:/opt/recordings
    restart: unless-stopped
```

## Notes
Open TODOs for future improvements:
- [x] Run process as non-root user
- [ ] Add "latest" tag
- [ ] Switch to alpine based images
- [ ] Run GitHub Action on a regular base
- [ ] Separate container tags for the regular built images?
- [ ] How many versions of the image do i want to store on GitHub?
