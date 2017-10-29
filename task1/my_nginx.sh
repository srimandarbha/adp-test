#!/bin/bash

site_container_status=$(docker ps  | awk '{print $NF}' | egrep -c 'site')

if [ $site_container_status -ne 1 ]; then

		/bin/docker run -i -t --name site -p 80:80 -v /vagrant:/usr/share/nginx/html -d my_nginx && echo "site container started"

else

		echo "site container running"

fi
