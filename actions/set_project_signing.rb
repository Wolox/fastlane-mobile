require 'xcodeproj'

module Fastlane
  module Actions
    class SetProjectSigningAction < Action

      # Given a project, a scheme, and a build configuration
      # this script updates the provisioning profile and development team
      # to have proper signing identities in xCode.

      PROVISIONING_PROFILE_SPECIFIER = 'PROVISIONING_PROFILE_SPECIFIER'
      DEVELOPMENT_TEAM = 'DEVELOPMENT_TEAM'

      def self.run(params)
        # Set provisioning profile in xCode
        Actions::UpdateProjectPropertyAction.run(
          project: params[:project],
          scheme: params[:scheme],
          build_configuration: params[:build_configuration],
          build_setting: PROVISIONING_PROFILE_SPECIFIER,
          build_setting_value: params[:provisioning_profile]
        )

        # Set development team in xCode
        Actions::UpdateProjectPropertyAction.run(
          project: params[:project],
          scheme: params[:scheme],
          build_configuration: params[:build_configuration],
          build_setting: DEVELOPMENT_TEAM,
          build_setting_value: params[:development_team]
        )
      end

      # Fastlane Action class required functions.

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :project, optional: true, default_value: ProjectNameAction.default_project_filename),
          FastlaneCore::ConfigItem.new(key: :scheme, optional: true, default_value: ProjectNameAction.default_project_name),
          FastlaneCore::ConfigItem.new(key: :build_configuration, optional: false),
          FastlaneCore::ConfigItem.new(key: :provisioning_profile, optional: false),
          FastlaneCore::ConfigItem.new(key: :development_team, optional: false),
        ]
      end

    end
  end
end
