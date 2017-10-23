#!/bin/sh

echo ""
echo "********************************"
echo "* Delete keychain *"
echo "********************************"
echo ""

if [[ "$CIRCLECI" == "true" ]]; then
    security delete-keychain circle.keychain
elif [[ "$TRAVIS" == "true" ]]; then
    security delete-keychain ios-build.keychain
else
    echo "Unknown type of CI. Keychain not deleted"
fi

echo "List keychains: "
security list-keychains
echo " ****** "

echo ""
echo "********************************"
echo "* Delete provisioning profile *"
echo "********************************"
echo ""

echo "List of provisioning profiles (it must be empty): "
rm -rf ~/Library/MobileDevice/Provisioning\ Profiles
ls ~/Library/MobileDevice/Provisioning\ Profiles
echo " ****** "
