module Fastlane
  module Actions
    class GetBuildConfigurationAction < Action

      # Given an environment
      # this script returns the build configuration associated to it.

      ENV_KEY = "BUILD_CONFIGURATION".freeze

      # Default build configuration by environment
      DEFAULT_BUILD_CONFIGURATIONS = {
        test: "Debug",
        qa: "Alpha",
        appstore: "Release",
        production: "Production"
      }.freeze

      def self.run(params)
        Actions::GetEnvironmentInfoAction.run(environment: params[:environment])[ENV_KEY] || DEFAULT_BUILD_CONFIGURATIONS[params[:environment]]
      end

      def self.get_all_build_configurations
        {
          test: Actions::GetEnvironmentInfoAction.run(environment: :test)[ENV_KEY] || DEFAULT_BUILD_CONFIGURATIONS[:test],
          qa: Actions::GetEnvironmentInfoAction.run(environment: :qa)[ENV_KEY] || DEFAULT_BUILD_CONFIGURATIONS[:qa],
          appstore: Actions::GetEnvironmentInfoAction.run(environment: :appstore)[ENV_KEY] || DEFAULT_BUILD_CONFIGURATIONS[:appstore],
          production: Actions::GetEnvironmentInfoAction.run(environment: :production)[ENV_KEY] || DEFAULT_BUILD_CONFIGURATIONS[:production]
        }
      end

      # Fastlane Action class required functions.

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :environment, optional: false, type: Symbol)
        ]
      end

    end
  end
end
