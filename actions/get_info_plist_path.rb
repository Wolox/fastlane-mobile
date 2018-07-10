module Fastlane
  module Actions
    class GetInfoPlistPathAction < Action

      # Given an environment
      # this script returns the Info.plist file path associated to it.

      INFO_PLIST_KEY = "INFOPLIST_FILE".freeze

      def self.run(params)
        project = Actions::ProjectNameAction.run(params)
        scheme_name = Actions::GetSchemeAction.run(params)
        project = XcodeProject::Project.open(project)
        scheme = project.native_targets.detect { |target| target.name == scheme_name }
        plist_path = scheme.build_configurations.first.build_settings[INFO_PLIST_KEY]
        return plist_path
      end

      # Fastlane Action class required functions.

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :environment, optional: true, type: Symbol)
        ]
      end

    end
  end
end
