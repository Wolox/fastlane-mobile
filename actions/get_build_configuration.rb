module Fastlane
  module Actions
    class GetBuildConfigurationAction < Action

      # Given a build configuration action
      # this script returns the build configuration associated to it.

      # Default build configuration by action
      BUILD_CONFIGURATIONS = {
        test: "Debug",
        qa: "Alpha",
        appstore: "Release",
        production: "Production"
      }.freeze

      def self.run(params)
        BUILD_CONFIGURATIONS[params[:build_configuration]]
      end

      # Fastlane Action class required functions.

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :build_configuration, optional: false, is_string: false)
        ]
      end

    end
  end
end
