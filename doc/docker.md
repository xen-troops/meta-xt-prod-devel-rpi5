## Using Docker to Build the Project

1. Install Docker by following the official guide:  
   https://docs.docker.com/engine/install/

2. Build the Docker image:  
   ```
   docker build -f doc/Dockerfile --build-arg USER_ID="$(id -u)" --build-arg USER_GID="$(id -g)" -t xtbuilder .
   ```

3. Run the container on Linux or macOS (with mount):  
   ```
   docker run --network=host -v $(pwd):/home/builder/workspace -it --rm xtbuilder
   ```

**Note for macOS users:**  
Bind mounts can cause permission issues with BitBake’s UNIX sockets. To avoid this, run the same container command **without** the `-v` mount and clone the repo inside the container:

```bash
docker run --network=host -it --rm xtbuilder
```

Then inside the container:
```bash
git clone https://github.com/xen-troops/meta-xt-prod-devel-rpi5.git .
```

> The container starts in `/home/builder/workspace` (set in the Dockerfile). You can clone directly into the current directory.  
> Use `docker cp` after the build to copy artifacts out if needed.


Once your container is running, continue following the original build manual for the next steps.
