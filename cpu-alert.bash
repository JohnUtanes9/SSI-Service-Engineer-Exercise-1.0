## Set Parameters
while getopts c:w:e: flag
do
	case "${flag}" in
		c) critcpu=${OPTARG};;
		w) warncpu=${OPTARG};;
		e) email=${OPTARG};;
	esac
done

## Set the value "cusage", where you call the command "free" to monitor CPU utilization, get the % of currently utilized CPU and make it round to whole a number
cusage=$( top -b n 1 | grep Cpu | awk '{print 1-$8}'| cut -d"." -f1)

## Check if user gave the 3 require parameters, if not, remind user of required parameters
if [[ -z $critcpu ] || [[ -z $warncpu ]] || [[ -z $email ]]
	printf "\n\n Please flag respective parameters: \n\n"
	printf "Critical CPU: Indicated by using -c. What % of CPU will be treated as critical levels. Example: -c \'90\'"
	printf "Warning CPU: Indicated by using -w. What % of CPU will be treated as moderate levels which deserve a warning. Example: -w \'50\'"
	printf "Please note that Warning CPU has to be a lower number than Critical CPU.\n\n"
	printf "Email Address: The email address that will receive a warning email if CPU utilization exceeds critical thresholds. Example: -e \'example@mail.com\."
	
## Check if user gave a higher warning level than critical level, if this is the case, script is ended and user is reminded of this requirement.
		else
			if [ $warncpu -ge $critcpu ]; then
				echo "Your warning parameter is greater or equal to your critical parameter, please enter the proper values and try again."
				
## Checks if CPU utilization if higher than user specified warning level, if this is the case, send out a warning message
				else
					if [ $cusage -ge $warncpu ]; then
						echo "Warning: You are currently utilizing " %$cusage " of your CPU, you are reaching significantly high levels"
						
## Checks if CPU utilization if higher than user specified critical level, if this is the case, send out a critical message
						else
							if [ $cusage -ge $critcpu ]; then
								echo "CRITICAL: YOU ARE CURRENTLY UTILIZING " %$cusage " OF YOUR CPU!!!"
								
## If current utilized CPU is below both warning and critical levels, send out informational message
								else
									echo "You are currently utilizing " %$cusage " of your CPU, this is within expected levels"
							fi
					fi
					
			fi
fi

	
	

