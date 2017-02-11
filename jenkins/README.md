# Jenkins with add ons

Extended from `jenkins:latest` official repo

Jenkins installed with additional components that we (picoded) commonly used.
`apt-get install -y build-essential ant zip python doxygen curl vim git unzip zip`

With the following environment variable (because we are from Singapore)
`JAVA_OPTS="-Duser.timezone=Asia/Singapore"`

Rest is kept identical with `jenkins:latest`
