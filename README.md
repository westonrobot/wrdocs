# Weston Robot Documentation Source

## Install sphinx

```
$ pip install -U Sphinx
```

## Setup the development repository

```
$ git clone https://github.com/westonrobot/wrdocs.git
```

## Build with sphinx docker

Following instructions [here](https://docs.docker.com/engine/install/ubuntu/) to install docker engine first.

```
$ sudo docker run --rm -v ~/Workspace/weston_robot/devel/wrdocs:/docs sphinxdoc/sphinx make html
```

## Reference

* https://sphinx-rtd-theme.readthedocs.io/en/stable/demo/demo.html?highlight=color#topics-sidebars-and-rubrics
* https://www.sphinx-doc.org/en/master/usage/configuration.html