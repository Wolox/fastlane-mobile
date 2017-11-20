module Fastlane
  module Actions
    class GetMatchTypeAction < Action

      # Given a build configuration
      # this script returns the match type associated to it.

      # Default match types by build configuration
      MATCH_TYPES = {
        test: "development",
        qa: "appstore",
        appstore: "appstore",
        production: "appstore"
      }.freeze

      def self.run(params)
        MATCH_TYPES[params[:build_configuration]]
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
