## Set Parameters
while getopts c:w:e: flag
do
	case "${flag}" in
		c) critmem=${OPTARG};;
		w) warnmem=${OPTARG};;
		e) email=${OPTARG};;
	esac
done

## Set the value "musage", where you call the command "free" to monitor Memory utilization, get the % of currently utilized memory and make it round to whole a number
musage=$( free | awk '/Mem/{printf("RAM Usage: %.2f%\n"), $3/$2*100}' | awk '{print $3}' | cut -d"." -f1)

## Check if user gave the 3 require parameters, if not, remind user of required parameters
if [[ -z $critmem ] || [[ -z $warnmem ]] || [[ -z $email ]]
	printf "\n\n Please flag respective parameters: \n\n"
	printf "Critical Memory: Indicated by using -c. What % of memory will be treated as critical levels. Example: -c \'90\'"
	printf "Warning Memory: Indicated by using -w. What % of memory will be treated as moderate levels which deserve a warning. Example: -w \'50\'"
	printf "Please note that Warning memory has to be a lower number than Critical memory.\n\n"
	printf "Email Address: The email address that will receive a warning email if memory utilization exceeds critical thresholds. Example: -e \'example@mail.com\."
	
## Check if user gave a higher warning level than critical level, if this is the case, script is ended and user is reminded of this requirement.
		else
			if [ $warnmem -ge $critmem ]; then
				echo "Your warning parameter is greater or equal to your critical parameter, please enter the proper values and try again."
				
## Checks if memory utilization if higher than user specified warning level, if this is the case, send out a warning message
				else
					if [ $musage -ge $warnmem ]; then
						echo "Warning: You are currently utilizing " %$musage " of your memory, you are reaching significantly high levels"
						
## Checks if memory utilization if higher than user specified critical level, if this is the case, send out a critical message
						else
							if [ $musage -ge $critmem ]; then
								echo "CRITICAL: YOU ARE CURRENTLY UTILIZING " %$musage " OF YOUR MEMORY!!!"
								
## If current utilized memory is below both warning and critical levels, send out informational message
								else
									echo "You are currently utilizing " %$musage " of your memory, this is within expected levels"
							fi
					fi
					
			fi
fi

	
	

