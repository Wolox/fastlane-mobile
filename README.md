fastlane-mobile
================
Fastlane scripts for deploying iOS and Android apps, and managing Apple certificates in an iOS project.

## Index

- [Setup](#setup)
- [Scripts](#scripts)
- [Environments](#environments)
- [Configuration](#configuration)
- [Actions](#actions)
- [Running on CI](#running-on-ci)

## Setup

To add fastlane scripts to your project, you need to:

- Install Xcode command line tools running `xcode-select --install` or `brew install fastlane`
- Install `ruby` on your machine. We recommend using [rbenv](http://rbenv.org/) as ruby versions manager.
- Setup the ruby version used for your project (run `rbenv local x.y.z` in your project's root dir to create a `.ruby-version` file like [this](./ios/.ruby-version))
- Add `fastlane` and `pry` to the Gemfile. Make sure to add `fastlane` with a compatible version (check [iOS Gemfile](./ios/Gemfile) [Android Gemfile](./android/Gemfile))
- Copy the corresponding `fastlane` folder to your project's root dir
- Run `bundle install` in your project's root dir
- (Optional) You may want to add some fastlane noise to the .gitignore of your project, like the ones [here](./.gitignore).

and that's it!


### Additional steps for Android

* Install [Firebase CLI](https://firebase.google.com/docs/cli#install-cli-mac-linux)
* Copy the file [version.gradle](./android/version.gradle) to your `/app`  folder
* In your `app/build.gradle` file:
	* Import version.gradle: 
      ```
      apply from: 'version.gradle'
      ```
	* In the `defaultConfig` section, add:
      ```
      defaultConfig {
            ...
            versionName generateVersionName()
            versionCode generateVersionCode()
            ...
      }
      ```
* In the `gradle.properties` file add:
```
VERSION_NAME=1.0
VERSION_CODE=1
```
* (optional) In [groups](./android/fastlane/config/groups) file, add the name of the tester groups you want to invite. For more info, check "groups_file" in [Firebase documentation](https://firebase.google.com/docs/app-distribution/ios/distribute-fastlane#step_3_set_up_your_fastfile_and_distribute_your_app)
* Add `gem 'fastlane-plugin-firebase_app_distribution'` in your [Gemfile](./android/Gemfile)
* Run `bundle install` in your project's root dir

## Scripts

You can get detailed information on all the things you can do with these scripts in fastlane [iOS README](./ios/fastlane/README.md) and [Android README](./android/fastlane/README.md)

Remember to run all fastlane commands preceded by `bundle exec` (you can create an alias for this so it's easier).

For example: `bundle exec fastlane ios release_qa` or `bundle exec fastlane android distribute_qa`

## Environments

These scripts handle 4 environments:
- **dev**: intended for development
- **qa**: intended for qa testing
- **stage**: intended for user/client testing
- **production**: intended for actual users

If you want to handle any other environment, you will have to add it manually to all custom [actions](#actions) and add new lanes in the `Fastfile`.

If you want less environments, don't worry! Just make the extra ones configuration the same as the useful ones and don't use the fastlane lanes associated with those extra ones.

## Configuration

You can configure some things different for each environment. For that, we use `.env` files.

All environment files should be under `config` directory.

You can have a `.env` file with *general* configurations, and then a `X.env` file for specific configurations on *environment X*.
(Of course if both general and specific configuration have a value for something, specific configuration will prevail)

You can set up the following parameters in the env files:

### iOS
```
APPLE_ID="your@apple.account"
TEAM_ID="your Developer Portal team id"
ITC_TEAM_ID="your iTunnes Connect team id"
GIT_URL="URL pointing to match certificates repository"
GIT_BRANCH="Branch in GIT_URL repository to take the signing information from"
RUNNING_ON_CI="(true/false) If true, all interactive messages will be skipped"

BUILD_CONFIGURATION="your xcode project's build configuration for this environment"
      [optional: default in custom action]

PROJECT_EXTENSION=".xcodeproj or .xcworkspace"
      [optional: ".xcodeproj" by default]
      [just meant for global .env: all environments should use the same XCode Project/Workspace]
PROJECT_FILE_NAME="The project file's plain name"
      [optional: The xcode project/workspace's name by default. There must be only one file with PROJECT_EXTENSION as extension for default to work.]
      [just meant for global .env: all environments should use the same XCode Project/Workspace]

APP_NAME="The Project's Apple Visible Name"
      [optional: PROJECT_FILE_NAME by default]]
      [example: "My App" instead of PROJECT_FILE_NAME that could be "my_app"]
      [most probably all environments will use the same name, so you can set it only once in global .env]

APP_ENV_NAME="The Application's name, in relation to the APP_NAME, for the environment (since one app will have many environments)"
      [optional: default in custom action]
      [example: "%s Dev" == "PROJECT_VISIBLE_NAME Dev" or "My Custom App name" == "My Custom App name"]

TEAM_NAME="Your team's name used for creating the bundle id"
      [optional: PROJECT_FILE_NAME by default]
BUNDLE_ID="The bundle identifier, in relation to the TEAM_NAME and the PROJECT_FILE_NAME"
      [optional: default in custom action]
      [example: "com.%s.%s.qa" == "com.TEAM_NAME.PROJECT_FILE_NAME.qa" or "com.%s.MyProject.dev" == "com.TEAM_NAME.MyProject.dev"]
BUNDLE_ID_DOWNCASED="true or false: Whether the bundle id should all be downcased"
      [optional: false by default]

SCHEME="The scheme to use for building the app"

TARGET="The target to use for building the app"

ROLLBAR_ACCESS_TOKEN_KEY="The xcconfig file's key with which I store the Rollbar access token"
      [optional: if empty, it will act as if you don't use rollbar; if completed, it will upload the dsym file to Rollbar server when deploying]
```

### Android
```
APP_NAME="Name of the app"

FIREBASE_GROUPS_PATH="Groups that will be assigned to releases, configured in App Distribution

PLAY_CONSOLE_KEY_FILE_PATH="Path of the key file used to deploy to Play Console"

RUNNING_ON_CI="(true/false) If true, all interactive messages will be skipped"

PACKAGE_NAME="Package name of the app, for example: com.wolox.app"

FIREBASE_APP="ID of your project in Firebase, for example: 1:1234567890"
```

To add new tasks, modify both `Fastfile` and `Fastfile.private` and add/modify actions in `/actions`

## Actions

These fastlane scripts use many custom actions that can be found at the `actions` directory.
Most of the actions take care of getting information for a certain environment, so if you need to add an environment, you'll have to modify them so they consider the new environment, since most of them use default values if the parameter was not specified in the configuration files.


## Running on CI

If you are running these scripts on any Continuous Integration service, just set `RUNNING_ON_CI` environment variable to `true`, so that all confirmation messages are skipped, assuming everything is correctly configured.
