# Weston Robot Documentation Source

## Setup the development repository

You can put the repository at other places but remember to adjust the docker run command accordingly.

```
$ cd Workspace
$ git clone https://github.com/westonrobot/docs.git
```

## Build with sphinx docker

Following instructions [here](https://docs.docker.com/engine/install/ubuntu/) to install docker engine first.

```
$ sudo docker run --rm -v ~/Workspace/docs:/docs rduweston/sphinx-rtd make html
```

## Reference

* https://sphinx-rtd-theme.readthedocs.io/en/stable/demo/demo.html?highlight=color#topics-sidebars-and-rubrics
* https://www.sphinx-doc.org/en/master/usage/configuration.html
* https://documentation-style-guide-sphinx.readthedocs.io/en/latest/style-guide.html