fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

## Choose your installation method:

<table width="100%" >
<tr>
<th width="33%"><a href="http://brew.sh">Homebrew</a></th>
<th width="33%">Installer Script</th>
<th width="33%">RubyGems</th>
</tr>
<tr>
<td width="33%" align="center">macOS</td>
<td width="33%" align="center">macOS</td>
<td width="33%" align="center">macOS or Linux with Ruby 2.0.0 or above</td>
</tr>
<tr>
<td width="33%"><code>brew cask install fastlane</code></td>
<td width="33%"><a href="https://download.fastlane.tools">Download the zip file</a>. Then double click on the <code>install</code> script (or run it in a terminal window).</td>
<td width="33%"><code>sudo gem install fastlane -NV</code></td>
</tr>
</table>

# Available Actions
## iOS
### ios add_single_device
```
fastlane ios add_single_device
```
Adds a new device and regenerates the `Provisioning Profile`s to include it.
### ios release_qa
```
fastlane ios release_qa
```
Before doing anything else.

After all the steps have completed succesfully.

If there was an error.

New release to iTunes Connect for QA (Alpha). This lane will never update the version, only the build number.
### ios release_internal_appstore
```
fastlane ios release_internal_appstore
```
New release to iTunes Connect for AppStore (Release) in Wolox account.

Parameters:

- bump_type (optional): represents the type of deploy. If not specified, the user will be asked for it.
### ios release_external_appstore
```
fastlane ios release_external_appstore
```
New release to iTunes Connect for AppStore (Production) in third party account.

Parameters:

- bump_type (optional): represents the type of deploy. If not specified, the user will be asked for it.
### ios test
```
fastlane ios test
```
Executes the tests for the project using `scan`. This lane uses the configuration mapped to `:test`.
### ios create_development_app
```
fastlane ios create_development_app
```
Creates the `App ID` and `Provisioning Profile` for the configurations mapped to `:test` and `:qa`.
### ios create_internal_appstore_app
```
fastlane ios create_internal_appstore_app
```
Creates the `App ID` and `Provisioning Profile` for the configuration mapped to `:appstore`.
### ios create_external_appstore_app
```
fastlane ios create_external_appstore_app
```
Creates the `App ID` and `Provisioning Profile` for the configuration mapped to `:production`.
### ios generate_push_certificates_development
```
fastlane ios generate_push_certificates_development
```
Generates the push notifications certificates for the build configurations mapped to `:test` and `:qa`.
### ios generate_push_certificates_internal_appstore
```
fastlane ios generate_push_certificates_internal_appstore
```
Generates the push notifications certificates for the build configurations mapped to `:appstore`.
### ios generate_push_certificates_external_appstore
```
fastlane ios generate_push_certificates_external_appstore
```
Generates the push notifications certificates for the build configurations mapped to `:production`.
### ios refresh_development_certificates
```
fastlane ios refresh_development_certificates
```
Updates or downloads the `Certificates` and `Provisioning Profiles` for the configurations mapped to `:test` and `:qa`.
### ios refresh_internal_appstore_certificates
```
fastlane ios refresh_internal_appstore_certificates
```
Updates or downloads the `Certificates` and `Provisioning Profiles` for the configurations mapped to `:appstore`.
### ios refresh_external_appstore_certificates
```
fastlane ios refresh_external_appstore_certificates
```
Updates or downloads the `Certificates` and `Provisioning Profiles` for the configurations mapped to `:production`.
### ios add_device
```
fastlane ios add_device
```
Adds a new device and regenerates the `Provisioning Profile`s to include it.

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
