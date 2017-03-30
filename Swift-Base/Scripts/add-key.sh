#!/bin/sh

if [[ "$TRAVIS" == "true" ]]; then

    echo ""
    echo "********************************"
    echo "* Create keychain *"
    echo "********************************"
    echo ""

    KEYCHAIN="ios-build.keychain"
    KEYCHAIN_PASSWORD="cibuild"

    # Create a temporary keychain for code signing.
    security create-keychain -p $KEYCHAIN_PASSWORD $KEYCHAIN
    security default-keychain -s $KEYCHAIN
    security unlock-keychain -p $KEYCHAIN_PASSWORD $KEYCHAIN
    security set-keychain-settings -t 3600 -u $KEYCHAIN

    echo ""
    echo "********************************"
    echo "* Import Certs *"
    echo "********************************"
    echo ""

    # Download the certificate for the Apple Worldwide Developer Relations
    # Certificate Authority.
    APPLE_CERT_PATH="Certs/apple_wwdr.cer"
    curl 'https://developer.apple.com/certificationauthority/AppleWWDRCA.cer' > $APPLE_CERT_PATH
    security import $APPLE_CERT_PATH -k $KEYCHAIN -T /usr/bin/codesign

    #Import development and distribution certificates
    #start decryption
    for cert_path in Certs/*.p12.enc
    do
        if [ -f "$cert_path" ];then
            #remove .enc extension
            echo $cert_path
            encripted_path="${cert_path%.*}"
            echo $encripted_path
            openssl aes-256-cbc -k $ENCRYPTION_SECRET -in $cert_path -d -a -out $encripted_path
            security import $encripted_path -k $KEYCHAIN -P "" -T /usr/bin/codesign
        fi
    done
    #end decryption

    security set-key-partition-list -S apple-tool:,apple: -s -k $KEYCHAIN_PASSWORD $KEYCHAIN

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
    #Coping provisioning profiles
    #start decryption
    for provisioning_path in Certs/*.mobileprovision.enc
    do
        if [ -f "$provisioning_path" ];then
            #encrpting provisioning profiles and remove .enc extension
            encripted_path="${provisioning_path%.*}"
            openssl aes-256-cbc -k $ENCRYPTION_SECRET -in $provisioning_path -d -a -out $encripted_path
        fi
    done
    #end decryption
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
    curl 'https://developer.apple.com/certificationauthority/AppleWWDRCA.cer' > $APPLE_CERT_PATH
    security import $APPLE_CERT_PATH -k $KEYCHAIN -T /usr/bin/codesign

    security set-key-partition-list -S apple-tool:,apple: -s -k $KEYCHAIN_PASSWORD $KEYCHAIN

    # Certs can be loaded on circle

    echo " ****** "

    echo "List keychains: "
    security list-keychains
    echo " ****** "

    # Provisioning profiles can be loaded on circle

    echo "Find indentities keychains: "
    security find-identity -p codesigning
    echo " ****** "
else
    echo "Unknown type of CI"
    exit 1
fi
