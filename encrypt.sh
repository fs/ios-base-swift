read -e -p "Enter encription key: " ENC_KEY

echo "*** start encryption certificates ***"
for cert_path in Certs/*.p12
do
    if [ -f "$cert_path" ];then
        echo "Encripting certificate - $(basename $cert_path)"
        openssl aes-256-cbc -k "$ENC_KEY" -in $cert_path -out "$cert_path.enc" -a
    fi
done
echo "*** end encryption certificates ***"

echo "*** start encryption provisioning profiles ***"
for provisioning_path in Certs/*.mobileprovision
do
    if [ -f "$provisioning_path" ];then
        echo "Encripting provisioning profile - $(basename $provisioning_path)"
        openssl aes-256-cbc -k "$ENC_KEY" -in $provisioning_path -out "$provisioning_path.enc" -a
    fi
done
echo "*** end encryption provisioning profiles ***"

echo "** DONE! ***"
