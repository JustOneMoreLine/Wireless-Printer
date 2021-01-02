#!/bin/bash
### BEGIN INIT INFO
#Provides:		wirepri
#Required-Start:	$all
#Required-Stop:
#Default-Start:		2 3 4 5
#Default-Stop:
#Short-Description:	An adapter to let wireless printer access from WAN
### END INIT INFO

currentPrinting="";
setup() {
	checkPrinterStat;
}

checkPrinterStat() {
	if [ -z `lpstat -W not-completed` ];
	then
		echo "Printer is free, asking for job";
		setPrintJobDone;
		askForJob;
	else
		echo "Printer is on going";
		chillTime;
	fi;
}

setPrintJobDone() {
	if [ -z $currentPrinting ];
	then
		#do nothing
		echo "currPrint is empty";
	else
		echo "Done printing $currentPrinting";
		curl "http://wirepri.herokuapp.com/done/$currentPrinting";
		currentPrinting="";
	fi
}

askForJob() {
	downloadURL=`curl "http://wirepri.herokuapp.com/requestJob"`;
	if [ -z ${downloadURL} ];
	then
		echo "No job right now, gonna chill";
		chillTime;
	else
		echo "New job les go";
		printThis ${downloadURL};
	fi;
}

printThis() {
	echo "${1}"
	curl "${1}" | lp;
	currentPrinting="${1:42}"
	echo "Now Printing $currentPrinting";
	chillTime;
}

chillTime() {
	sleep 5;
	checkPrinterStat;
}

case "$1" in
	start)
		echo "Starting WirePriWAN service"
		setup
		;;
	stop)
		echo "Stopping WirePriWAN service"
		;;
	*)
		echo "Usage: /etc/init.d/wirepriWANservice.sh {start|stop}"
		exit 1
		;;
esac
exit 0
