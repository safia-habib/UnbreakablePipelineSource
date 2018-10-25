#!/bin/bash
cd /home/Unbreakablepipeline/Demo/app
pm2 stop all &> pm2stop.log
pm2 delete all &> pm2delete.log
exit 0