# Weston Robot Documentation Source

## Install sphinx

```
$ pip install -U Sphinx
```

## Setup the development repository

```
$ git clone --recursive https://github.com/westonrobot/wrdocs.git
$ cd wrdocs/build
$ git clone -b gh-pages https://github.com/westonrobot/wrdocs.git html
```

## Build with sphinx docker

Following instructions [here](https://docs.docker.com/engine/install/ubuntu/) to install docker engine first.

```
$ sudo docker run --rm -v ~/Workspace/weston_robot/devel/wrdocs:/docs sphinxdoc/sphinx make html
```