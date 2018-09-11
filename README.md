fastlane-mobile
================

Fastlane scripts for deploying and managing Apple certificates in an iOS project.

## Setup

To add fastlane scripts to your project, you need to:

- install `ruby` on your machine. We recommend using [rbenv](http://rbenv.org/) as ruby versions manager.
- setup the ruby version used for your project (`rbenv local x.y.z` will set it by creating a `.ruby_version` file like [this](./.ruby_version))
- add `fastlane` and `pry` to the Gemfile. Make sure to add `fastlane` with a compatible version (as in the one [here](./Gemfile))
- copy `fastlane` folder to your project's root dir
- run `bundle install`

and that's it!

(You may want to add some fastlane noise to the .gitignore of your project, like the ones [here](./.gitignore))

## Scripts

You can get detailed information on all the things you can do with these scripts in fastlane [README](./fastlane/README.md).
Remember to run all fastlane commands preceeded by `bundle exec` (you can create an alias for this so it's easier).

**Warning**: If you are using extra configurations, for example, if you have a ReactNative project using .env files of your own,
you may want to add a switch of .env files for each `release` lane in the [Fastfile](./fastlane/Fastfile), like the following example:
```
lane :release_qa do
  cp .env .env.bkp
  cp .env.production .env
  ...normal lane code...
  cp .env.bkp .env
  rm .env.bkp
end
```

## Environments

These scripts handle 4 environments:
- **dev**: intended for development
- **qa**: intended for qa testing
- **stage**: intended for user/client testing
- **production**: intended for actual users

If you want to handle any other environment, you will have to add it to all fastlane custom [actions](#actions)
and add lanes for it in the `Fastfile`.

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
      [optional: PROJECT_FILE_NAME by default]

ROLLBAR_ACCESS_TOKEN_KEY="The xcconfig file's key with which I store the Rollbar access token"
      [optional: if empty, it will act as if you don't use rollbar; if completed, it will upload the dsym file to Rollbar server when deploying]
```

For any other task you want to do, you can add them to the `Fastfile`s existing lanes or the custom actions.
For example, if you want to have the script take care of distributing the build, you have to change `skip_waiting_for_build_processing` to `false` for pilot in the `Fastfile.private` and then add the distributing part to the script.
For any further configuration, you will have to


## Actions

These fastlane scripts use many custom actions that can be found at the `actions` directory.
Most of them take care of getting information for certain environment, so if you need to add an environment, you'll need to modify them so that they consider that new environment, since most of them take care of getting a default value for some parameter if it was not specified in the configurations.
