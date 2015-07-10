# httpbin docker
#
# VERSION               0.0.1
#
# Modified from https://gist.github.com/zerodivide1/8186977
#
FROM picoded/ubuntu-python
MAINTAINER Eugene Cheah <picoded@socialoctet.com>

# Fetch required packages
RUN apt-get update && apt-get install -y screen git wget curl build-essential python-setuptools ruby-ronn 

# Clone a stable branch
RUN git clone https://github.com/picoded/httpbin.git

# Forces the app to be run at port 80 to public
RUN cd httpbin/httpbin && sed -i "s|app.run()|app.run(host='0.0.0.0',port=80)|g" core.py

# Setup and install
RUN cd httpbin && python setup.py build && python setup.py install

# Exposes port 80
EXPOSE 80

# Execute and run
CMD cd httpbin && python -m httpbin.core