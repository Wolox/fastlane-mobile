module Fastlane
  module Actions
    class ReadXcconfigPropertyAction < Action

      # Based on a xcconfig file path and a key name,
      # reads and returns the value for key in the corresponding xcconfig.

      # This is useful in case sensitive data stored in xcconfig files
      # is needed to be accessed from a fastlane script.

      ENV_KEY = "PROJECT_XCCONFIG_PATH"

      # Default xcconfig files path.
      DEFAULT_PROJECT_XCCONFIG_PATH = "%s/ConfigurationFiles/%s.xcconfig"

      def self.run(params)
        xcconfig_path_format = Actions::GetEnvironmentInfoAction.run({})[ENV_KEY] || DEFAULT_PROJECT_XCCONFIG_PATH
        xcconfig_path = xcconfig_path_format % [params[:project_name], params[:build_configuration]]

        if !File.exist?(xcconfig_path)
          UI.important "Configuration file at path #{xcconfig_path} not found. Please make sure the file exists."
          return nil
        end

        line = File.open(xcconfig_path).find { |each| each.start_with? params[:xcconfig_key] }
        line.to_s.empty? ? nil : line.split('=').last.strip
      end

      # Fastlane Action class required functions.

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :project_name, optional: true, default_value: ProjectNameAction.default_project_name),
          FastlaneCore::ConfigItem.new(key: :build_configuration, optional: false),
          FastlaneCore::ConfigItem.new(key: :xcconfig_key, optional: false)
        ]
      end

    end
  end
end
