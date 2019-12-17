#!/bin/bash
set -e
dir=$(cd $(dirname "${BASH_SOURCE[0]:-$0}") && pwd)
ros_workspace=$(catkin locate)
catkin config $@ --cmake-args "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
cp -f "${dir}/.ycm_extra_conf.py" "${ros_workspace}/.ycm_extra_conf.py"
