alias bdev-relinkDotfiles='
  bash $BDEV/sh/link_dotfiles.sh
'




# !!NOT WORKING!! 
# WSL: Add nameserver to resolv.conf
# When WSL can't connect to the internet, we need to find out the DNS Server in form X.X.X.X by calling
# >>> ipconfig /all
# in a windows terminal. Copy the DNS Server from the "* WiFi" entry. Then pass 
# "X.X.X.X" 
# to this function. It will then make resolv.conf writeable (chattr), append the new server ("nameserver X.X.X.X"), and make resolv.conf unwritable again.
# Method from here: https://gist.github.com/coltenkrauter/608cfe02319ce60facd76373249b8ca6
# bdev-addNameserver () {
#   if [ -n "$1" ]
#   then
#     sudo chattr -i /etc/resolv.conf
#     echo "nameserver "$1 | sudo tee -a resolv.conf
#     sudo chattr +i /etc/resolv.conf
#     echo "cat /etc/resolv.conf"
#     cat /etc/resolv.conf
#   else
#     echo "Error: missing DNS server string. Please pass the WiFi DNS Server as 'X.X.X.X' e.g. > bdev-addNameserver '192.32.254.143'"
#   fi
# }

