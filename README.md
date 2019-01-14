# ems_app

A new Flutter project.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

## Setup Development Environment

There are a few ways to configure the development environment. The easiest way is to simply use the automated script `setup-development.sh`.

The script will generate the following files:
- `./android/key.properties` with the API Key for Google Maps
- `./ios/Runner/secret_keys.plist` with the API Keys for Google Maps (Only if the script is executed from a Mac)
- If `--keystore-create` is given as argument, `$HOME/<key_alias>.jks` is created as well.

It will then run `flutter packages get` and if you are on a Mac, also `pod install`.

### No .jks Keystore

If you haven't generated a `.jks` keystore, use the following command:

```bash
./setup-development --gmaps-api-key <API Key for Google Maps> --keystore-create
```

The script will pretty much configure everything for you.

### You already have a .jks Keystore

If you already have a .jks keystore:

```bash
./setup-development --gmaps-api-key <API Key for Google Maps> --keystore <Path to keystore> <Keystore alias>
```

You will be prompted for the password for the keystore.
