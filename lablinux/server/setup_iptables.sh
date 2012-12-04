iptables -F

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT 
iptables -A FORWARD -i eth1 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 3128 -j ACCEPT
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

