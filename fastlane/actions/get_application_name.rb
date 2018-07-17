module Fastlane
  module Actions
    class GetApplicationNameAction < Action

      # Given an environment
      # this script returns the application name associated to it.

      ENV_KEY = "APP_NAME".freeze

      # Default App ID names by environment
      DEFAULT_APPLICATION_NAMES = {
        dev: "%s Debug",
        qa: "%s Alpha",
        stage: "%s",
        production: "%s"
      }.freeze

      def self.run(params)
        info = Actions::GetEnvironmentInfoAction.run(environment: params[:environment])
        (info[ENV_KEY] || DEFAULT_APPLICATION_NAMES[params[:environment]]) % params[:project_name]
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
