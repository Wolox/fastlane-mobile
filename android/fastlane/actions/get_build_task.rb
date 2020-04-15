module Fastlane
  module Actions
    class GetBuildTaskAction < Action

      # Given an environment this script
      # returns the build task associated to it.

      def self.run(params)
        environment = params[:environment].capitalize
        is_firebase = params[:firebase]

        {
          task: is_firebase ? "assemble" : "bundle",
          flavor: "#{environment}",
        }
      end

      # Fastlane Action class required functions.

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :environment, optional: false, type: Symbol),
          FastlaneCore::ConfigItem.new(key: :firebase, optional: true, type: Boolean)
        ]
      end

    end
  end
end
