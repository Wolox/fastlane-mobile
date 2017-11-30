module Fastlane
  module Actions
    class LatestTestflightVersionAction < Action

      # Retrieves the latest version uploaded to ItunesConnect

      def self.run(params)
        Spaceship::Tunes.login

        # This may be done automatically, but for some reason it has to be done manually.
        # Open issue: https://github.com/fastlane/fastlane/issues/10944
        Spaceship::Tunes.client.team_id = CredentialsManager::AppfileConfig.try_fetch_value(:itc_team_id)

        app = Spaceship::Tunes::Application.find(params[:bundle_id])
        if app.nil?
          UI.abort_with_message! "The application with bundle ID '#{params[:bundle_id]}' is not yet created in iTunes Connect."
        end
        app.all_build_train_numbers.max || params[:initial_version_number]
      end

      # Fastlane Action class required functions.

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :bundle_id, optional: false),
          FastlaneCore::ConfigItem.new(key: :initial_version_number, optional: false),
        ]
      end

    end
  end
end
