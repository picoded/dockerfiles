#!/bin/bash
java -jar slave.jar -jnlpUrl $JENKINS_HOST/computer/$JENKINS_SLAVE_NAME/slave-agent.jnlp -secret $JENKINS_SLAVE_SECRET