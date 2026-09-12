# Lab 02 - Log Investigation & Brute-Force Detection

## Objective

Investigate SSH authentication logs to identify suspicious login activity and detect possible brute-force attacks.

## Scenario

An internal server generated multiple failed SSH authentication attempts. The investigation focuses on identifying suspicious source IP addresses and determining whether the activity is consistent with brute-force behavior.

## Tools

- Kali Linux
- Bash
- grep
- awk
- sort
- uniq
- MITRE ATT&CK

## Investigation

The log file was analyzed to identify failed SSH authentication attempts.

The following command was used:

grep "Failed password" sample_logs/auth.log | awk '{for (i=1; i<=NF; i++) if ($i=="from") print $(i+1)}' | sort | uniq -c | sort -nr

Result:

8 203.0.113.50
1 198.51.100.25

The source `203.0.113.50` generated 8 failed login attempts.

Five attempts occurred within 12 seconds, followed by three additional attempts targeting the `root` account.

## Automated Detection

A Bash script was created to automatically detect IP addresses exceeding a configurable threshold.

Example:

./tools/detect_bruteforce.sh -f sample_logs/auth.log -t 5

Result:

[ALERT] 203.0.113.50 - 8 failed login attempts
[INFO]  198.51.100.25 - 1 failed login attempts

## Analyst Assessment

The repeated failed SSH authentication attempts from `203.0.113.50`, including attempts against multiple usernames, are consistent with possible SSH brute-force activity.

The configured detection threshold was 5 failed attempts.

The source exceeded this threshold and generated an alert.

## MITRE ATT&CK

- T1110 - Brute Force

## Evidence

Detection output:

`screenshots/bruteforce_detection.txt`

Investigation notes:

`investigation.md`

## Conclusion

The investigation identified suspicious SSH authentication activity from `203.0.113.50`.

The detection script successfully identified the source after it exceeded the configured threshold.

This lab demonstrates basic SOC Analyst skills including log analysis, IP-based event correlation, threshold-based detection, alert generation, and MITRE ATT&CK mapping.
