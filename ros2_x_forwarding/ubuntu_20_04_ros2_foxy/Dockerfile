FROM ubuntu:20.04

#Arguments maybe add defaults?
ARG user
ARG uid
ARG gid
ARG home

# make bash default
SHELL ["/bin/bash", "-c"] 

# install locales
RUN apt-get update -y && apt-get install -y locales

# Configure user env
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set the locale to include UTF-8. UTF-8 compatible locales are needed for install
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Make sure UTF-8 is supported
RUN locale

# Install basic utilities
RUN apt-get -y update && apt-get -y install firefox git nano screen ssh sudo tmux tree vim

# install ROS2:foxy dependencies
RUN apt-get install -y curl gnupg2 lsb-release
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# install ROS2:foxy and things needed for ros development, DEBIAN_FRONTEND is needed to ignore interactive keyboard layout setting while install
RUN apt-get update -y && DEBIAN_FRONTEND=noniteractive apt-get install -y ros-foxy-desktop pip python3-colcon-common-extensions
RUN pip install -U rosdep && \
    rosdep init

# clone user into docker image, add to sudo users needed for xsharing
# the passwd delet is needed to update /etc/shadow otherwise user cannot use sudo
RUN mkdir -p ${home} && \
  echo "${user}:x:${uid}:${gid}:${user},,,:${home}:/bin/bash" >> /etc/passwd && \
  echo "${user}:x:${uid}:" >> /etc/group && \
  echo "${user} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${user}" && \
  chmod 0440 "/etc/sudoers.d/${user}" && \
  usermod -aG sudo ${user} && \
  passwd -d ${user} && \
  chown ${uid}:${gid} -R ${home}

# setup environment of ros for usage
COPY bashrc ${home}/.bashrc
RUN echo "source /opt/ros/foxy/setup.bash" >> ${home}/.bashrc

#switch to user
USER ${user}
