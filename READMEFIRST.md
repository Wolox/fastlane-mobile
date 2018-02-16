fastlane-mobile
================

Fastlane scripts for deploying and managing Apple certificates in an iOS project.

Tested in fastlane 2.81.0.

## Scripts

You can get detailed information in fastlane [README](./README.md).

## Environments

These scripts handle 4 environments:
- test: intended for development
- qa: intended for qa testing
- appstore: intended for user testing
- production: intended for users

If you want to handle any other environment, you will have to add it to all fastlane custom actions.

If you want less environments, don't worry! Just make the extra ones configuration the same as the useful ones
and don't use the lanes associated with those extra ones.

## Configuration

You can configure some things different for each environment. For that, we use `.env` files.

All environment files should be under `config` directory.

You can have a `.env` file with *general* configurations, and then a `X.env` file for specific configurations on *environment X*.
(Of course if both general and specific configuration have a value for something, specific configuration will prevail.)

In any env file you can set up the following parameters:

```
APPLE_ID="your@apple.account"
TEAM_ID="your Developer Portal team id"
ITC_TEAM_ID="your iTunnes Connect team id"
BUILD_CONFIGURATION="your xcode project\'s build configuration for this environment"
```

For any further configuration, you will have to modify the `Fastfile`s or the custom actions.

## Actions

These fastlane scripts use many custom actions that can be found at the `actions` directory.
Most of them take care of getting information for certain environment, so if you need to add an environment, you'll need to modify them.
Also most of them take care of getting a default value for some parameter if it was not specified in the configurations.
