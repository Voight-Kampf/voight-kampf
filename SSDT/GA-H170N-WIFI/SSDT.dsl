// Instead of providing patched DSDT/SSDT, just include a single SSDT
// and do the rest of the work in config.plist

// A bit experimental, but possible as desktops are much simpler vs. laptops
// Because of the minimal patches required, we can do most of the work in
// config.plist and small SSDTs such as this one.

// NOTE: this SSDT is mainly for GA-H170N-WIFI rev 01 BIOS F21,
// and hackintosh iMac17,1
// you can use it for other GA MOBOs as well, but be sure
// to check the device paths correct

// define ssdts here

/**
 * 01 Power Management
 * define CPU or CPUNOTURBO for SSDTs generated with ssdtPRGen.sh
 * https://github.com/Piker-Alpha/ssdtPRGen.sh
 */

// #define CPU

/**
 * 02 Graphics Card
 * define GPU for injecting Nvidia GPU with ssdt
 * also rename PEGP to GFX1 -- for iMac17,1
 * https://www.tonymacx86.com/threads/ssdt-gpu-graphics-card-injection.183354/
 */

#define GPU

/**
 * 03 Audio
 * define ALC -- ALC1150 -- for audio -- also rename HDAS to HDEF
 * https://github.com/toleda/audio_ALCInjection
 */

#define ALC

/**
 * 04 USB
 * define USB for USB power properties -- also rename HDAS to HDEF
 * https://www.tonymacx86.com/threads/guide-usb-power-property-injection-for-sierra.222266/
 * if the PC has an EC, name it 'EC' and AppleBusPowerControllerUSB will load
 * so you have to rename H_EC to EC or add a Device named EC with ssdt
 * also inject the USBX device
 *
 * CLOVER DSDT patch: H_EC to EC /// 485f4543 to 45435f5f 
 */
#define USB

/**
 * 05 Shutdown
 * shutdown fix for GA-H170N-WIFI
 * ASCII: _PTS |     HEX: 5F 50 54 53 01    DECIMAL: 95 80 84 83 1    base64: X1BUUwE=
 *        ZPTS |                                                              WlBUUwk=
 * NOTE, than you have to rename the original _PTS method name in DSDT if you use this
 *
 * CLOVER DSDT patch: _PTS to ZPTS /// 5f505453 01 to 5a505453 09 
 */
#define SHUTDOWN


// #define ORANGE



DefinitionBlock ("SSDT.aml", "SSDT", 1, "APPLE ", "general", 0x00001000)
{
    // External (\_SB_, DeviceObj)
    External (\_SB_.PCI0, DeviceObj)
    External (\_SB_.PCI0.PEG0, DeviceObj)
    External (\_SB_.PCI0.PEG0.PEGP, DeviceObj)    // (from opcode)

    // cpu
    #ifdef CPU
        #include "../cpu/SKYLAKE-i7-6700.dsl"
    #endif
    #ifdef CPUNOTURBO
        #include "../cpu/SKYLAKE-i7-6700_NO-TURBO.dsl"
    #endif

    // system bus
    Scope (\_SB_)
    {
        // usb fix from pikeralpha
        #ifdef USB
            #include "usb/UMAP.dsl"
        #endif

        // PCI
        Scope (PCI0)
        {
            // PCI Express Graphics
            Scope (PEG0)
            {
                // NVIDIA GPU
                #ifdef GPU
                    #include "gpu/GFX1.dsl"
                #endif
            }

            // disabling PS2 keyboard and mouse
            // #include "fixes/PS2.dsl"  // error for now

            // HDAS to HDEF
            #ifdef ALC
                #include "audio/HDEF.dsl"
            #endif

            //
            #ifdef ORANGE
                #include "fixes/orangeicon.dsl"
            #endif

        } // end ---------------------------------------------------- scope _SB.PCI0

        #ifdef USB
            // embedded controller
            #include "usb/EC.dsl"

            // usb el sierra fix
            #include "usb/USBX.dsl"
        #endif

    } // end -------------------------------------------------------- scope _SB


    // functions
    // must rename _PTS to something other, see fixes/_PTS.dsl
    #ifdef SHUTDOWN
        #include "fix/PTS.dsl"
    #endif

    //
    Store ("Voight-Kampf ssdt", Debug)

} // end definition block

// EOF