# Codecept JS
#
# VERSION               0.0.1
#
FROM node:6.9
MAINTAINER Eugene Cheah <eugene@picoded.com>

# NPM install the codeceptjs, and WebDriverIO
RUN npm install -g codeceptjs webdriverio selenium-webdriver 
RUN npm install -g mochawesome mocha-junit-reporter

# Make workspace 
RUN mkdir /workspace

# WORKDIR - setting the workspace 
WORKDIR /workspace
VOLUME ["/workspace"]

# The node running
CMD ["codeceptjs", "run"]
