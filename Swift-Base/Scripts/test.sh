#!/bin/sh

echo ""
echo "********************************"
echo "* List of available devices *"
echo "********************************"
echo ""

instruments -s devices

echo ""
echo "********************************"
echo "* Start tests *"
echo "********************************"
echo ""

bundle exec fastlane ios test

EXIT_CODE=$?
if [[ $EXIT_CODE != 0 ]]; then
    echo "xcodebuild exited with code $EXIT_CODE"
    echo "=== TESTS FAILED ==="
    exit $EXIT_CODE
fi

echo "********************************"


# Circle CI
#Apple TV 1080p (10.0) [48B0E1AB-F5EB-40FB-9372-A16B93349B12] (Simulator)
#iPad 2 (8.4) [A4276BA9-2D38-434D-A063-A1A7DC399235] (Simulator)
#iPad 2 (9.0) [2F39BEF2-E92D-498C-B2D9-29366BD8F732] (Simulator)
#iPad Air (10.0) [B9257F59-88B3-421D-B1F2-2BD92F0858D0] (Simulator)
#iPad Air (8.4) [AD005E41-F7E6-4C5F-B3B1-6C980E834739] (Simulator)
#iPad Air (9.0) [42D87249-99F2-4BC1-9180-317D268C46F7] (Simulator)
#iPad Air 2 (10.0) [AC291080-8EFE-4095-8C55-B1E952EFFC36] (Simulator)
#iPad Air 2 (9.0) [6E2B1E19-6466-4328-917C-16019130FDE8] (Simulator)
#iPad Pro (12.9 inch) (10.0) [BF8D8AD2-6A96-4A62-8059-A836738BB873] (Simulator)
#iPad Pro (9.7 inch) (10.0) [F9C94E2A-F080-4AB0-93D6-A41135919D8E] (Simulator)
#iPad Retina (10.0) [D56EBD40-B853-4D56-B482-D4C40E69A3FC] (Simulator)
#iPad Retina (8.4) [399AEF36-5560-4C4A-AE61-03F0A81555D0] (Simulator)
#iPad Retina (9.0) [A1EC86BA-49AB-414B-9C27-2D0F26A34A81] (Simulator)
#iPhone 4s (8.4) [F2E9EEAB-9FCE-4109-A40F-3DD79627C985] (Simulator)
#iPhone 4s (9.0) [5EF3DECC-3E8F-41A0-B2CF-DC384A66E12E] (Simulator)
#iPhone 5 (10.0) [85D8FE66-1208-4478-811C-7BD1AA3B33CA] (Simulator)
#iPhone 5 (8.4) [C5C8EA0E-F5A8-4AF8-BBAA-385B61026A5E] (Simulator)
#iPhone 5 (9.0) [24F6F5A0-343E-4C64-9F4C-B50D88F5E99E] (Simulator)
#iPhone 5s (10.0) [1FB033A8-440D-45F3-B95D-03E4E38B51DF] (Simulator)
#iPhone 5s (8.4) [45BFA4E8-C0A9-4A04-9CD0-4449FE4CF40B] (Simulator)
#iPhone 5s (9.0) [49DAC9E5-C129-497D-853E-D93BC4BB8A10] (Simulator)
#iPhone 6 (10.0) [33D34EBA-703E-4A82-8838-BE75171492E1] (Simulator)
#iPhone 6 (10.0) + Apple Watch - 38mm (3.0) [AB222C53-93E0-4D82-A6E0-00BABE11C87F] (Simulator)
#iPhone 6 (8.4) [65AAA024-64D5-40B9-A122-8872E3F52EC4] (Simulator)
#iPhone 6 (9.0) [53600017-30F1-428A-A16A-25C6CEDBD849] (Simulator)
#iPhone 6 Plus (10.0) [5525775C-A351-4986-9BF4-144A84E253AA] (Simulator)
#iPhone 6 Plus (10.0) + Apple Watch - 42mm (3.0) [0E10CE3B-532C-4AC9-9F14-13387F90C4A0] (Simulator)
#iPhone 6 Plus (8.4) [DFB14113-4697-4E2D-AD3F-B4FBA4B62969] (Simulator)
#iPhone 6 Plus (9.0) [321D1CF5-2514-4897-8B09-C133602F6DB5] (Simulator)
#iPhone 6s (10.0) [F08BA729-6AD2-42DF-A210-34DC8D990011] (Simulator)
#iPhone 6s (9.0) [763DC427-F2C5-4AA4-989F-2CA944FA8F04] (Simulator)
#iPhone 6s Plus (10.0) [A310FC97-435A-4026-AF85-F1216F856BA5] (Simulator)
#iPhone 6s Plus (9.0) [011805C3-BB7A-4785-A313-D7AD2AF6DE49] (Simulator)
#iPhone 7 (10.0) [2D96E690-BFB5-44D5-8B22-31D9C57EDADF] (Simulator)
#iPhone 7 (10.0) + Apple Watch Series 2 - 38mm (3.0) [23990084-6F01-4978-86AD-7CEBD9C32E21] (Simulator)
#iPhone 7 Plus (10.0) [D4155E82-B930-450B-AFC7-F4800669EC65] (Simulator)
#iPhone 7 Plus (10.0) + Apple Watch Series 2 - 42mm (3.0) [EEC8A3AB-A636-4C88-97E7-36C035947432] (Simulator)
#iPhone SE (10.0) [84A11478-B7D4-4968-A626-E27CE7372148] (Simulator)

