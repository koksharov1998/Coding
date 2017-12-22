if [[ "$1" = "-h" || "$1" = "--help" ]]; then
	echo 'If there are no arguments, then the script outputs a clean path.'
	echo 'Else the script outputs a clean path for arguments.'
	echo 'NAME OF FOLDERS SHOULD NOT CONTAIN DOUBLE.'
	echo 'Take the argument in quotes.'
	exit
fi
if  [[ ! -z "$1" ]]
then
	path="$1"
else
	path="$PATH"
fi
IFS=:
for dir in $path; do
	if [[ ! -d "$dir" ]]; then
		continue
	fi
	for file in "$dir"/*; do
		if [[ -x $file && ! -d $file ]]; then
			dir=$(echo "$dir" | grep -v '^\.')
			clearPath="$clearPath:$dir"
			break
		fi
	done
done
clearPath=`echo "$clearPath" | sed 's/^:*//'`
clearPath=`echo "$clearPath" | sed 's/:*$//'`
echo "$clearPath"
