```bash                            __     _     __        
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

[+] Initiating vulnerability check...
[+] Detecting package manager...
[+] Getting xz-utils version...
[+] Checking xz-utils version for vulnerabilities...

```
## CVE-2024-3094
Malicious code was discovered in the upstream tarballs of xz, starting with version 5.6.0. Through a series of complex obfuscations, the liblzma build process extracts a prebuilt object file from a disguised test file existing in the source code, which is then used to modify specific functions in the liblzma code. This results in a modified liblzma library that can be used by any software linked against this library, intercepting and modifying the data interaction with this library.
### References for CVE-2024-3094
| Resource | URL |
| --- | --- |
| Red Hat | [Link](https://access.redhat.com/security/cve/CVE-2024-3094) |
| Ars Technica | [Link](https://arstechnica.com/security/2024/03/backdoor-found-in-widely-used-linux-utility-breaks-encrypted-ssh-connections/) |
| AWS | [Link](https://aws.amazon.com/security/security-bulletins/AWS-2024-002/) |
| Dark Reading | [Link](https://www.darkreading.com/vulnerabilities-threats/are-you-affected-by-the-backdoor-in-xz-utils) |
| Tenable Blog | [Link](https://www.tenable.com/blog/frequently-asked-questions-cve-2024-3094-supply-chain-backdoor-in-xz-utils) |


## Prerequisites

You need to have a bash shell to run this script. This is typically available on most Unix-like operating systems, including Linux and Mac OS X.


### Installing

To use this script, you can simply download it and give it execute permissions:

```bash
git clone https://github.com/harekrishnarai/xz-utils-vuln-checker
```
```bash
cd xz-utils-vuln-checker
chmod +x xz-utils-vuln-checker.sh
./xz-utils-vuln-checker.sh
```
```
The available options are:
-s, --summary       Display a short summary about CVE-2024-3094
-h, --help: Display the help message
```
