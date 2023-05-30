# Cisco Collaboration Manager PowerShell Module

## Overview

This repository contains a collection of PowerShell scripts that can be used to manage Cisco Collaboration Manager.

## Developing

```powershell
Import-Module .\Sources\Cisco-CollaborationManager-PowerShell.psm1 -Force
```

## Usage

When using the commands that begin with the verb "Get", if you specify the UUID of the request, it will execute the "get" AXL request, instead of the default "list" AXL request.
