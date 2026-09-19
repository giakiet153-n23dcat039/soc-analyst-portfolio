============================================================
        THREAT DETECTION & SOC ENVIRONMENT SIMULATION
============================================================

PROJECT OVERVIEW
------------------------------------------------------------

This project documents the deployment and validation of a
Security Operations Center (SOC) home lab environment.

The lab focuses on:

  [01] Endpoint Telemetry Collection
  [02] Adversary Emulation
  [03] SIEM Detection & Alert Analysis
  [04] MITRE ATT&CK Mapping
  [05] Detection Engineering


ARCHITECTURE & ENVIRONMENT
------------------------------------------------------------

SIEM PLATFORM       : Wazuh Manager
SIEM OPERATING SYS  : Ubuntu 26.04 LTS
TARGET ENDPOINT     : Windows 11
ENDPOINT AGENT      : Wazuh Agent
TELEMETRY           : Sysmon
SYSMON CONFIG       : SwiftOnSecurity-based
ADVERSARY EMULATION : Atomic Red Team
EXECUTION           : PowerShell


DETECTION PIPELINE
------------------------------------------------------------

    Atomic Red Team
           |
           v
      Windows 11
           |
           | Sysmon Telemetry
           v
      Wazuh Agent
           |
           | Log Forwarding
           v
     Wazuh Manager
           |
           | Rule Matching
           v
    Wazuh Dashboard
           |
           v
      Security Alert


MITRE ATT&CK DETECTION MAPPING
------------------------------------------------------------

[ T1003.001 ]
OS Credential Dumping: LSASS

Wazuh Rule : 61610
Severity   : Level 3
Telemetry  : Sysmon Event ID 10
Detection  : Process accessed by another process


[ T1059.001 ]
Command and Scripting Interpreter: PowerShell

Wazuh Rule : 92005
Severity   : Level 4
Detection  : Command shell started script with /c modifier


[ T1053.005 ]
Scheduled Task/Job: Scheduled Task

Wazuh Rule : 92032
Severity   : Level 3
Detection  : Suspicious Windows CMD shell execution


ADDITIONAL TELEMETRY
------------------------------------------------------------

T1053.005 execution also triggered:

Wazuh Rule : 92034
MITRE      : T1135 - Network Share Discovery

Reason:
Prerequisite environment checks performed by the
Atomic Red Team framework.


REPOSITORY STRUCTURE
------------------------------------------------------------

SOC-LAB/
|
+-- images/
|   +-- Wazuh dashboard screenshots
|
+-- configs/
|   +-- sysmonconfig-export.xml
|   +-- ossec.conf
|
+-- README.md


CONFIGURATION
------------------------------------------------------------

sysmonconfig-export.xml
    Custom Sysmon configuration used for endpoint telemetry.

ossec.conf
    Wazuh Agent configuration used for Sysmon log ingestion
    and forwarding to the Wazuh Manager.


DETECTION ENGINEERING ROADMAP
------------------------------------------------------------

[01] CUSTOM WAZUH RULES

Develop custom detection rules to increase the severity
of high-confidence indicators.

Example:

    Unauthorized LSASS Access
            |
            v
    Custom Wazuh Rule
            |
            v
    High-Severity Alert
          Level 12+


[02] ACTIVE RESPONSE

Implement automated response mechanisms for confirmed
malicious activity.

Potential workflow:

    Detection
       |
       v
    High-Confidence Alert
       |
       v
    Active Response
       |
       +-- Terminate malicious process
       +-- Restrict malicious activity
       +-- Preserve investigation evidence


PROJECT OBJECTIVES
------------------------------------------------------------

- SIEM deployment and administration
- Windows endpoint telemetry
- Sysmon event analysis
- MITRE ATT&CK mapping
- Adversary emulation
- Wazuh detection engineering
- Threat hunting
- Security automation


FUTURE IMPROVEMENTS
------------------------------------------------------------

[ ] Custom Wazuh detection rules
[ ] High-fidelity LSASS access detection
[ ] Additional MITRE ATT&CK techniques
[ ] False-positive analysis
[ ] Alert correlation
[ ] Threat hunting queries
[ ] Automated active response
[ ] Detection coverage documentation
[ ] Investigation playbooks


PROJECT SUMMARY
------------------------------------------------------------

This project demonstrates an end-to-end SOC detection pipeline
using Atomic Red Team, Sysmon, Wazuh Agent, and Wazuh Manager.

Detection Lifecycle:

    EMULATE
       |
       v
    COLLECT
       |
       v
    DETECT
       |
       v
     MAP
       |
       v
  INVESTIGATE
       |
       v
   IMPROVE


============================================================
              END OF PROJECT DOCUMENTATION
============================================================
