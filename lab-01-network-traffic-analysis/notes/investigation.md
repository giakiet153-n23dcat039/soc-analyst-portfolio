# Network Traffic Investigation

## Scenario

Analyze network traffic generated from a Kali Linux host to understand
basic ICMP, DNS, TCP, and HTTP communication.

## Objective

Identify the network protocols involved and understand the communication
between the local host and external services.

## Evidence 1 — ICMP

A ping test was performed from the Kali host to 8.8.8.8.

Observed traffic:

- Source: Kali host
- Destination: 8.8.8.8
- Protocol: ICMP
- Traffic included Echo Request and Echo Reply.

Finding:

The ICMP exchange confirms successful network connectivity between the
Kali host and 8.8.8.8.

## Evidence 2 — DNS

A DNS query for example.com was observed.

Observed traffic:

- Source: Kali host
- DNS server: 192.168.103.2
- Protocol: DNS over UDP
- Destination port: 53
- Query: example.com
- Response contained A and AAAA records.

Finding:

The DNS request and response show successful domain name resolution.

## Evidence 3 — TCP Handshake

A TCP connection was established between the Kali host and
172.66.147.243 on port 80.

Observed sequence:

1. SYN
2. SYN, ACK
3. ACK

Finding:

The TCP three-way handshake completed successfully before application
data was exchanged.

## Evidence 4 — HTTP

A TCP stream showed an HTTP request to example.com.

Observed request:

- Method: HEAD
- Host: example.com
- User-Agent: curl/8.21.0

The server returned:

- HTTP/1.1 200 OK
- Content-Type: text/html
- Server: Cloudflare

Finding:

The traffic represents a successful HTTP request to example.com.
No clearly malicious behavior was identified from this traffic alone.

## Analyst Assessment

The captured traffic represents normal network communication involving
ICMP, DNS, TCP, and HTTP.

No clear indicators of malicious activity were identified in the captured
packets. The investigation demonstrates the ability to identify protocols,
follow TCP communication, and extract useful network indicators from
packet captures.

## Conclusion

The investigation successfully demonstrated basic network traffic analysis
using Wireshark and identified the communication flow from connectivity
testing through DNS resolution, TCP session establishment, and HTTP
application traffic.
