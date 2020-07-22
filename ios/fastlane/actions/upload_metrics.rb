module Fastlane
  module Actions
    class UploadMetricsAction < Action

      # Given an time measurement
      # this script uploads the deploy time metric

      METRICS_PROJECT_ENV_KEY = "METRICS_PROJECT".freeze
      METRICS_REPO_NAME_ENV_KEY = "METRICS_REPO_NAME".freeze
      METRICS_TECH_ENV_KEY = "METRICS_TECH".freeze
      METRICS_URL_ENV_KEY = "METRICS_URL".freeze

      def self.run(params)
        begin
          config = Actions::GetEnvironmentInfoAction.run(environment: params[:environment])
          metrics_project = config[METRICS_PROJECT_ENV_KEY]
          metrics_repo_name = config[METRICS_REPO_NAME_ENV_KEY]
          metrics_tech = config[METRICS_TECH_ENV_KEY]
          metrics_url = config[METRICS_URL_ENV_KEY]
          if !metrics_project || !metrics_repo_name || !metrics_tech || !metrics_url
            UI.message "Skipping metrics upload: missing env variables"
            return
          end
          UI.message "Uploading #{params[:metric_name]} metric (#{params[:time_elapsed].to_s})"

          uri = URI.parse metrics_url

          header = {'Content-Type': 'application/json'}
          body = {
            env: params[:environment],
            repo_name: metrics_repo_name,
            project_name: metrics_project,
            metrics: [{
              "name": params[:metric_name],
              "value": params[:time_elapsed],
              "version": "1.0"
            }]
          }

          if metrics_tech === "react_native"
            body[:tech] = "react_native"
            body[:subtech] = "ios"
          else
            body[:tech] = "ios"
          end

          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          response = http.post(uri.path, body.to_json, header)

          if response.message === "OK"
            UI.message "#{params[:metric_name]} metric saved succesfully"
          else
            UI.error "#{params[:metric_name]} metric could not be saved"
          end
        rescue
          UI.error "Skipping #{params[:metric_name]} metric upload: unexpected error"
        end
      end

      # Fastlane Action class required functions.

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :environment, optional: false, type: Symbol),
          FastlaneCore::ConfigItem.new(key: :time_elapsed, optional: false, type: Float),
          FastlaneCore::ConfigItem.new(key: :metric_name, optional: false, type: String)
        ]
      end

    end
  end
end
