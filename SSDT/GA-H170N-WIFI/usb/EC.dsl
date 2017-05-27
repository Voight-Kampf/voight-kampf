// If you don't have an embedded controller, you can add a "fake" one with the following SSDT-EC.dsl (compile to AML):
// DefinitionBlock("", "SSDT", 2, "hack", "USBX", 0)
// {
    Device(EC)
    {
        Name(_HID, "EC000000")
    }
// }
//EOF