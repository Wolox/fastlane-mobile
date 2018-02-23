module Fastlane
  module Actions
    class GetApplicationNameAction < Action

      # Given an environment
      # this script returns the application name associated to it.

      FULL_NAME_ENV_KEY = "APP_FULL_NAME".freeze
      NAME_FORMAT_ENV_KEY = "APP_NAME_FORMAT".freeze

      # Default App ID names by environment
      APPLICATION_NAMES = {
        test: "%s Debug",
        qa: "%s Alpha",
        appstore: "%s",
        production: "%s"
      }.freeze

      def self.run(params)
        info = Actions::GetEnvironmentInfoAction.run(environment: params[:environment])
        info[FULL_NAME_ENV_KEY] || info[NAME_FORMAT_ENV_KEY] % params[:project_name] || APPLICATION_NAMES[params[:environment]] % params[:project_name]
      end

      # Fastlane Action class required functions.

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :environment, optional: false, type: Symbol),
          FastlaneCore::ConfigItem.new(key: :project_name, optional: true, default_value: Actions::ProjectNameAction.default_project_name),
        ]
      end

    end
  end
end
