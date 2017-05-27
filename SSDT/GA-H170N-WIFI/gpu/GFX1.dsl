//
// GPU
//
// http://www.insanelymac.com/forum/topic/313296-guide-mac-osx-1012-with-x99-broadwell-e-family-and-haswell-e-family/page-49
// http://www.insanelymac.com/forum/user/950366-syscl/?tab=topics



// DefinitionBlock ("", "SSDT", 1, "APPLE", "GFX1", 0x00001000)
// {

    External (\_SB_.PCI0, DeviceObj)
    External (\_SB_.PCI0.PEG0, DeviceObj)
    External (\_SB_.PCI0.HDAS._ADR)
    External (\_SB_.PCI0.PEG0.PEGP, DeviceObj)

// Scope (\_SB_.PCI0)
// {
        
    // _SB.PCI0
//    Scope (PEG0)
//    {

        ////////////////////    
        Device (GFX1) // rename device leaf node (H000/GFX0) to GFX1
        {
            Name (_ADR, Zero)
            Name (_SUN, One)  // _SUN: Slot User Number
            Method (_DSM, 4, NotSerialized)
            {
                If (LEqual (Arg2, Zero))
                {
                    Return (Buffer (One) { 0x03 } )
                }
                Return (Package (0x28)
                {  
                    "hda-gfx",               Buffer (0x0A) { "onboard-1" }, 
                    "AAPL,slot-name",        Buffer (0x07) { "Slot-1" }, 
                    "@2,AAPL,boot-display",  Buffer (One)  { 0x02 }, 
                    "device-id",             Buffer (0x04) {  0xC8, 0x17, 0x00, 0x00 }, // 02 14 00 00
                    "@0,name",               Buffer (0x13) { "NVDA,Display-A" }, 
                    "@1,name",               Buffer (0x13) { "NVDA,Display-B" }, 
                    "@2,name",               Buffer (0x13) { "NVDA,Display-C" }, 
                    "@3,name",               Buffer (0x13) { "NVDA,Display-D" }, 
                    "@4,name",               Buffer (0x13) { "NVDA,Display-E" }, 
                    "@5,name",               Buffer (0x13) { "NVDA,Display-F" }, 
                    "@0,connector-type",     Buffer (0x04) {  0x00, 0x08, 0x00, 0x00 }, 
                    "@1,connector-type",     Buffer (0x04) {  0x00, 0x08, 0x00, 0x00 }, 
                    "@2,connector-type",     Buffer (0x04) {  0x00, 0x08, 0x00, 0x00 }, 
                    "@3,connector-type",     Buffer (0x04) {  0x00, 0x08, 0x00, 0x00 }, 
                    "@4,connector-type",     Buffer (0x04) {  0x00, 0x08, 0x00, 0x00 }, 
                    "@5,connector-type",     Buffer (0x04) {  0x00, 0x08, 0x00, 0x00 },
                    "rom-revision",          Buffer (0x0F) { "VBIOS 84.06.5e.00.ed" },   // zzz ok
                    "model",                 Buffer (0x34) { "NVIDIA GeForce GTX 950" }, // zzz ok
                    "name",                  Buffer (0x08) { "display" }, 
                    "reg-ltrovr",            Buffer (0x08) {  0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }  
                })
            }
        }
        ////////////////////

        ////////////////////
        Device (HDAU)
        {
            Name (_ADR, One)
            Method (_DSM, 4, NotSerialized)
            {
                Return (Package (0x0E)
                {
                    "built-in",         Buffer (One)  { 0x00 }, 
                    "name",             Buffer (0x05) { "HDAU" }, 
                    "AAPL,slot-name",   Buffer (0x07) { "Slot-1" }, 
                    "device_type",      Buffer (0x06) { "AUDIO" }, 
                    "name",             Buffer (0x05) { "HDAU" }, 
                    "hda-gfx",          Buffer (0x0A) { "onboard-1" }, 
                    "reg-ltrovr",       Buffer (0x08) {  0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }
                })
            }
        } 
        ////////////////////






        /* Here we disable/hide Devices (PEGP) */
        // Name (PEG0.PEGP._STA, Zero)  // _STA: Status
        // Name (\_SB_.PCI0.PEG0.PEGP._STA, Zero)
        // or
        Scope (PEGP)
        {
            Name (_STA, Zero)
        }
    
       
//    } // end scope \ SB \ PEG0

// }

// } // end definiton block



// EOF
