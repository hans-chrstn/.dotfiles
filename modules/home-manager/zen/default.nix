{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.mod.programs.zen;
in {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];
  options.mod.programs.zen = {
    enable = lib.mkEnableOption "Enable zen";
  };

  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
      profiles = {
        default = {
          isDefault = true;
        };
      };
      policies = let
        mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
          installation_mode = "force_installed";
        });
        mkLockedAttrs = builtins.mapAttrs (_: value: {
          Value = value;
          Status = "locked";
        });
      in {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        HttpsOnlyMode = {
          Enabled = true;
          Locked = true;
        };
        HardwareAcceleration = true;
        PasswordManagerEnabled = false;
        FirefoxSuggest = {
          WebSuggestions = false;
          SponsoredSuggestions = false;
          ImproveSuggestions = false;
        };
        DisableFirefoxAccounts = false;
        TranslateEnabled = false;
        DisableFormHistory = true;
        SearchSuggestEnabled = false;
        NetworkPrediction = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        SanitizeOnShutdown = {
          Enabled = true;
          Locked = true;
          Cache = false;
          Cookies = false;
          History = false;
          Downloads = false;
          FormData = true;
          OfflineApps = true;
          Passwords = true;
          Sessions = false;
        };

        SearchEngines = {
          Default = "DuckDuckGo";

          PreventInstalls = true;

          Remove = [
            "Google"
            "Bing"
            "Wikipedia (en)"
          ];

          Add = [
            {
              Name = "Google";
              Alias = "gg";
              Method = "GET";
              URLTemplate = "https://google.com/search?q={searchTerms}";
              SuggestURLTemplate = "https://google.com/complete/search?client=firefox&q={searchTerms}";
            }
            {
              Name = "YouTube";
              Alias = "yt";
              Method = "GET";
              URLTemplate = "https://youtube.com/results?search_query={searchTerms}";
            }
            {
              Name = "GitHub";
              Alias = "gh";
              Method = "GET";
              URLTemplate = "https://github.com/search?type=repositories&q={searchTerms}";
            }
            {
              Name = "Crates.rs";
              Alias = "cr";
              Method = "GET";
              URLTemplate = "https://crates.io/search?q={searchTerms}";
            }
            {
              Name = "Lib.rs";
              Alias = "rs";
              Method = "GET";
              URLTemplate = "https://lib.rs/search?q={searchTerms}";
            }
            {
              Name = "Searchix";
              Alias = "sx";
              Method = "GET";
              URLTemplate = "https://searchix.ovh/?query={searchTerms}";
            }
            {
              Name = "NixOS Packages";
              Alias = "np";
              Method = "GET";
              URLTemplate = "https://search.nixos.org/packages?channel=unstable&sort=relevance&type=packages&query={searchTerms}";
            }
            {
              Name = "NixOS Options";
              Alias = "no";
              Method = "GET";
              URLTemplate = "https://search.nixos.org/options?channel=unstable&sort=relevance&type=options&query={searchTerms}";
            }
            {
              Name = "Home Manager Options";
              Alias = "ho";
              Method = "GET";
              URLTemplate = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}";
            }
            {
              Name = "Nix Darwin Options";
              Alias = "do";
              Method = "GET";
              URLTemplate = "https://options.nix-darwin.uz/?release=master&query={searchTerms}";
            }
          ];
        };

        Preferences = mkLockedAttrs {
          "dom.event.clipboardevents.enabled" = false;
          "geo.enabled" = false;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "beacon.enabled" = false;
          "ui.key.menuAccessKey" = 0;
          "media.autoplay.default" = 1;
          "browser.newtabpage.enabled" = false;
          "media.peerconnection.ice.no_host" = true;
        };

        ExtensionSettings = mkExtensionSettings {
          "uBlock0@raymondhill.net" = "ublock-origin";

          "@bitwarden" = "bitwarden-password-manager";
        };
      };
    };
  };
}
