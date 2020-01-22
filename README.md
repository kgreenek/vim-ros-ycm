# vim-ros-ycm

vim-ros-ycm provides the [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe) vim plugin the
information it needs to work within a catkin workspace.

For example, if your catkin package calls a function from another package, you will be able to jump
to the declaration by placing the cursor on the function call and typing `:YcmCompleter GoTo`.

Auto-completion, error checking, and all the other features of YouCompleteMe work as well.

This plugin uses [catkin-tools](https://catkin-tools.readthedocs.io/en/latest/) (i.e. the `catkin`
command). It does not currently support catkin_make or catkin_make_isolated.

It currently enables YouCompleteMe with only C++ packages. Python support is something I would like
to add in the future though.

## System setup

If you haven't already, install ros.

Install rospkg and catkin-tools. On ubuntu:

```bash
sudo apt install python-rospkg python-catkin-tools
```

## Catkin workspace setup

YouCompleteMe uses
[json compilation databases](https://clang.llvm.org/docs/JSONCompilationDatabase.html) to know how
to build C++ files as you edit. In order to make these available, we need to tell catkin to produce
them while building.

NOTE: Be sure you have NOT sourced the setup.sh script for the workspace before running the
following commands.

```bash
cd ~/catkin_ws
source /opt/ros/melodic/setup.sh
catkin clean -y
catkin config --install -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILT_TYPE=RelWithDebInfo
catkin build
```

Of course, replace `~/catkin_ws` with the path to your workspace, and replace `melodic` with your
version of ROS.

You only need to run the catkin config command once. After that, every time you run `catkin build`,
the compilation database files will be updated automatically.

## How to use

You can install vim-ros-ycm as a vim plugin, so it will work globally whenever working in a catkin
workspace, or you can copy the .ycm_extra_conf.py file to the root of your workspace so it will only
affect that workspace.

### As a vim plugin

Simply add this repository as a vim plugin using your favorite plugin manager. Everything will just
work automatically whenever you are editing files within a catkin workspace.

E.g. for [Plug](https://github.com/junegunn/vim-plug), do:

```
call plug#begin('~/.vim/bundle')
Plug 'kgreenek/vim-ros-ycm'
call plug#end()
```

### Copy ycm_extra_conf.py to your workspace root

Another alternative is to copy the .ycm_extra_conf.py file to the root of your workspace.

```bash
cp .ycm_extra_conf.py /path/to/your/catkin_ws
```

YouCompleteMe searches recursively for files named `.ycm_extra_conf.py` in the path above the file
you're currently editing in order to find the extra conf settings.

## The easy way

The [catkin_config.sh](catkin_config.sh) script runs the `catkin config` command and copies the
`.ycm_extra_conf.py` file to the root of your workspace. Simply run it from within your workspace.

```bash
cd ~/catkin_ws
/path/to/vim-ros-ycm/catkin_config.sh --install
```

The `--install` flag and any other flags you provide are all passed to the call to `catkin config`.

If you prefer, you can also copy the catkin_config.sh and .ycm_extra_conf.py scripts to your package
and check it into your repo.
