sort -t ":" -k3n /etc/passwd | awk -F ':' '{print "username:"$1"\nuuid:"$3}'

