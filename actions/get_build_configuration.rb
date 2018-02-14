module Fastlane
  module Actions
    class GetBuildConfigurationAction < Action

      # Given an environment
      # this script returns the build configuration associated to it.

      # Default build configuration by environment
      BUILD_CONFIGURATIONS = {
        test: "Debug",
        qa: "Alpha",
        appstore: "Release",
        production: "Production"
      }.freeze

      def self.run(params)
        BUILD_CONFIGURATIONS[params[:environment]]
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
