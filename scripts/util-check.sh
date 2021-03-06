#!/bin/sh

# Ensures that utility files end with -utils.ts

accepted_util_extension="-utils.ts"
banned_util_extensions=("-util.ts" ".util.ts" ".utils.ts" ".utility.ts" "-utility.ts" ".utilities.ts" "-utilities.ts")
changed_files=$@
invalid_files=""

yellow="\033[0;33m"
green="\033[0;32m"
no_color="\033[0m"

function check_for_banned_name() {
    changed_file=$1
    for i in "${banned_util_extensions[@]}"
    do
        banned_util_extension=$i
        if [[ $changed_file == *$banned_util_extension ]]
        then
            invalid_files="$invalid_files $changed_file"
        fi
    done
}

for changed_file in ${changed_files}
do
  check_for_banned_name $changed_file
done

invalid_files_count=${#invalid_files}

if [ $invalid_files_count -ne 0 ]
then   
    printf "\nUtility files should end with $green\"$accepted_util_extension\"$no_color\n\n"
    printf "Files to rename:\n================\n"
    for invalid_file in ${invalid_files}
    do
        printf "$yellow$invalid_file\n"
    done
    printf "$no_color\n"
    exit 1
fi

exit 0
