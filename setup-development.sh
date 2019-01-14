#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]; do
key="$1"
case $key in
    -m|--gmaps-api-key)
    GMAPI="$2"
    shift # past argument
    shift # past value
    ;;
    -k|--keystore)
    KEYSTORELOCATION="$2"
    KEYSTOREALIAS="$3"
    shift
    shift
    shift
    ;;
    --keystore-create)
    KEYSTORECREATE="YES"
    shift
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters


if [ -z "$GMAPI" ]; then
    echo "Usage: $0 --gmaps-api-key <Google Maps API Key>"
    echo "Optional: --keystore <Path to .jks keystore> <Keystore alias>"
    echo "Create new keystore: --keystore-create"
    exit -1
fi

os="$(uname)"

if [ ! -z "$KEYSTORECREATE " ]; then
    echo "Creating a new keystore"

    if [ -f "./android/key.properties" ]; then
        echo "Cancelling creation of a new keystore since android/key.properties already exist."
    else
        if [[ "$os" == "Darwin" ]]; then
            KEYTOOL="/Applications/Android*Studio.app/Contents/jre/jdk/Contents/Home/bin/keytool"
        else
            if [ ! -x "$(command -v keytool)" ]; then
                echo "Java is not installed on your system. Run a 'flutter doctor -v' to find the path to a java installation. Copy/paste that here (though replace the last 'java' with 'keytool')"
                echo -n "Path to keytool: "
                read KEYTOOL
            else
                KEYTOOL="keytool"
            fi
        fi

        # if [ ! -f "$KEYTOOL" ]; then
        #     echo "Keytool does not exist at $KEYTOOL"
        #     exit -1
        # fi

        echo -n "Enter keystore alias: "
        read KEYSTOREALIAS
        KEYSTORELOCATION="$HOME/$KEYSTOREALIAS.jks"

        if [ ! -x "$(command -v openssl)" ]; then
            echo "Cannot generate a random password since 'openssl' is not installed on your system."
            echo "Enter long random generated password: "
            read -s KEYSTOREPWD
        else
            KEYSTOREPWD="$(openssl rand -base64 32)"
        fi

        $KEYTOOL -genkey -v -keystore $KEYSTORELOCATION -keyalg RSA -keysize 2048 -validity 10000 -alias $KEYSTOREALIAS -storepass $KEYSTOREPWD -keypass $KEYSTOREPWD -noprompt -dname "CN=effortless.dk, OU=Development, O=Effortless, L=Copenhagen, S=Hovedstaden, C=DK"

        echo "Generated keystore:"
        echo "- Keystore Alias.........: $KEYSTOREALIAS"
        echo "- Keystore Location......: $KEYSTORELOCATION"
        echo "- Keystore Password......: $KEYSTOREPWD"
        echo;
    fi
fi

if [ ! -f "./android/key.properties" ]; then
    echo "key.properties does not exist"
    if [ -z "$KEYSTORELOCATION" ]; then
        echo "Since android/key.properties does not exist, --keystore is required."
        echo "Usage: $0 --gmaps-api-key <Google Maps API Key>"
        echo "Optional: --keystore <Path to .jks keystore> <Keystore alias>"
        echo "Create new keystore: --keystore-create"
        exit -1
    elif [ -z "$KEYSTOREALIAS" ]; then
        echo "Since android/key.properties does not exist, --keystore is required."
        echo "Usage: $0 --gmaps-api-key <Google Maps API Key>"
        echo "Optional: --keystore <Path to .jks keystore> <Keystore alias>"
        echo "Create new keystore: --keystore-create"
        exit -1
    else
        if [ -z "$KEYSTOREPWD" ]; then
            echo -n "Keystore Password: "
            read -s KEYSTOREPWD
        fi

        cat << EOF > android/key.properties
storePassword=$KEYSTOREPWD
keyPassword=$KEYSTOREPWD
keyAlias=$KEYSTOREALIAS
storeFile=$KEYSTORELOCATION
EOF
    fi
fi

os="$(uname)"

if [[ "$os" == "Darwin" ]]; then
    cat << EOF > ios/Runner/secret_keys.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>google_maps_api_key</key>
	<string>$GMAPI</string>
</dict>
</plist>

EOF
fi

if [ ! -x "$(command -v flutter)" ]; then
    echo "Flutter is not installed"
    exit -1
fi

echo -n "Getting flutter packages... "
flutter packages get > /dev/null 2>&1 && echo "OK" || echo "Failed!"

if [[ "$os" == "Darwin" ]]; then
    echo -n "Running pod install... "
    pod install --project-directory=./ios > /dev/null 2>&1 && echo "OK" || echo "Failed!"
fi

echo "Project has been fully configured."
