module Fastlane
  module Actions
    class GetApplicationNameAction < Action

      # Given a build configuration
      # this script returns the application name associated to it.

      # Default App ID names by build configuration
      APPLICATION_NAMES = {
        test: "%s Dev",
        qa: "%s Alpha",
        appstore: "%s",
        production: "%s"
      }.freeze

      def self.run(params)
        APPLICATION_NAMES[params[:build_configuration]]
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
