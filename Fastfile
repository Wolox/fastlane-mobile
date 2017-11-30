import 'Fastfile.private'
fastlane_version '2.66.0'
default_platform :ios

platform :ios do

  desc "Before doing anything else."
  before_all do
    validate
  end

  desc "After all the steps have completed succesfully."
  after_all do |lane|
    clean
  end

  desc "If there was an error."
  error do |lane, exception|
    clean
  end

  desc "New release to iTunes Connect for QA (Alpha). This lane will never update the version, only the build number."
  lane :release_qa do
    release build_configuration: :qa
  end

  desc "New release to iTunes Connect for AppStore (Release) in Wolox account."
  desc "Parameters:"
  desc "- bump_type (optional): represents the type of deploy. If not specified, the user will be asked for it."
  lane :release_internal_appstore do |options|
    release build_configuration: :appstore, bump_type: options[:bump_type]
  end

  desc "New release to iTunes Connect for AppStore (Production) in third party account."
  desc "Parameters:"
  desc "- bump_type (optional): represents the type of deploy. If not specified, the user will be asked for it."
  lane :release_external_appstore do |options|
    release build_configuration: :production, bump_type: options[:bump_type]
  end

  desc "Executes the tests for the project using `scan`. This lane uses the configuration mapped to `:test`."
  lane :test do
    run_tests build_configuration: :test
  end

  desc "Creates the `App ID` and `Provisioning Profile` for the configurations mapped to `:test` and `:qa`."
  lane :create_development_app do
    create_app build_configuration: :test
    create_app build_configuration: :qa
  end

  desc "Creates the `App ID` and `Provisioning Profile` for the configuration mapped to `:appstore`."
  lane :create_internal_appstore_app do
    create_app build_configuration: :appstore
  end

  desc "Creates the `App ID` and `Provisioning Profile` for the configuration mapped to `:production`."
  lane :create_external_appstore_app do
    create_app build_configuration: :production
  end

  desc "Generates the push notifications certificates for the build configurations mapped to `:test` and `:qa`."
  lane :generate_push_certificates_development do
    generate_push_certificates build_configuration: :test
    generate_push_certificates build_configuration: :qa
  end

  desc "Generates the push notifications certificates for the build configurations mapped to `:appstore`."
  lane :generate_push_certificates_internal_appstore do
    generate_push_certificates build_configuration: :appstore
  end

  desc "Generates the push notifications certificates for the build configurations mapped to `:production`."
  lane :generate_push_certificates_external_appstore do
    generate_push_certificates build_configuration: :production
  end

  desc "Updates or downloads the `Certificates` and `Provisioning Profiles` for the configurations mapped to `:test` and `:qa`."
  lane :refresh_development_certificates do
    refresh_certificates build_configuration: :test
    refresh_certificates build_configuration: :qa
  end

  desc "Updates or downloads the `Certificates` and `Provisioning Profiles` for the configurations mapped to `:appstore`."
  lane :refresh_internal_appstore_certificates do
    refresh_certificates build_configuration: :appstore
  end

  desc "Updates or downloads the `Certificates` and `Provisioning Profiles` for the configurations mapped to `:production`."
  lane :refresh_external_appstore_certificates do
    refresh_certificates build_configuration: :production
  end

  desc "Adds a new device and regenerates the `Provisioning Profile`s to include it."
  lane :add_device do
    add_single_device
  end

end
