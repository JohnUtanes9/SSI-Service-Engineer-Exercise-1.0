## Set Parameters
while getopts c:w:e: flag
do
	case "${flag}" in
		c) critdisk=${OPTARG};;
		w) warmdisk=${OPTARG};;
		e) email=${OPTARG};;
	esac
done

## Set the value "dusage", where you call the command "free" to monitor disk utilization, get the % of currently utilized disk and make it round to whole a number
dusage=$( df -P | grep /dev | grep -v -E '(tmp|boot)' | awk '{print $5}' | cut -d"." -f1)

## Check if user gave the 3 require parameters, if not, remind user of required parameters
if [[ -z $critdisk ] || [[ -z $warmdisk ]] || [[ -z $email ]]
	printf "\n\n Please flag respective parameters: \n\n"
	printf "Critical disk: Indicated by using -c. What % of disk utilization will be treated as critical levels. Example: -c \'90\'"
	printf "Warning disk: Indicated by using -w. What % of disk utilization will be treated as moderate levels which deserve a warning. Example: -w \'50\'"
	printf "Please note that Warning disk has to be a lower number than Critical disk.\n\n"
	printf "Email Address: The email address that will receive a warning email if disk utilization exceeds critical thresholds. Example: -e \'example@mail.com\."
	
## Check if user gave a higher warning level than critical level, if this is the case, script is ended and user is reminded of this requirement.
		else
			if [ $warmdisk -ge $critdisk ]; then
				echo "Your warning parameter is greater or equal to your critical parameter, please enter the proper values and try again."
				
## Checks if disk utilization if higher than user specified warning level, if this is the case, send out a warning message
				else
					if [ $dusage -ge $warmdisk ]; then
						echo "Warning: You are currently utilizing " $dusage " of your disk, you are reaching significantly high levels"
						
## Checks if disk utilization if higher than user specified critical level, if this is the case, send out a critical message
						else
							if [ $dusage -ge $critdisk ]; then
								echo "CRITICAL: YOU ARE CURRENTLY UTILIZING " $dusage " OF YOUR disk!!!"
								
## If current utilized disk is below both warning and critical levels, send out informational message
								else
									echo "You are currently utilizing " $dusage " of your disk, this is within expected levels"
							fi
					fi
					
			fi
fi

	
	

