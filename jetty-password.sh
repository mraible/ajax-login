#!/bin/bash

# look for JETTY_HOME
if [ -z "$JETTY_HOME" ] 
then
  cd $(dirname "$0")
  JETTY_HOME_1=$(pwd)
  cd - > /dev/null
  JETTY_HOME_1=$(dirname "$JETTY_HOME_1")
  JETTY_HOME=${JETTY_HOME_1} 
fi

java -cp $JETTY_HOME/lib/jetty-http-7.0.1.v20091125.jar:\
$JETTY_HOME/lib/jetty-util-7.0.1.v20091125.jar \
org.eclipse.jetty.http.security.Password $*
