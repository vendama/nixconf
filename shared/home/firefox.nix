{...}: {
  programs.firefox = {
    enable = true;
    policies = {
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisablePasswordReveal = true;
      DisablePocket = true;
      DisableTelemetry = true;
      OfferToSaveLogins = false;

      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        Stories = false;
        SponsoredPocket = false;
        SponsoredStories = false;
        Locked = true;
      };

      GenerativeAI = {
        Enabled = false;
        Locked = true;
      };

      PictureInPicture = {
        Enabled = false;
        Locked = true;
      };

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        SuspectedFingerprinting = true;
      };

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = false;
        Locked = true;
      };

      SearchEngines.Default = "DuckDuckGo";

      BlockAboutAddons = true;
      BlockAboutConfig = true;

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          default_area = "navbar";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
      InstallAddonsPermission.Default = false;
      "3rdparty".Extensions."uBlock0@raymondhill.net".toOverwrite.filterLists = [
        # Default uBo filters
        "user-filters"
        "ublock-filters"
        "ublock-badware"
        "ublock-privacy"
        "ublock-abuse"
        "ublock-quick-fixes"
        "ublock-unbreak"
        "easylist"
        "easyprivacy"
        "urlhaus-1"
        "plowe-0"
        # Additional: Cookie Notices
        "fanboy-cookiemonster" # EasyList - Cookie Notices
        "ublock-cookies-easylist" # uBlock filters - Cookie Notices
        "adguard-cookies" # AdGuard - Cookie Notices
        "ublock-cookies-adguard" # uBlock filters - Cookie Notices
      ];
    };
  };
}
