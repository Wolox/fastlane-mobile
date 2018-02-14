module Fastlane
  module Actions
    class UsesInternalAccountAction < Action

      # Given an environment
      # this script returns if the application should use internal account.

      # Whether application uses or not internal account.
      USES_INTERNAL_ACCOUNT = {
        test: true,
        qa: true,
        appstore: true,
        production: false
      }.freeze

      def self.run(params)
        USES_INTERNAL_ACCOUNT[params[:environment]]
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
