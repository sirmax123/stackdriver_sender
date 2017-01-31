#!/bin/bash


PYTHON="/usr/bin/python"
WORKDIR="/d/containers"
LOG_FILE="/root/sender.log"

{
	inotifywait -r -m ${WORKDIR} -e create -e delete 2>/dev/null | \
	stdbuf -o0 \
	grep -E '*json.log'  | \
    	while read path action file; do
    	    echo "The file '$file' appeared in directory '$path' via '$action'"

			if [ "${action}" = "CREATE" ]
			then
	    		${PYTHON} /root/send_logs.py --file_name=${path}/${file} --log_name=test_log 2>>${LOG_FILE} >>${LOG_FILE} &
			fi

			if  [ "${action}" = "DELETE" ]
			then
        	    kill $(ps -auxfw | grep "${PYTHON} /root/send_logs.py --file_name=${path}/${file}" | grep -v "grep" | awk '{ print $2 }')
			fi
    	done

} >>${LOG_FILE}  2>>${LOG_FILE}
