xhost +local:docker
docker run --net=host --rm -e DISPLAY --tmpfs /tmp -v /tmp/.X11-unix/:/tmp/.X11-unix:rw -v /<path>/<workspace_name>:/$HOME/<workspace_name:rw -it ros2_deb_pkg_user_x11 /bin/bash

