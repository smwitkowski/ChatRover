FROM osrf/ros:humble-desktop as base
ENV rosdistro=humble
SHELL ["/bin/bash", "-c"]


# Create colcon workspace with dependencies
RUN mkdir -p /chatrover
COPY ./src /chatrover/src

# Set up rosdep
WORKDIR /chatrover
RUN source /opt/ros/humble/setup.bash \
    && apt-get update -y \
    && rosdep update \
    && rosdep install --rosdistro $rosdistro --from-paths src --ignore-src -r -y \
    && colcon build --symlink-install