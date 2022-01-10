xhost +local:docker
docker run --net=host -h ubuntu_20_04-docker -e DISPLAY --tmpfs /tmp -v /tmp/.X11-unix/:/tmp/.X11-unix:rw -v $HOME/Workspaces/stogl_robotics/test_ws_shared_1/:$HOME/test_ws:rw --name ros2_deb_pkg_user_x11-instance -it ros2_deb_pkg_user_x11 /bin/bash

