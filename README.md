((---     NETWORK BASH COMMANDS     ---
----------------------------------------- 

# 1. Check Network Interfaces
   - **Command**: `ip a` or `ifconfig`
   - **Purpose**: Display all network interfaces and their IP addresses.

# **Manipulate IP Addresses with `ip`**
   - **Purpose**: Advanced IP address and routing configuration.
   - **Add an IP Address**:
     ```bash
     sudo ip addr add 192.168.1.100/24 dev eth0
     ```
   - **Add a Route**:
     ```bash
     sudo ip route add 192.168.2.0/24 via 192.168.1.1
     ```
   - **Delete a Route**:
     ```bash
     sudo ip route del 192.168.2.0/24
     ``` 

# **Set a Static IP Address**
   - **Command**: Edit `/etc/network/interfaces`: or use `nmcli`
   - **Purpose**: Configure a static IP address.
   - **Example**:
     Edit `/etc/network/interfaces`:
     ```bash
     sudo nano /etc/network/interfaces
     ```
     Add:
     ```
     auto eth0
     iface eth0 inet static
         address 192.168.1.100
         netmask 255.255.255.0
         gateway 192.168.1.1
     ```
---

# 2. Test Connectivity (Ping)
   - Command**: `ping <URL>`
   - Purpose**: Test connectivity to a remote host.
    - Example: To stop after 5 packets:
     ```bash
     ping -c 5 google.com #-c = count 
     ```
---

# 3. Trace Route
   - **Command**: `traceroute <URL>` or `tracepath <URL>`
   - **Purpose**: Trace the path packets take to reach a destination.
 
---

# 4. Check DNS Resolution
   - **Command**: `nslookup <URL>` or `dig <URL>`
   - **Purpose**: Query DNS records for a domain.

#  **Flush DNS Cache**
   - **Command**: `sudo systemd-resolve --flush-caches`
   - **Purpose**: Clear the local DNS cache.

# **Analyze DNS Traffic with `dnstop`**
   - **Purpose**: Monitor DNS queries in real-time.
   - **Command**:
     ```bash
     sudo dnstop eth0
     ```
---

# 5. Check Open Ports
   - **Command**: `netstat -tuln` or `ss -tuln`
   - **Purpose**: Display open ports and listening services.

# **Monitor Network Connections with `ss`**
   - **Purpose**: Advanced socket statistics.
   - **Command**:
     ```bash
     ss -tulnp
     ```
   - **Advanced Options**:
     - Show established connections:
       ```bash
       ss -tun state established
       ```
     - Filter by port:
       ```bash
       ss -tun sport = :80
       ```

---

# 6. Scan Network for Hosts
   - Command: `nmap`
   - **Purpose**: Scan a network for active hosts and open ports.
   - **Example**:
     ```bash
     nmap -sP 192.168.1.0/24 #-Sp (scan port) <ipv4/netmask> 

     ```
     Scan a specific IP for open ports:
     ```bash
     nmap 192.168.1.1
     ```
### **Advanced `nmap` Scanning**
   - **Purpose**: Perform detailed network discovery and vulnerability scanning.
   - **Command**:
     ```bash
     sudo nmap -A -T4 <target>
     ```
     - `-A`: Enable OS detection, version detection, script scanning, and traceroute.
     - `-T4`: Aggressive timing template.
   - **Advanced Examples**:
     - Scan for UDP services:
       ```bash
       sudo nmap -sU <target>
       ```
     - Scan with a specific NSE script:
       ```bash
       sudo nmap --script=http-title <target>
       ```
---

### 7. **Check Routing Table**
   - **Command**: `ip route` or `route -n` 
   - **Purpose**: Display the routing table.

---

### 8. **Capture Network Traffic**
   - **Command**: `tcpdump -i eth0`
   - **Purpose**: Capture and analyze network packets.
   - **Example**:
     `` `
     Capture only HTTP traffic:
     ```bash
     tcpdump -i eth0 port 80 
     ```

# **Capture and Analyze Packets with `tcpdump`**
   - **Advanced Usage**: Save packets to a file and analyze them later.
   - **Command**:
     ```bash
     sudo tcpdump -i eth0 -w capture.pcap
     ```
     - `-i eth0`: Capture on interface `eth0`.
     - `-w capture.pcap`: Save packets to `capture.pcap`.
   - **Analyze the file**:
     ```bash
     tcpdump -r capture.pcap
     ```
---

### 9. **Simulate Network Issues with `tc`**
   - **Purpose**: Simulate network latency, packet loss, and bandwidth limits.
   - **Add Latency**:
     ```bash
     sudo tc qdisc add dev eth0 root netem delay 100ms
     ```
   - **Add Packet Loss**:
     ```bash
     sudo tc qdisc add dev eth0 root netem loss 10%
     ```
   - **Limit Bandwidth**:
     ```bash
     sudo tc qdisc add dev eth0 root tbf rate 1mbit burst 32kbit latency 400ms
     ```
   - **Remove Rules**:
     ```bash
     sudo tc qdisc del dev eth0 root
     ```

---

### 10. **Analyze SSL/TLS Certificates with `openssl`**
   - **Purpose**: Check SSL/TLS certificates and connections.
   - **Command**:
     ```bash
     openssl s_client -connect google.com:443
     ```
   - **Advanced Options**:
     - Check certificate expiration:
       ```bash
       openssl s_client -connect google.com:443 2>/dev/null | openssl x509 -noout -dates
       ```
     - Test specific TLS version:
       ```bash
       openssl s_client -connect google.com:443 -tls1_2
       ```

---

### 11. **Automate Network Tasks with `expect`**
   - **Purpose**: Automate interactive network commands (e.g., SSH, Telnet).
   - **Example Script**:
     ```bash
     #!/usr/bin/expect
     spawn ssh user@192.168.1.1
     expect "password:"
     send "your_password\r"
     interact
     ```
   - Save and run:
     ```bash
     ./script.exp
     ```
-----

### 12. **Test Network Throughput with `netcat`**
   - **Purpose**: Measure raw network throughput.
   - **Server Side**:
     ```bash
     nc -l -p 5000 > /dev/null
     ```
   - **Client Side**:
     ```bash
     dd if=/dev/zero bs=1M count=100 | nc <server_ip> 5000
     ```

---

### 13. **Analyze Network Flows with `nfdump`**
   - **Purpose**: Analyze NetFlow data.
   - **Command**:
     ```bash
     nfdump -r <flow_file>
     ```
   - **Advanced Options**:
     - Filter by IP:
       ```bash
       nfdump -r <flow_file> 'host 192.168.1.1'
       ```
---

### 14. **Check Bandwidth Usage**
   - Command: `iftop -i eth0`
   - **Purpose**: Monitor real-time bandwidth usage.

# **Monitor Network Traffic with `iftop`**
   - **Purpose**: Real-time bandwidth monitoring.
   - **Command**:
     ```bash
     sudo iftop -i eth0
     ```
   - **Advanced Options**:
     - Filter by IP:
       ```bash
       sudo iftop -F 192.168.1.0/24 -i eth0
       ```
     - Display port numbers:
       ```bash
       sudo iftop -P -i eth0
       ```
---

### 15. **Test HTTP Connectivity**
   - **Command**: `curl -I <https://<url>`
   - **Purpose**: Test HTTP/HTTPS connectivity and fetch web content.
   - **Example**:

     Fetch full content:
     ```bash
     curl https://google.com
     ```
---
# **Capture HTTP Traffic with `ngrep`**
   - **Purpose**: Filter and capture HTTP traffic.
   - **Command**:
     ```bash
     sudo ngrep -d eth0 -W byline "GET|POST"
     ```
   - **Advanced Options**:
     - Capture HTTPS traffic (decrypt with SSL key):
       ```bash
       sudo ngrep -d eth0 -W byline -q "GET|POST" port 443
    
### 16. **Check ARP Table**
   - **Command**: `arp -a`
   - **Purpose**: Display the ARP table (IP to MAC address mappings).

---

### 17. **Restart Network Service**
   - **Command**: `sudo systemctl restart networking`
   - **Purpose**: Restart the network service to apply changes.

---

### 18. **Check Network Speed**
   - **Command**: `speedtest-cli`
   - **Purpose**: Test internet speed.

---

### 19. **Check Firewall Rules**
   - **Command**: `sudo ufw status` or `sudo iptables -L`
   - **Purpose**: Display firewall rules.
   
---

### 20. **Check Network Latency**
   - **Command**: `mtr <URL>`
   - **Purpose**: Combine `ping` and `traceroute` to measure latency.

# **Analyze Network Latency with `mtr`**
   - **Purpose**: Combine `ping` and `traceroute` for advanced latency analysis.
   - **Command**:
     ```bash
     mtr --report <target>
     ```
   - **Advanced Options**:
     - Set packet size:
       ```bash
       mtr --psize 128 <target>
       ```
     - Use TCP instead of ICMP:
       ```bash
       mtr --tcp <target>
       ```
---

### 21. **Check SSH Connectivity**
   - **Command**: `ssh user@<ipv4 IP address>`
   - **Purpose**: Connect to a remote server via SSH.

### *Create a Network Tunnel with `ssh`**
   - **Purpose**: Securely forward traffic through an SSH tunnel.
   - **Command**:
     ```bash
     ssh -L <local_port>:<remote_host>:<remote_port> user@<ssh_server>
     ```
   - **Example**: Forward local port 8080 to `google.com:80` via an SSH server:
     ```bash
     ssh -L 8080:google.com:80 user@ssh.example.com
     ```
   - Access `google.com` locally via `http://localhost:8080`.

---

### 22. **Check Network Statistics**
   - **Command**: `netstat -s`
   - **Purpose**: Display network statistics (e.g., packets, errors).

------------

### 23. **Check MAC Address**
   - **Command**: `ip link show`
   - **Purpose**: Display MAC addresses of network interfaces.

