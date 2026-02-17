$AppSwitchedPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched"

Get-ItemProperty -Path $AppSwitchedPath |
    findstr /i /C:":\" |
    Sort-Object LastWriteTime |
    Out-GridView
