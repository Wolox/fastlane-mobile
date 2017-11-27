module Fastlane
  module Actions
    class SetInfoPlistVersionAction < Action

      # Sets the version and build number in project Info.plist

      # Defaul path for project Info.plist
      PROJECT_PLIST_PATH = "%s/Info.plist".freeze

      VERSION_NUMBER_KEY = 'CFBundleShortVersionString'
      BUILD_NUMBER_KEY = 'CFBundleVersion'

      def self.run(params)
        # Set version number in `Info.plist`
        Actions::SetInfoPlistValueAction.run(
          path: PROJECT_PLIST_PATH % params[:project_name],
          key: VERSION_NUMBER_KEY,
          value: params[:version_number]
        )

        # Set build number in `Info.plist`
        Actions::SetInfoPlistValueAction.run(
          path: PROJECT_PLIST_PATH % params[:project_name],
          key: BUILD_NUMBER_KEY,
          value: params[:build_number]
        )
      end

      # Fastlane Action class required functions.

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :project_name, optional: true, default_value: ProjectNameAction.default_project_name),
          FastlaneCore::ConfigItem.new(key: :version_number, optional: false),
          FastlaneCore::ConfigItem.new(key: :build_number, optional: false),
        ]
      end

    end
  end
end
