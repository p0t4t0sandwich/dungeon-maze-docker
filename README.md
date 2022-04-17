# dungeon-maze-docker
## Why?
I came accross [timvisee](https://dev.bukkit.org/members/timvisee/reputation) and [Xephi59](https://dev.bukkit.org/members/xephi59/followers)'s [Dungeon Maze plugin](https://dev.bukkit.org/projects/dungeon-maze) for Minecraft 1.12.2, and decided I would like to add some dungeons to one of my 1.18.2 servers. I did a bit of digging and came across [Brettflan](https://dev.bukkit.org/members/brettflan/reputation)'s [WorldBborder plugin](https://dev.bukkit.org/projects/worldborder) that allows simple and relient chunk pregen. With some trial and error and a bit of Docker know-how, I've managed to automate the process to make dungeon world resets a breeze. You simply direct the Docker volume to wherever you want the file to be saved and boom, you have a fresh, randomly generated dungeon world. It's all self contained and leaves no trace, which means the only data saved is the world data. **This is not a production server!**
## How do you get started?
First off, you'll need either [Docker](https://docs.docker.com/engine/install/) or [Docker-Compose](https://docs.docker.com/compose/install/) to run the container (or any equivilent container host).
# Setup
## Docker Run Command
```shell
docker run \
  -e MEM=1024 \
  -e RADIUS=1000 \
  -e OUTPUT_DIR=world_file \
  -v /PATH-TO-OUPUT-FOLDER:/output \
  -p 0.0.0.0:25565:25565 \
  p0t4t0sandwich/dungeon-maze-docker
```
## Parameters
* `-e MEM=1024` Amount of RAM to dedicate to the internal minecraft server in MB.
* `-e RADIUS=1000` Radius you wish to pregenerate. Origin is 0, 0.
* `-e OUTPUT_DIR=world_file` The name of the worldfile the program will output.
* `-v /PATH-TO-OUPUT-FOLDER:/output` Path that the new worldfile will be output to.
* `-p 0.0.0.0:25565:25565` Path that the new worldfile will be output to.
## Docker-Compose Example
```yaml
version: "3.8"
services:
  dungeom-maze-docker:
    image: p0t4t0sandwich/dungeon-maze-docker
    container_name: dungeom-maze-docker
    environment:
      - MEM=1024                       # Amount of RAM to dedicate to the internal minecraft server in MB.
      - RADIUS=1000                    # Radius you wish to pregenerate. Origin is 0, 0.
      - OUTPUT_DIR=world_file          # The name of the worldfile the program will output.
    volumes:
      - /PATH-TO-OUPUT-FOLDER:/output  # Path that the new worldfile will be output to.
    ports:
      - 0.0.0.0:25565:25565            # Port to join the MC server if you wish to monitor it while it runs.
```
