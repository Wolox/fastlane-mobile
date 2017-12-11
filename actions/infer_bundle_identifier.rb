module Fastlane
  module Actions
    class InferBundleIdentifierAction < Action

      # Given a build configuration
      # this script builds the corresponding bundle identifier
      # that should be used.

      # This is useful to validate the bundle identifiers chosen
      # during the kickoff are correct.

      # Format for bundle identifiers by build configuration.
      BUNDLE_IDENTIFIERS_FORMAT = {
        test: "com.%s.%s.debug",
        qa: "com.%s.%s.alpha",
        appstore: "com.%s.%s",
        production: "com.%s.%s"
      }.freeze

      # Internal account team name to be used in bundle IDs.
      INTERNAL_ACCOUNT_TEAM_NAME = 'Wolox'

      def self.run(params)
        # For legacy projects, just override the return value
        # with the desired bundle identifier.
        bundle_identifier_format = BUNDLE_IDENTIFIERS_FORMAT[params[:build_configuration]]
        uses_internal_account = Actions::UsesInternalAccountAction.run(build_configuration: params[:build_configuration])
        team_name = uses_internal_account ? INTERNAL_ACCOUNT_TEAM_NAME : ProjectNameAction.default_project_name
        bundle_identifier_format % [team_name, ProjectNameAction.default_project_name]
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
