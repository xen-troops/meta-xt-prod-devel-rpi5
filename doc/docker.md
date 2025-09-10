## How to install and use Docker for building

Install Docker according to the following manuals:

https://docs.docker.com/engine/install/ubuntu/

https://docs.docker.com/engine/install/linux-postinstall/

Pay attention to the section "Manage Docker as a non-root user", as it is critical
for the proper usage of the container.

We assume that you have already cloned the repo with sources and the `doc/` folder,
which contains `Dockerfile`.

Build Docker image using:

```
docker build . -f doc/Dockerfile --build-arg USER_ID="$(id -u)" --build-arg USER_GID="$(id -g)" -t xtbuilder
```
if your user has uid/gid equal 1000 you may omit `--build-arg` parameters.

Run Docker image
```
docker run --network=host -v <directory with rpi5.yaml>:/home/builder/workspace -it --rm xtbuilder
```

Please go ahead with the original build manual.
