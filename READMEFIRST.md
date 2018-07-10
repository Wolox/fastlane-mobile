fastlane-mobile
================

Fastlane scripts for deploying and managing Apple certificates in an iOS project.

Tested in fastlane `2.81.0`.

## Scripts

You can get detailed information in fastlane [README](./README.md).
Remember to run all fastlane commands preceeded by `bundle exec`.`

## Environments

These scripts handle 4 environments:
- test: intended for development
- qa: intended for qa testing
- appstore: intended for user testing
- production: intended for users

If you want to handle any other environment, you will have to add it to all fastlane custom [actions](#actions).

If you want less environments, don't worry! Just make the extra ones configuration the same as the useful ones
and don't use the fastlane lanes associated with those extra ones.

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
GIT_URL="URL pointing to match certificates repository"
GIT_BRANCH="Branch in GIT_URL repository to take the signing information from"

BUILD_CONFIGURATION="your xcode project's build configuration for this environment"
      [optional: default in custom action]

PROJECT_EXTENSION=".xcodeproj or .xcworkspace"
      [optional: ".xcodeproj" by default]
      [just meant for global .env: all environments should use the same XCode Project/Workspace]
PROJECT_NAME="The project's plain name"
      [optional: The xcode project/workspace's name by default. There must be only one file with PROJECT_EXTENSION as extension for default to work.]
      [just meant for global .env: all environments should use the same XCode Project/Workspace]

APP_NAME="The Application's name, in relation to the PROJECT_NAME, for the environment"
      [optional: default in custom action]
      [example: "%s Dev" == "PROJECT_NAME Dev" or "My Custom App name" == "My Custom App name"]

TEAM_NAME="Your team's name used for creating the bundle id"
      [optional: PROJECT_NAME by default]
BUNDLE_ID="The bundle identifier, in relation to the TEAM_NAME and the PROJECT_NAME"
      [optional: default in custom action]
      [example: "com.%s.%s.qa" == "com.TEAM_NAME.PROJECT_NAME.qa" or "com.%s.MyProject.dev" == "com.TEAM_NAME.MyProject.dev"]
BUNDLE_ID_DOWNCASED="true or false: Whether the bundle id should all be downcased"
      [optional: false by default]

SCHEME="The scheme to use for building the app"
      [optional: PROJECT_NAME by default]
```

For any further configuration, you will have to modify the `Fastfile`s or the custom actions.
For example, if you want to have the script take care of the changelog and distributing the build, you have to change `skip_waiting_for_build_processing` to `false` for pilot in the `Fastfile.private`.

## Actions

These fastlane scripts use many custom actions that can be found at the `actions` directory.
Most of them take care of getting information for certain environment, so if you need to add an environment, you'll need to modify them.
Also most of them take care of getting a default value for some parameter if it was not specified in the configurations.
