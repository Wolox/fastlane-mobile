require 'xcodeproj'

module Fastlane
  module Actions
    class ProjectNameAction < Action

      PROJECT_EXTENSION_KEY = "PROJECT_EXTENSION".freeze
      PROJECT_NAME_KEY = "PROJECT_NAME".freeze

      DEFAULT_PROJECT_EXTENSION = ".xcodeproj".freeze

      # This script returns the application name
      # if there is a scheme that matches the project name.
      # Otherwise, it assumes the project name should be specified
      # by the user and fails.

      def self.run(params)
        if params[:environment]
          environment_info = Actions::GetEnvironmentInfoAction.run(environment: params[:environment])
        else
          environment_info = Actions::GetEnvironmentInfoAction.run({})
        end
        project_extension = environment_info[PROJECT_EXTENSION_KEY] || DEFAULT_PROJECT_EXTENSION
        environment_info[PROJECT_NAME_KEY] || default_project_name(project_extension)
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

      # Available options default_value helpers

      # In case there is a single '.xcodeproj' in the default directory
      # it can be automatically inferred by the script
      # if no parameter project is received.
      def self.default_project(project_extension = nil)
        project_extension = project_extension || Actions::GetEnvironmentInfoAction.run({})[PROJECT_EXTENSION_KEY] || DEFAULT_PROJECT_EXTENSION
        projects = Dir.entries('.').select { |each| File.extname(each) == project_extension }
        if projects.length == 0
          UI.abort_with_message! "No projects with extension '#{project_extension}' found in root directory."
        end
        if projects.length > 1
          UI.abort_with_message! "Multiple projects with extension '#{project_extension}' found in root directory."
        end
        projects.first
      end

      # In case there is a scheme matching project's name
      # it can be automatically inferred by the script
      # if no parameter scheme is received.
      def self.matching_scheme(project_extension = nil)
        project_extension = project_extension || Actions::GetEnvironmentInfoAction.run({})[PROJECT_EXTENSION_KEY] || DEFAULT_PROJECT_EXTENSION
        default_proj = default_project(project_extension)
        target = Xcodeproj::Project.open(default_proj)
          .targets
          .find { |each| each.name == File.basename(default_proj, File.extname(default_proj)) }
        if target.nil?
          UI.abort_with_message! "No target matching project name '#{default_proj}' found."
        end
        target.name
      end

      # Just a wrapper for the matching scheme function.
      def self.default_project_name(project_extension = nil)
        project_extension = project_extension || Actions::GetEnvironmentInfoAction.run({})[PROJECT_EXTENSION_KEY] || DEFAULT_PROJECT_EXTENSION
        matching_scheme(project_extension)
      end

      # Name of the project file.
      def self.default_project_filename(project_extension = nil)
        project_extension = project_extension || Actions::GetEnvironmentInfoAction.run({})[PROJECT_EXTENSION_KEY] || DEFAULT_PROJECT_EXTENSION
        matching_scheme(project_extension) + project_extension
      end

    end
  end
end
