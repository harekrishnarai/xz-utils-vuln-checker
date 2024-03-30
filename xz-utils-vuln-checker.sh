#!/bin/bash

echo "
                              __     _     __        
   _  __ ____         __  __  / /_   (_)   / /   _____
  | |/_//_  / ______ / / / / / __/  / /   / /   / ___/
 _>  <   / /_/_____// /_/ / / /_   / /   / /   (__  ) 
/_/|_|  /___/       \__,_/  \__/  /_/   /_/   /____/  
                                                      
							Hare Krishna Rai (0xblurr3d)               
 _   __  __  __   / /   ____          _____   / /_   ___   _____   / /__  ___    _____
| | / / / / / /  / /   / __ \ ______ / ___/  / __ \ / _ \ / ___/  / //_/ / _ \  / ___/
| |/ / / /_/ /  / /   / / / //_____// /__   / / / //  __// /__   / ,<   /  __/ / /    
|___/  \__,_/  /_/   /_/ /_/        \___/  /_/ /_/ \___/ \___/  /_/|_|  \___/ /_/     
(CVE-2024-3094)                                                                          
"

# Function to print text in red color
print_red() {
    printf "\033[1;31m$1\033[0m\n"
}

# Function to print text in green color
print_green() {
    printf "\033[1;32m$1\033[0m\n"
}
print_blue() {
    printf "\033[1;34m$1\033[0m\n"
}

print_help() {
    print_blue "Usage: ./xz_vuln_checker.sh [options]"
    print_blue "Options:"
    print_blue "  -h, --help          Display this help message"
    print_blue "  -s, --summary       Display a short summary about CVE-2024-3094"
    exit 0
}
# Print CVE-2024-3094 summary
print_cve_summary() {
    echo "Description:"
    echo "Malicious code was discovered in the upstream tarballs of xz, starting with version 5.6.0. Through a series of complex obfuscations, the liblzma build process extracts a prebuilt object file from a disguised test file existing in the source code, which is then used to modify specific functions in the liblzma code. This results in a modified liblzma library that can be used by any software linked against this library, intercepting and modifying the data interaction with this library."
    echo ""
    echo "Resources:"
    echo "1. Red Hat: https://access.redhat.com/security/cve/CVE-2024-3094"
    echo "2. Ars Technica: https://arstechnica.com/security/2024/03/backdoor-found-in-widely-used-linux-utility-breaks-encrypted-ssh-connections/"
    echo "3. AWS: https://aws.amazon.com/security/security-bulletins/AWS-2024-002/"
    echo "12. Dark Reading: https://www.darkreading.com/vulnerabilities-threats/are-you-affected-by-the-backdoor-in-xz-utils"
    echo "15. Tenable Blog: https://www.tenable.com/blog/frequently-asked-questions-cve-2024-3094-supply-chain-backdoor-in-xz-utils"
    exit 0
}
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    print_help
fi

# Check for summary option
if [[ "$1" == "-s" || "$1" == "--summary" ]]; then
    print_cve_summary
fi
echo "[+] Initiating vulnerability check..."
sleep 1
echo "[+] Detecting package manager..."
# Detect package manager
if command -v apt-get &>/dev/null; then
    PKG_MANAGER="apt-get"
elif command -v yum &>/dev/null; then
    PKG_MANAGER="yum"
elif command -v zypper &>/dev/null; then
    PKG_MANAGER="zypper"
else
    echo "Unsupported package manager. Exiting."
    exit 1
fi

sleep 1
echo "[+] Getting xz-utils version..."
# Get xz-utils version
case $PKG_MANAGER in
    apt-get)
        version=$(dpkg -l | grep "xz-utils" | awk '{print $3}')
        ;;
    yum)
        version=$(rpm -qa | grep "xz" | awk '{print $1}')
        ;;
    zypper)
        version=$(rpm -qa | grep "xz" | awk '{print $1}')
        ;;
esac

sleep 1

# Check if vulnerable version is installed
echo "[+] Checking xz-utils version for vulnerabilities..."

# Check if vulnerable version is installed
if [[ "$version" == *"5.6.0"* || "$version" == *"5.6.1"* ]]; then
    set -eu

    # find path to liblzma used by sshd
    path="$(ldd $(which sshd) | grep liblzma | grep -o '/[^ ]*')"

    # does it even exist?
    if [ "$path" == "" ]
    then
            print_green "You appear to be safe."
            exit
    fi

    # check for function signature
    if hexdump -ve '1/1 "%.2x"' "$path" | grep -q f30f1efa554889f54c89ce5389fb81e7000000804883ec28488954241848894c2410
    then
            print_red probably vulnerable to CVE-2024-3094
    else
            print_green "You appear to be safe."
    fi

else
    print_green "You appear to be safe."
fi
