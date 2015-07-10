# echo websocket (nodejs)
#
# VERSION               0.0.1
#
# Modified from http://cjihrig.com/blog/creating-your-own-node-js-websocket-echo-server/
#
FROM picoded/ubuntu-nodejs
MAINTAINER Eugene Cheah <picoded@socialoctet.com>

# Fetch required packages
RUN apt-get update && apt-get install -y git

# Install websockets
RUN npm install websocket

# Exposes port 80
EXPOSE 80

# Copy over the websocket script
COPY ws_server.js ./

# And start up apache and the codebox server
CMD nodejs ws_server.js