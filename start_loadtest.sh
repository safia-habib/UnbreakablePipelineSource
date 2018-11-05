#!/bin/bash
echo "Load Test Launched in Deployment Group" $DEPLOYMENT_GROUP_NAME
#end=$(( SECONDS+300 ))
while [ true ];
do  
  # In Production we sleep less which means we will have more load
  # In Testing we also add the x-dynatrace HTTP Header so that we can demo our "load testing integration" options using Request Attributes!
  if [[ $DEPLOYMENT_GROUP_NAME == *"Production"* ]]; then
    curl -s "http://localhost:8080/" -o nul >> loadtest.log
    curl -s "http://localhost:8080/version" -o nul >> loadtest.log
    curl -s "http://localhost:8080/api/echo?text=This is from a production user" -o nul >> loadtest.log
    curl -s "http://localhost:8080/api/invoke?url=http://www.dynatrace.com" -o nul >> loadtest.log
    curl -s "http://localhost:8080/api/invoke?url=http://blog.dynatrace.com" -o nul >> loadtest.log

    sleep 2;
  else
    curl -s "http://localhost:8080/" -H "x-dynatrace: NA=Test.Homepage;" -o nul >> loadtest.log
    curl -s "http://localhost:8080/version" -H "x-dynatrace: NA=Test.Version;" -o nul >> loadtest.log
    curl -s "http://localhost:8080/api/echo?text=This is from a testing script" -H "x-dynatrace: NA=Test.Echo;" -o nul >> loadtest.log
    curl -s "http://localhost:8080/api/invoke?url=http://www.dynatrace.com" -H "x-dynatrace: NA=Test.Invoke;" -o nul >> loadtest.log
    
    sleep 5;
  fi
done;
exit 0