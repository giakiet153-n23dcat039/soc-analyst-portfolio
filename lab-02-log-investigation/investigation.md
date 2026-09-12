# Lab 02 - SSH Brute-Force Investigation

## Scenario

An internal server generated multiple SSH authentication failures from the same source IP. The objective is to identify suspicious login activity and determine whether it is consistent with brute-force behavior.

## Evidence

The log analysis identified:

- `203.0.113.50`: 8 failed login attempts.
- 5 attempts occurred within 12 seconds.
- The source initially targeted the `admin` account.
- Later attempts targeted the `root` account.
- `198.51.100.25`: 1 failed login attempt.
- `192.0.2.20`: 1 successful login.

## Detection

The detection script was configured with a threshold of 5 failed login attempts.

Result:

[ALERT] 203.0.113.50 - 8 failed login attempts
[INFO]  198.51.100.25 - 1 failed login attempts

The source `203.0.113.50` exceeded the configured threshold and generated an alert.

## Analyst Assessment

The repeated failed SSH authentication attempts from `203.0.113.50`, combined with attempts against multiple usernames, are consistent with possible SSH brute-force activity.

The activity is mapped to MITRE ATT&CK technique T1110 - Brute Force.

## Conclusion

The investigation identified suspicious authentication activity from `203.0.113.50`.

The source generated 8 failed login attempts and exceeded the detection threshold of 5 attempts.

The detection script successfully identified the suspicious source automatically.
