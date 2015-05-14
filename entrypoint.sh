#! /bin/bash


#!/usr/bin/bash

read -r -d '' HELP <<EOF
EOF
OPTIONS:
-d    Enable develop enviroment
-s    Start containers
-v    Enable verbose output
-n    Only download files (mutually exclusive with -r)
-r    Only remove files (mutually exclusive with -n)
-h    Display this help
EOF

# DECLARE VARIABLES WITH DEFAULT VALUES
color=0
debug=0
verbose=0
download=0
remove=0


OPTIND=1                # Reset in case getopts has been used previously in the shell
invalid_options=();     # Array for invalid options

while getopts ":cdvnrh" opt; do
  echo "Actual opt: $opt"
  case $opt in
    c)
      color=1
      ;;
    d)
      debug=1
      ;;
    v)
      verbose=1
      ;;
    n)
      download=1
      ;;
    r)
      remove=1
      ;;
    h)
      echo "$HELP"
      exit 1
      ;;
   \?)
      invalid_options+=($OPTARG)
      ;;
   *)
      invalid_options+=($OPTARG)
      ;;
  esac
done

# HANDLE INVALID OPTIONS
if [ ${#invalid_options[@]} -ne 0 ]; then
  echo "Invalid option(s):" >&2
  for i in "${invalid_options[@]}"; do
    echo $i >&2
  done
  echo "" >&2
  echo "$HELP" >&2
  exit 1
fi

# SET $1 TO FIRST MASS ARGUMENT, $2 TO SECOND MASS ARGUMENT ETC
shift $((OPTIND - 1))

# HANDLE CORRECT NUMBER OF MASS OPTIONS
if [ $# -ne 2 ]; then
  echo "Correct number of mass arguments are 2"
  echo "" >&2
  echo "$HELP" >&2
  exit 1
fi


# HANDLE MUTUALLY EXCLUSIVE OPTIONS
if [ $download -eq 1 ] && [ $remove -eq 1 ]; then
  echo "Options for download and remove are mutually exclusive" >&2
  echo "$HELP" >&2
  exit 1
fi



echo "color:    $color"
echo "debug:    $debug"
echo "verbose:  $verbose"
echo "download: $download"
echo "remove:   $remove"
echo "\$1:      $1"
echo "\$2:      $2"
