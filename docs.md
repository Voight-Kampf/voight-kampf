ssdt fixes explained


sat0 to sata -- Fix SATA in RAID mode

```
//
// Power management with X86PlatformPlugin.kext
//

External(\_PR.CPU0, DeviceObj)
Method (\_PR.CPU0._DSM, 4)
{
    If (!Arg2) { Return (Buffer() { 0x03 } ) }
    Return (Package()
    {
        "plugin-type", 1
    })
}
```

what is Device(IMEI)
```
Device(IMEI)
{
    Name (_ADR, 0x00160000)
}
```

