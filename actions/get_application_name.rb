module Fastlane
  module Actions
    class GetApplicationNameAction < Action

      # Given an environment
      # this script returns the application name associated to it.

      # Default App ID names by environment
      APPLICATION_NAMES = {
        test: "%s Dev",
        qa: "%s Alpha",
        appstore: "%s",
        production: "%s"
      }.freeze

      def self.run(params)
        APPLICATION_NAMES[params[:environment]] % params[:project_name]
      end

      # Fastlane Action class required functions.

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :environment, optional: false, type: Symbol),
          FastlaneCore::ConfigItem.new(key: :project_name, optional: true, default_value: ProjectNameAction.default_project_name),
        ]
      end

    end
  end
end
