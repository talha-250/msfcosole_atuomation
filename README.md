# msfcosole_atuomation
This script antomate msfconsonle scaning it will add ip/domain list like domainlist.txt and sets RHOSTS using provided list and also have search option to search for any exploits and use option to use an exploit like use 0, use 1

# Installaction
git clone https://github.com/talha-250/msfcosole_atuomation.git


# Usage:
./msf_a.sh -l <ip_list_file> [-use <value>] [-search <value>]
  -l <ip_list_file>  : Path to the IP list file containing the IP addresses to be processed
  -use <value>       : Custom command to use instead of the default 'use 0' (default is 'use 0')
  -search <value>    : Custom search query instead of the default 'search eternalblue' (default is 'search eternalblue')
  -h                 : Display this help message

This script automates the process of running Metasploit commands against a list of IP addresses.

Steps performed by the script:
1. Reads the IP addresses from the provided IP list file.
2. For each IP address, it runs the following commands in msfconsole:
   a. <custom or default search query>
   b. <custom or default 'use' command>
   c. set RHOSTS <ip_value>
   d. exploit
3. Displays the output of each command for each IP address.

Example usage:
./msf_a.sh -l /path/to/iplist.txt -use 'use 1' -search 'search smb'


                                                                      
