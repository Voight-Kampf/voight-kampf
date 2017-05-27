/*
 An SSDT to inject the USBX device

 For SMBIOS that are not already covered in IOUSBHostFamily.kext/Contents/Info.plist, 
 you will need to inject the USBX device in order to provide the power properties 
 for AppleBusPowerControllerUSB.
 */
// USB power properties via USBX device
// DefinitionBlock("", "SSDT", 2, "hack", "USBX", 0)
// {
//    External (_SB.USBX, DeviceObj)

    Device (USBX)
    {
        Name(_ADR, Zero)
        Method (_DSM, 4, NotSerialized)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }        

            Return (Package()
            {
                // these values from iMac17,1
                "kUSBSleepPortCurrentLimit", 2100,
                "kUSBSleepPowerSupply", 5100,
                "kUSBWakePortCurrentLimit", 2100,
                "kUSBWakePowerSupply", 5100,
            })
        }
    }

// }
//EOF