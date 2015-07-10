# httpbin docker
#
# VERSION               0.0.1
#
# Modified from https://gist.github.com/zerodivide1/8186977
#
FROM picoded/ubuntu-python
MAINTAINER Eugene Cheah <picoded@socialoctet.com>

RUN apt-get update && apt-get install -y screen git wget curl build-essential python-setuptools ruby-ronn 

RUN git clone https://github.com/picoded/httpbin.git

RUN cd httpbin && python setup.py build && python setup.py install

EXPOSE 5000

CMD cd httpbin && python -m httpbin.core