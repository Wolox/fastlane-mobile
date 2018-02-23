module Fastlane
  module Actions
    class InferBundleIdentifierAction < Action

      # Given an environment
      # this script builds the corresponding bundle identifier
      # that should be used.
      # The bundle identifiers will have no whitespaces.

      # This is useful to validate the bundle identifiers chosen
      # during the kickoff are correct.

      TEAM_NAME_KEY = "TEAM_NAME".freeze
      BUNDLE_ID_FORMAT_KEY = "BUNDLE_ID_FORMAT".freeze
      BUNDLE_ID_KEY = "BUNDLE_ID".freeze
      BUNDLE_ID_DOWNCASED_KEY = "BUNDLE_ID_DOWNCASED".freeze

      # Format for bundle identifiers by environment.
      BUNDLE_IDENTIFIERS_FORMAT = {
        test: "com.%s.%s.debug",
        qa: "com.%s.%s.alpha",
        appstore: "com.%s.%s",
        production: "com.%s.%s"
      }.freeze

      def self.run(params)
        environment = params[:environment]
        environment_info = Actions::GetEnvironmentInfoAction.run(environment: params[:environment])

        project_name = ProjectNameAction.run(environment: environment)
        team_name = environment_info[TEAM_NAME_KEY] || project_name
        bundle_identifier_format = environment_info[BUNDLE_ID_FORMAT_KEY] || BUNDLE_IDENTIFIERS_FORMAT[environment]
        bundle_id = (environment_info[BUNDLE_ID_KEY] || bundle_identifier_format % [team_name, project_name]).gsub(/\s+/, "")

        (environment_info[BUNDLE_ID_DOWNCASED_KEY]) ? bundle_id.downcase : bundle_id
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
