import 'Fastfile.private'
fastlane_version "2.65.0"
default_platform :ios

platform :ios do

  # Run this before doing anything else
  before_all do

    desc "Perform project configurations validations."
    validate
    
  end

  # After all the steps have completed succesfully, run this.
  after_all do |lane|

    desc "Remove all build artifacts created by fastlane to upload."
    clean_build_artifacts

  end

  # If there was an error, run this.
  error do |lane, exception|

    desc "Remove all build artifacts created by fastlane to upload."
    clean_build_artifacts

  end

  desc "New release to `TestFlight` for QA(Alpha). This lane will never update the version, only the build number."
  lane :release_qa do
    release build_configuration: :qa
  end

  desc "New release to `TestFlight` for Appstore."
  desc "Parameters:"
  desc "- bump_type (optional): represents the type of deploy. If not specified, the user will be asked for it."
  lane :release_appstore do |options|
    release build_configuration: :appstore, bump_type: options[:bump_type]
  end

  desc "Executes the tests for the project using `scan`. This lane uses the configuration mapped to `:test`."
  lane :test do

    desc "Run scan with default project and scheme"
    run_tests

  end

  desc "Creates the `App ID` and `Provisioning Profile` for the configurations mapped to `:test` and `:qa`."
  lane :create_development_app do

    desc "Remember after this point to choose this profile in xCode Signing (Development)"
    create_app(
      app_name: get_application_name(build_configuration: :test) % project_name,
      build_configuration: get_build_configuration(build_configuration: :test),
      skip_itc: true,
      match_type: get_match_type(build_configuration: :test),
    )

    desc "Remember after this point to choose this profile in xCode Signing (Alpha)"
    create_app(
      app_name: get_application_name(build_configuration: :qa) % project_name,
      build_configuration: get_build_configuration(build_configuration: :qa),
      skip_itc: false,
      match_type: get_match_type(build_configuration: :qa),
    )

  end

  desc "Creates the `App ID` and `Provisioning Profile` for the configuration mapped to `:appstore`."
  lane :create_appstore_app do
    
    desc "Remember after this point to choose this profile in xCode Signing (Beta)"
    create_app(
      app_name: get_application_name(build_configuration: :appstore) % project_name,
      build_configuration: get_build_configuration(build_configuration: :appstore),
      skip_itc: false,
      match_type: get_match_type(build_configuration: :appstore),
    )

  end

  desc "Generates the push notifications certificates for the build configurations mapped to `:test` and `:qa`."
  lane :generate_push_certificates_development do |options|
    generate_push_certificates build_configuration: :test
    generate_push_certificates build_configuration: :qa
  end

  desc "Generates the push notifications certificates for the build configurations mapped to `:appstore`."
  lane :generate_push_certificates_appstore do |options|
    generate_push_certificates build_configuration: :appstore
  end

  desc "Adds a new device and regenerates the `Provisioning Profile`s to include it."
  lane :add_device do
    add_single_device
  end

end
