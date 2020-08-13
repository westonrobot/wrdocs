# in your Dockerfile
FROM sphinxdoc/sphinx

RUN python -m pip install --upgrade pip && pip install sphinx-rtd-theme

WORKDIR /docs
