/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20161210-64(RM)
 * Copyright (c) 2000 - 2016 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of iASLme64x1.aml, Tue May 30 10:48:10 2017
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000008A (138)
 *     Revision         0x02
 *     Checksum         0xB3
 *     OEM ID           "Dragon"
 *     OEM Table ID     "SSDT-SMB"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160422 (538313762)
 */


//DefinitionBlock ("", "SSDT", 2, "Dragon", "SSDT-SMB", 0x00000000)
//{
    
    
    
    
    
    //External (\_SB.PCI0.SBUS, DeviceObj)

    //Scope (_SB.PCI0.SBUS)
    //{

        Device (BUS0)
        {
            Name (_CID, "smbus")  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
        
        
            Device (DVL0)
            {
                Name (_ADR, 0x57)  // _ADR: Address
                Name (_CID, "diagsvault")  // _CID: Compatible ID
            
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If (LNot (Arg2))
                    {
                        Return (Buffer (One)
                        {
                            0x57
                        })
                    }
                
                    Return (Package (0x02)
                    {
                        "address", 0x57
                    })
                
                
                }
            }
        }        
  //  }

// }
// EOF
