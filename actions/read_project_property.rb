require 'xcodeproj'

module Fastlane
  module Actions
    class ReadProjectPropertyAction < Action

      SCHEME_ENV_KEY = "SCHEME".freeze

      # Given a project, a scheme, and a build configuration
      # this script returns the corresponding value for the
      # provided build setting.

      def self.run(params)
        if params[:environment]
          environment_info = Actions::GetEnvironmentInfoAction.run(environment: params[:environment])
        else
          environment_info = Actions::GetEnvironmentInfoAction.run({})
        end
        scheme = environment_info[SCHEME_ENV_KEY] || Actions::ProjectNameAction.run({})
        build_configuration = Xcodeproj::Project.open(params[:project])
          .targets.find { |each| each.name == scheme }
          .build_configurations.find { |each| each.name == params[:build_configuration] }

        if build_configuration.nil?
          UI.abort_with_message! "Build configuration '#{params[:build_configuration]}' is not configured."
        end

        build_configuration.build_settings[params[:build_setting]]
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
          FastlaneCore::ConfigItem.new(key: :build_setting, optional: false)
        ]
      end

    end
  end
end
