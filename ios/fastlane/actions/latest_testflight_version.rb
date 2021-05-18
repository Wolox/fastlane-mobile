require 'spaceship'

module Fastlane
  module Actions
    class LatestTestflightVersionAction < Action

      # Retrieves the latest version uploaded to ItunesConnect

      def self.run(params)

        app = Spaceship::ConnectAPI::App.find(params[:bundle_id])
        if app.nil?
          UI.abort_with_message! "The application with bundle ID '#{params[:bundle_id]}' is not yet created in iTunes Connect."
        end

        v = app.get_edit_app_store_version

        if v.nil?
          v = app.get_live_app_store_version 
        end
        
        if v.nil?
          return params[:initial_version_number]
        end

        return v.versionString.length === 3 ? "#{v.versionString}.0" : v.versionString
      end

      # Fastlane Action class required functions.

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :bundle_id, optional: false),
          FastlaneCore::ConfigItem.new(key: :initial_version_number, optional: false),
          FastlaneCore::ConfigItem.new(key: :username, optional: false),
          FastlaneCore::ConfigItem.new(key: :team_id, optional: false)
        ]
      end

    end
  end
end
