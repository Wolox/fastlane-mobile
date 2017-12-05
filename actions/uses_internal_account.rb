module Fastlane
  module Actions
    class UsesInternalAccountAction < Action

      # Given a build configuration action
      # this script returns if the application should use internal account.

      # Whether application uses or not internal account.
      USES_INTERNAL_ACCOUNT = {
        test: true,
        qa: true,
        appstore: true,
        production: false
      }.freeze

      def self.run(params)
        USES_INTERNAL_ACCOUNT[params[:build_configuration]]
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
