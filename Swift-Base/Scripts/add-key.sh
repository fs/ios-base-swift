#!/bin/sh

if [[ "$TRAVIS" == "true" ]]; then

    echo ""
    echo "********************************"
    echo "* Create keychain *"
    echo "********************************"
    echo ""

    KEYCHAIN=ios-build.keychain
    KEYCHAIN_PASSWORD=cibuild

    # Create a temporary keychain for code signing.
    security create-keychain -p "$KEYCHAIN_PASSWORD" "$KEYCHAIN"
    security default-keychain -s "$KEYCHAIN"
    security unlock-keychain -p "$KEYCHAIN_PASSWORD" "$KEYCHAIN"
    security set-keychain-settings -t 3600 -u "$KEYCHAIN"

    echo ""
    echo "********************************"
    echo "* Import Certs *"
    echo "********************************"
    echo ""

    # Download the certificate for the Apple Worldwide Developer Relations
    # Certificate Authority.
    APPLE_CERT_PATH=Certs/apple_wwdr.cer
    curl 'https://developer.apple.com/certificationauthority/AppleWWDRCA.cer' > "$APPLE_CERT_PATH"
    security import "$APPLE_CERT_PATH" -k $KEYCHAIN -T /usr/bin/codesign

    #Copy local certs
    security import Certs/$DISTRIBUTION_CERT_NAME.p12 -k $KEYCHAIN -P "twiage" -T /usr/bin/codesign
    security import Certs/$DEVELOPMENT_CERT_NAME.p12 -k $KEYCHAIN -P "twiage" -T /usr/bin/codesign

    echo " ****** "

    echo "List keychains: "
    security list-keychains
    echo " ****** "

    echo "Find indentities keychains: "
    security find-identity -p codesigning  ~/Library/Keychains/ios-build.keychain
    echo " ****** "

    echo ""
    echo "********************************"
    echo "* Add provisioning profile *"
    echo "********************************"
    echo ""
    mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
    cp Certs/*.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
    ls ~/Library/MobileDevice/Provisioning\ Profiles
    echo " ****** "

elif [[ "$CIRCLECI" == "true" ]]; then

    KEYCHAIN="circle.keychain"
    KEYCHAIN_PASSWORD="circle"

    echo ""
    echo "********************************"
    echo "* Import Certs *"
    echo "********************************"
    echo ""

    # Download the certificate for the Apple Worldwide Developer Relations
    # Certificate Authority.
    APPLE_CERT_PATH=Certs/apple_wwdr.cer
    curl 'https://developer.apple.com/certificationauthority/AppleWWDRCA.cer' > "$APPLE_CERT_PATH"
    security import "$APPLE_CERT_PATH" -k $KEYCHAIN -T /usr/bin/codesign

    #Copy local certs
    security import Certs/$DISTRIBUTION_CERT_NAME.p12 -k $KEYCHAIN -P "twiage" -T /usr/bin/codesign
    security import Certs/$DEVELOPMENT_CERT_NAME.p12 -k $KEYCHAIN -P "twiage" -T /usr/bin/codesign

    echo " ****** "

    echo "List keychains: "
    security list-keychains
    echo " ****** "

    echo "Find indentities keychains: "
    security find-identity -p codesigning
    echo " ****** "
else
    echo "Unknown type of CI"
    exit 1
fi
