#!/bin/bash
# This bash script has to be called with three parameters. It will execute tests against localhost:PORT, will write rsults in LOGFILE and will do so until the file CHECKFORENDTESTFILE exists
# STAGE can either be Production or any other value. this will cause the script to either add nor not add the Dynatrace X-Dynatrace header (only happens in non-prod)
# ./loadtest.sh PORT LOGFILE CHECKFORENDTESTFILE MAXTIMEINSECONDS STAGE
# here is an example
# ./loadtest.sh 80 mytestlog.log endloadtestforport80.txt 60 Staging

echo "Load Test Launched with the following settings PORT=$1, LOGFILE=$2, CHECKFORENDTESTFILE=$3, MAXTIMEINSECONDS=$4, STAGE=$5"  >> ./$2

# Calculate how long this test maximum runs!
currTime=`date +%s`
timeSpan=$4
endTime=$(($timeSpan+$currTime))

while [ ! -f ./$3 -a $currTime -lt $endTime ];
do
  # In Production we sleep less which means we will have more load
  # In Testing we also add the x-dynatrace HTTP Header so that we can demo our "load testing integration" options using Request Attributes!

  if [[ $5 == *"Production"* ]]; then
    sleep 2;
    startTime=`date +%s`
    curl -s "http://localhost:$1/" -o /dev/nul
    curl -s "http://localhost:$1/version" -o /dev/nul
    curl -s "http://localhost:$1/api/echo?text=This is from a production user" -o /dev/nul
    curl -s "http://localhost:$1/api/invoke?url=http://www.dynatrace.com" -o /dev/nul
    curl -s "http://localhost:$1/api/invoke?url=http://blog.dynatrace.com" -o /dev/nul
  else
    sleep 5;
    startTime=`date +%s`
    curl -s "http://localhost:$1/" -H "x-dynatrace: NA=Test.Homepage;" -o /dev/nul
    curl -s "http://localhost:$1/version" -H "x-dynatrace: NA=Test.Version;" -o /dev/nul
    curl -s "http://localhost:$1/api/echo?text=This is from a testing script" -H "x-dynatrace: NA=Test.Echo;" -o /dev/nul
    curl -s "http://localhost:$1/api/invoke?url=http://www.dynatrace.com" -H "x-dynatrace: NA=Test.Invoke;" -o /dev/nul
  fi

  currTime=`date +%s`
  echo "$currTime;$(($currTime-$startTime))" >> $2
done;
exit 0