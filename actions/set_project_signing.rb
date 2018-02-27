require 'xcodeproj'

module Fastlane
  module Actions
    class SetProjectSigningAction < Action

      SCHEME_ENV_KEY = "SCHEME".freeze

      # Given a project, a scheme, and a build configuration
      # this script updates the provisioning profile and development team
      # to have proper signing identities in xCode.

      PROVISIONING_PROFILE_SPECIFIER = 'PROVISIONING_PROFILE_SPECIFIER'.freeze
      DEVELOPMENT_TEAM = 'DEVELOPMENT_TEAM'.freeze

      def self.run(params)
        if params[:environment]
          environment_info = Actions::GetEnvironmentInfoAction.run(environment: params[:environment])
        else
          environment_info = Actions::GetEnvironmentInfoAction.run({})
        end
        scheme = environment_info[SCHEME_ENV_KEY] || Actions::ProjectNameAction.run({})

        # Set provisioning profile in xCode
        Actions::UpdateProjectPropertyAction.run(
          project: params[:project],
          environment: environment,
          build_configuration: params[:build_configuration],
          build_setting: PROVISIONING_PROFILE_SPECIFIER,
          build_setting_value: params[:provisioning_profile]
        )

        # Set development team in xCode
        Actions::UpdateProjectPropertyAction.run(
          project: params[:project],
          environment: environment,
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
          FastlaneCore::ConfigItem.new(key: :project, optional: true, default_value: Actions::ProjectNameAction.project_filename),
          FastlaneCore::ConfigItem.new(key: :environment, optional: true, type: Symbol),
          FastlaneCore::ConfigItem.new(key: :build_configuration, optional: false),
          FastlaneCore::ConfigItem.new(key: :provisioning_profile, optional: false),
          FastlaneCore::ConfigItem.new(key: :development_team, optional: false),
        ]
      end

    end
  end
end
