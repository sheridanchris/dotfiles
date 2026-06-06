{
  pkgs,
  inputs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];
    programs.zen-browser = {
      enable = true;
      profiles.default = {
      };
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        OfferToSaveLogins = false;
        NoDefaultBookmarks = true;
        AutofillCreditCardEnabled = false;
        DisplayBookmarksToolbar = "always";
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        SanitizeOnShutdown = {
          FormData = true;
          Cache = true;
        };
        # ExtensionSettings = mkExtensionSettings {
        #   "uBlock0@raymondhill.net" = "ublock-origin";
        #   "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
        #   "sponsorBlocker@ajay.app" = "sponsorblock";
        #   "{de22fd49-c9ab-4359-b722-b3febdc3a0b0}" = "popup-blocker";
        #   "{7b1bf0b6-a1b9-42b0-b75d-252036438bdc}" = "youtube-high-definition";
        # };
        Preferences = {
          "places.history.enabled" = false;
          "browser.sessionstore.max_tabs_undo" = 0;
        };
      };
    };
    stylix.targets.zen-browser = {
      enable = true;
      enableCss = true;
      profileNames = ["default"];
    };
  };
}
