{ pkgs, inputs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
    policies = {
			AppAutoUpdate = false; # Disable automatic application update
			BackgroundAppUpdate = false; # Disable automatic application update in the background, when the application is not running.
			DisableBuiltinPDFViewer = true; # Considered a security liability
			DisableFirefoxStudies = true;
			#DisableFirefoxAccounts = true; # Disable Firefox Sync
			DisableFirefoxScreenshots = true; # No screenshots?
			DisableForgetButton = true; # Thing that can wipe history for X time, handled differently
			DisableMasterPasswordCreation = true; # To be determined how to handle master password
			DisableProfileImport = true; # Purity enforcement: Only allow nix-defined profiles
			DisableProfileRefresh = true; # Disable the Refresh Firefox button on about:support and support.mozilla.org
			DisableSetDesktopBackground = true; # Remove the “Set As Desktop Background…” menuitem when right clicking on an image, because Nix is the only thing that can manage the backgroud
			DisplayMenuBar = "default-off";
			DisablePocket = true;
			DisableTelemetry = true;
			DisableFormHistory = true;
			DisablePasswordReveal = true;
			DontCheckDefaultBrowser = true; # Stop being attention whore
			HardwareAcceleration = true; # Disabled as it's exposes points for fingerprinting
			OfferToSaveLogins = false; # Managed by KeepAss instead
			EnableTrackingProtection = {
				Value = true;
				Locked = true;
				Cryptomining = true;
				Fingerprinting = true;
				EmailTracking = true;
				# Exceptions = ["https://example.com"]
			};
			EncryptedMediaExtensions = {
				Enabled = true;
				Locked = true;
			};
			#ExtensionUpdate = false;
			# FIXME(Krey): Review `~/.mozilla/firefox/Default/extensions.json` and uninstall all unwanted
			# Suggested by t0b0 thank you <3 https://gitlab.com/engmark/root/-/blob/60468eb82572d9a663b58498ce08fafbe545b808/configuration.nix#L293-310
			# NOTE(Krey): Check if the addon is packaged on https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/addons.json
			#ExtensionSettings = {
			#	"*" = {
			#		installation_mode = "blocked";
			#		blocked_install_message = "FUCKING FORGET IT!";
			#	};
			FirefoxHome = {
				Search = true;
				TopSites = true;
				SponsoredTopSites = false; # Fuck you
				Highlights = true;
				Pocket = false;
				SponsoredPocket = false; # Fuck you
				Snippets = false;
				Locked = true;
			};
			FirefoxSuggest = {
				WebSuggestions = false;
				SponsoredSuggestions = false; # Fuck you
				ImproveSuggest = false;
				Locked = true;
			};
			Handlers = {
				# FIXME-QA(Krey): Should be openned in evince if on GNOME
				mimeTypes."application/pdf".action = "saveToDisk";
			};
			extensions = {
				pdf = {
					action = "useHelperApp";
					ask = true;
					# FIXME-QA(Krey): Should only happen on GNOME
					handlers = [
						{
							name = "GNOME Document Viewer";
							path = "${pkgs.evince}/bin/evince";
						}
					];
				};
			};
			NoDefaultBookmarks = true;
			PasswordManagerEnabled = false; # Managed by KeepAss
			PDFjs = {
				Enabled = false; # Fuck No, HELL NO
				EnablePermissions = false;
			};
			# Permissions = {
			# 	Camera = {
			# 		Allow = [https =//example.org,https =//example.org =1234];
			# 		Block = [https =//example.edu];
			# 		BlockNewRequests = true;
			# 		Locked = true
			# 	};
			# 	Microphone = {
			# 		Allow = [https =//example.org];
			# 		Block = [https =//example.edu];
			# 		BlockNewRequests = true;
			# 		Locked = true
			# 	};
			# 	Location = {
			# 		Allow = [https =//example.org];
			# 		Block = [https =//example.edu];
			# 		BlockNewRequests = true;
			# 		Locked = true
			# 	};
			# 	Notifications = {
			# 		Allow = [https =//example.org];
			# 		Block = [https =//example.edu];
			# 		BlockNewRequests = true;
			# 		Locked = true
			# 	};
			# 	Autoplay = {
			# 		Allow = [https =//example.org];
			# 		Block = [https =//example.edu];
			# 		Default = allow-audio-video | block-audio | block-audio-video;
			# 		Locked = true
			# 	};
			# };
			PictureInPicture = {
				Enabled = true;
				Locked = true;
			};
			PromptForDownloadLocation = true;
			SanitizeOnShutdown = {
				Cache = true;
				Cookies = false;
				Downloads = true;
				FormData = true;
				History = false;
				Sessions = false;
				SiteSettings = false;
				OfflineApps = true;
				Locked = true;
			};
			SearchEngines = {
				PreventInstalls = true;
				Add = [
					{
						Name = "SearXNG";
						URLTemplate = "http://searx3aolosaf3urwnhpynlhuokqsgz47si4pzz5hvb7uuzyjncl2tid.onion/search?q={searchTerms}";
						Method = "GET"; # GET | POST
						IconURL = "http://searx3aolosaf3urwnhpynlhuokqsgz47si4pzz5hvb7uuzyjncl2tid.onion/favicon.ico";
						# Alias = example;
						Description = "SearX instance ran by tiekoetter.com as onion-service";
						#PostData = name=value&q={searchTerms};
						#SuggestURLTemplate = https =//www.example.org/suggestions/q={searchTerms}
					}
				];
				Remove = [
					"Amazon.com" # Fuck you
					"Bing" # Fuck you
					"Google" # FUCK YOUU
				];
				Default = "SearXNG";
			};
			SearchSuggestEnabled = false;
			ShowHomeButton = true;
			# FIXME-SECURITY(Krey): Decide what to do with this
			# SSLVersionMax = tls1 | tls1.1 | tls1.2 | tls1.3;
			# SSLVersionMin = tls1 | tls1.1 | tls1.2 | tls1.3;
			# SupportMenu = {
			# 	Title = Support Menu;
			# 	URL = http =//example.com/support;
			# 	AccessKey = S
			# };
			StartDownloadsInTempDirectory = true; # For speed? May fuck up the system on low ram
			UserMessaging = {
				ExtensionRecommendations = false; # Don’t recommend extensions while the user is visiting web pages
				FeatureRecommendations = false; # Don’t recommend browser features
				Locked = true; # Prevent the user from changing user messaging preferences
				MoreFromMozilla = false; # Don’t show the “More from Mozilla” section in Preferences
				SkipOnboarding = true; # Don’t show onboarding messages on the new tab page
				UrlbarInterventions = false; # Don’t offer suggestions in the URL bar
				WhatsNew = false; # Remove the “What’s New” icon and menuitem
			};
			UseSystemPrintDialog = true;
			# WebsiteFilter = {
			# 	Block = [<all_urls>];
			# 	Exceptions = [http =//example.org/*]
			# };
    };
    profiles = {
      "hayato" = {
        path = "hayato";
        id = 0;
        isDefault = true;
        bookmarks = {};
        extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          bitwarden
          h264ify
        ];
        search = {
          default = "DuckDuckGo";
          order = [ "DuckDuckGo" ];
          privateDefault = "DuckDuckGo";
          force = true;
          engines = {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "NixOS Wiki" = {
              urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];
              iconUpdateURL = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };
          };
        };
        settings = {
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.order.1" = "DuckDuckGo";
          "browser.disableResetPrompt" = true;
          "browser.download.panel.shown" = true;
          "browser.download.useDownloadDir" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.startup.homepage" = "https://start.duckduckgo.com";
          "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
          "dom.security.https_only_mode" = true;
          #"identity.fxaccounts.enabled" = false;
          "privacy.trackingprotection.enabled" = true;
          "signon.rememberSignons" = false;
          "browser.cache.disk.enable" = false;
          "browser.cache.memory.capacity" = 524288;
          "accessibility.force_disabled" = 1;
          "browser.newtabpage.activity-stream.default.sites" = "";
          "toolkit.telemetry.shutdownPingSender.enabledFirstsession" = false;
          "browser.vpn_promo.enabled" = false;
          "geo.provider.ms-windows-location" = false;
          "geo.provider.use_corelocation" = false;
          "geo.provider.use_gpsd" = false;
          "geo.provider.use_geoclue" = false;

          #Integrated calculator at urlbar
          "nglayout.initialpaint.delay" = 0; 
          "nglayout.initialpaint.delay_in_oopif" = 0;
          "content.notify.interval" = 100000; 
          "browser.startup.preXulSkeletonUI" = false;
          "gfx.webrender.all" = true;
          "gfx.webrender.precache-shaders" = true;
          "gfx.webrender.compositor" = true; 
          "layers.gpu-process.enabled" = true; 
          "media.hardware-video-decoding.enabled" = false; 
          "gfx.canvas.accelerated" = true; 
          "gfx.canvas.accelerated.cache-items" = 32768; 
          "gfx.canvas.accelerated.cache-size" = 4096; 
          "gfx.content.skia-font-cache-size" = 80; 
          "image.cache.size" = 10485760; 
          "image.mem.decode_bytes_at_a_time" = 131072; 
          "image.mem.shared.unmap.min_expiration_ms" = 120000; 
          "media.memory_cache_max_size" = 1048576; 
          "media.memory_caches_combined_limit_kb" = 2560000; 
          "media.cache_readahead_limit" = 9000; 
          "media.cache_resume_threshold" = 6000;
          "browser.cache.memory.max_entry_size" = 0;
          "network.buffer.cache.size" = 262144; 
          "network.buffer.cache.count" = 128; 
          "network.http.max-connections" = 1800; 
          "network.http.max-persistent-connections-per-server" = 10; 
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.http.pacing.requests.enabled" = false;
          "network.dnsCacheExpiration" = 3600;
          "network.dns.max_high_priority_threads" = 8;
          "network.ssl_tokens_cache_capacity" = 32768;

          /** SPECULATIVE LOADING ***/
          "network.dns.disablePrefetch" = true;
          "network.prefetch-next" = false;
          "network.predictor.enabled" = false;

          /** DISK CACHE ***/
          "browser.cache.jsbc_compression_level" = 3;

          /** EXPERIMENTAL ***/
          "layout.css.grid-template-masonry-value.enabled" = true;
          "dom.enable_web_task_scheduling" = true;
          "layout.css.has-selector.enabled" = true;
          "dom.security.sanitizer.enabled" = true;


          /****************************************************************************
           * SECTION: PESKYFOX                                                        *
          ****************************************************************************/
          /** MOZILLA UI ***/
          "browser.privatebrowsing.vpnpromourl" = "";
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.preferences.moreFromMozilla" = false;
          "browser.tabs.tabmanager.enabled" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.aboutwelcome.enabled" = false;

          /** THEME ADJUSTMENTS ***/
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.compactmode.show" = true;
          "browser.display.focus_ring_on_anything" = true;
          "browser.display.focus_ring_style" = 0;
          "browser.display.focus_ring_width" = 0;
          "layout.css.prefers-color-scheme.content-override" = 2;
          "browser.privateWindowSeparation.enabled" = false; #WINDOWS

          /** COOKIE BANNER HANDLING ***/
          "cookiebanners.service.mode" = 1;
          "cookiebanners.service.mode.privateBrowsing" = 1;

          /** FULLSCREEN NOTICE ***/
          "full-screen-api.transition-duration.enter" = "0 0";
          "full-screen-api.transition-duration.leave" = "0 0";
          "full-screen-api.warning.delay" = -1;
          "full-screen-api.warning.timeout" = 0;

          /** URL BAR ***/
          "browser.urlbar.suggest.calculator" = true;
          "browser.urlbar.unitConversion.enabled" = true;
          "browser.urlbar.trending.featureGate" = false;

          /** NEW TAB PAGE ***/
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

          /** POCKET ***/
          "extensions.pocket.enabled" = false;

          /** DOWNLOADS ***/
          "browser.download.always_ask_before_handling_new_types" = true;
          "browser.download.manager.addToRecentDocs" = false;

          /** PDF ***/
          "browser.download.open_pdf_attachments_inline" = true;

          /** TAB BEHAVIOR ***/
          "browser.bookmarks.openInTabClosesMenu" = false;
          "browser.menu.showViewImageInfo" = true;
          "findbar.highlightAll" = true;
          "layout.word_select.eat_space_to_next_word" = false;

          /****************************************************************************
           * SECTION: SECUREFOX                                                       *
          ****************************************************************************/
          /** TRACKING PROTECTION ***/
          "browser.contentblocking.category" = "strict";
          "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
          "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
          "network.cookie.sameSite.noneRequiresSecure" = true;
          "browser.download.start_downloads_in_tmp_dir" = true;
          "browser.helperApps.deleteTempFileOnExit" = true;
          "browser.uitour.enabled" = false;
          "privacy.globalprivacycontrol.enabled" = true;

          /** OCSP & CERTS / HPKP ***/
          "security.OCSP.enabled" = 0;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;

          /** SSL / TLS ***/
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "security.tls.enable_0rtt_data" = false;

          /** DISK AVOIDANCE ***/
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "browser.sessionstore.interval" = 60000;

          /** SHUTDOWN & SANITIZING ***/
          "privacy.history.custom" = true;

          /** SEARCH / URL BAR ***/
          "browser.search.separatePrivateDefault.ui.enabled" = true;
          "browser.urlbar.update2.engineAliasRefresh" = true;
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.formfill.enable" = false;
          "security.insecure_connection_text.enabled" = true;
          "security.insecure_connection_text.pbmode.enabled" = true;
          "network.IDN_show_punycode" = true;

          /** HTTPS-FIRST POLICY ***/
          "dom.security.https_first" = true;
          "dom.security.https_first_schemeless" = true;

          /** PASSWORDS ***/
          "signon.formlessCapture.enabled" = false;
          "signon.privateBrowsingCapture.enabled" = false;
          "network.auth.subresource-http-auth-allow" = 1;
          "editor.truncate_user_pastes" = false;

          /** MIXED CONTENT + CROSS-SITE ***/
          "security.mixed_content.block_display_content" = true;
          "security.mixed_content.upgrade_display_content" = true;
          "security.mixed_content.upgrade_display_content.image" = true;
          "pdfjs.enableScripting" = false;
          "extensions.postDownloadThirdPartyPrompt" = false;

          /** HEADERS / REFERERS ***/
          "network.http.referer.XOriginTrimmingPolicy" = 2;

          /** CONTAINERS ***/
          "privacy.userContext.ui.enabled" = true;

          /** WEBRTC ***/
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          "media.peerconnection.ice.default_address_only" = true;

          /** SAFE BROWSING ***/
          "browser.safebrowsing.downloads.remote.enabled" = false;

          /** MOZILLA ***/
          "permissions.default.geo" = 2;
          "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          "permissions.manager.defaultsUrl" = "";
          "webchannel.allowObject.urlWhitelist" = "";

          /** TELEMETRY ***/
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.ping-centre.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;

          /** EXPERIMENTS ***/
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";

          /** CRASH REPORTS ***/
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

          /** DETECTION ***/
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;


          /* OVERRIDES */

          #PREF: allow websites to ask you to receive site notifications
          "permissions.default.desktop-notification" = 0;


          /****************************************************************************************
           * Smoothfox                                                                            *
           * "Faber est suae quisque fortunae"                                                    *
           * priority: better scrolling                                                           *
           * version: January 2023                                                                *
           * url: https://github.com/yokoffing/Betterfox                                          *
           ***************************************************************************************/

          /****************************************************************************************
           * OPTION 1: INSTANT SCROLLING SIMPLE ADJUSTMENT                                      *
          ****************************************************************************************/
          #recommended for 60hz+ displays
          #"general.smoothScroll" = true; #DEFAULT
          #"mousewheel.default.delta_multiplier_y" = 275;  #250-400

          /****************************************************************************************
           * OPTION 2: SMOOTH SCROLLING                                                           *
          ****************************************************************************************/
          #recommended for 90hz+ displays
          #"general.smoothScroll" = true; #DEFAULT
          #"mousewheel.default.delta_multiplier_y" = 300; #250-400
          #"general.smoothScroll.msdPhysics.enabled" = true;

          /****************************************************************************************
           * OPTION 3: NATURAL SMOOTH SCROLLING V3 [MODIFIED]                                     *
          ****************************************************************************************/
          #recommended for 120hz+ displays
          #largely matches Chrome flags: Windows Scrolling Personality and Smooth Scrolling
          #from https://github.com/AveYo/fox/blob/cf56d1194f4e5958169f9cf335cd175daa48d349/Natural%20Smooth%20Scrolling%20for%20user.js
          "general.smoothScroll" = true; #DEFAULT
          "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
          "general.smoothScroll.msdPhysics.enabled" = true;
          "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
          "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 2.0;
          "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
          "general.smoothScroll.currentVelocityWeighting" = 1.0;
          "general.smoothScroll.stopDecelerationWeighting" = 1.0;
          "mousewheel.default.delta_multiplier_y" = 300; #250-400

          "dom.ipc.processCount" = 4; #DEFAULT; Shared Web Content
          "dom.ipc.processCount.webIsolated" = 2; #per-site; DEFAULT; Isolated Web Content

          "content.interrupt.parsing" = true; #[HIDDEN]
          "content.switch.threshold" = 1000000; #alt=1500000; default=750000; [HIDDEN]

          "layout.css.animation-composition.enabled" = true;
        };

        userChrome = ''
          /*
           * penguinFox
           * by p3nguin-kun
           */

          /* config */

          * {
              --animation-speed: 0.2s;
              --button-corner-rounding: 30px;
              --urlbar-container-height: 40px !important;
              --urlbar-min-height: 30px !important;
              --urlbar-height: 30px !important;
              --urlbar-toolbar-height: 38px !important;
              --moz-hidden-unscrollable: scroll !important;
              --toolbarbutton-border-radius: 3px !important;
              --tabs-border-color: transparent;
          }

          :root {
              --window: -moz-Dialog !important;
              --secondary: color-mix(in srgb, currentColor 5%, -moz-Dialog) !important;
              --uc-border-radius: 0px;
              --uc-status-panel-spacing: 0px;
              --uc-page-action-margin: 7px;
          }

          /* animation and effect */
          #nav-bar:not([customizing]) {
              visibility: visible;
              margin-top: -40px;
              transition-delay: 0.1s;
              filter: alpha(opacity=0);
              opacity: 0;
              transition: visibility, ease 0.1s, margin-top, ease 0.1s, opacity, ease 0.1s,
              rotate, ease 0.1s !important;
          }

          #nav-bar:hover,
          #nav-bar:focus-within,
          #urlbar[focused='true'],
          #identity-box[open='true'],
          #titlebar:hover + #nav-bar:not([customizing]),
          #toolbar-menubar:not([inactive='true']) ~ #nav-bar:not([customizing]) {
              visibility: visible;

              margin-top: 0px;
              filter: alpha(opacity=100);
              opacity: 100;
              margin-bottom: -0.2px;
          }
          #PersonalToolbar {
              margin-top: 0px;
          }
          #nav-bar .toolbarbutton-1[open='true'] {
              visibility: visible;
              opacity: 100;
          }

          :root:not([customizing]) :hover > .tabbrowser-tab:not(:hover) {
              transition: blur, ease 0.1s !important;
          }

          :root:not([customizing]) :not(:hover) > .tabbrowser-tab {
              transition: blur, ease 0.1s !important;
          }

          #tabbrowser-tabs .tab-label-container[customizing] {
              color: transparent;
              transition: ease 0.1s;
              transition-delay: 0.2s;
          }

          .tabbrowser-tab:not([pinned]) .tab-icon-image ,.bookmark-item .toolbarbutton-icon{opacity: 0!important; transition: .15s !important; width: 0!important; padding-left: 16px!important}
          .tabbrowser-tab:not([pinned]):hover .tab-icon-image,.bookmark-item:hover .toolbarbutton-icon{opacity: 100!important; transition: .15s !important; display: inline-block!important; width: 16px!important; padding-left: 0!important}
          .tabbrowser-tab:not([hover]) .tab-icon-image,.bookmark-item:not([hover]) .toolbarbutton-icon{padding-left: 0!important}

          /*  Removes annoying buttons and spaces */
          .titlebar-spacer[type="pre-tabs"], .titlebar-spacer[type="post-tabs"]{display: none !important}
          #tabbrowser-tabs{border-inline-start-width: 0!important}

          /*  Makes some buttons nicer  */
          #PanelUI-menu-button, #unified-extensions-button, #reload-button, #stop-button {padding: 2px !important}
          #reload-button, #stop-button{margin: 1px !important;}

          /* X-button */
          :root {
              --show-tab-close-button: none;
              --show-tab-close-button-hover: -moz-inline-block;
          }
          .tabbrowser-tab:not([pinned]) .tab-close-button { display: var(--show-tab-close-button) !important; }
          .tabbrowser-tab:not([pinned]):hover .tab-close-button { display: var(--show-tab-close-button-hover) !important }

          /* tabbar */

          /* Hide the secondary Tab Label
           * e.g. playing indicator (the text, not the icon) */
          .tab-secondary-label { display: none !important; }

          :root {
              --toolbarbutton-border-radius: 0 !important;
              --tab-border-radius: 0 !important;
              --tab-block-margin: 0 !important;
          }

          .tabbrowser-tab:is([visuallyselected='true'], [multiselected])
          > .tab-stack
          > .tab-background {
              box-shadow: none !important;
          }

          .tab-background {
              border-right: 0px solid rgba(0, 0, 0, 0) !important;
              margin-left: -1px !important;
          }

          .tabbrowser-tab[last-visible-tab='true'] {
              padding-inline-end: 0 !important;
          }

          #tabs-newtab-button {
              padding-left: 0 !important;
          }

          /* multi tab selection */
          #tabbrowser-tabs:not([noshadowfortests]) .tabbrowser-tab:is([multiselected])
          > .tab-stack
          > .tab-background:-moz-lwtheme { outline-color: var(--toolbarseparator-color) !important; }

          /* remove gap after pinned tabs */
          #tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs])
          > #tabbrowser-arrowscrollbox
          > .tabbrowser-tab:nth-child(1 of :not([pinned], [hidden])) { margin-inline-start: 0 !important; }

          /*  Removes annoying border  */
          #navigator-toolbox{border:none !important;}

          /*  Removes the annoying rainbow thing from the hamburger  */
          #appMenu-fxa-separator{border-image:none !important;}
        '';

        userContent = ''
          @-moz-document url-prefix(about:){

          /*  Removes the scrollbar on some places  */
          body,html{overflow-y: auto}

          /*  Devtools  */
          @-moz-document url-prefix(about:devtools){
          #toolbox-container{margin-top: 10px !important}
          .devtools-tabbar{background: transparent !important}
          .devtools-tab-line{border-radius: 0 0 5px 5px}
          .customize-animate-enter-done,.customize-menu,.top-site-outer:hover,button{background-color: transparent!important}}

          /*  Newtab  */
          @-moz-document url("about:home"), url("about:newtab"){
          .search-wrapper .search-handoff-button .fake-caret {top: 13px !important; inset-inline-start: 48px !important}
          .search-wrapper .logo-and-wordmark{opacity: 0.9 !important; order: 1 !important; margin-bottom: 0 !important; flex: 1 !important; flex-basis: 20% !important}
          .search-wrapper .search-handoff-button .fake-caret{top: 13px !important; inset-inline-start: 48px !important}
          .search-wrapper .logo-and-wordmark{opacity: 0.9 !important; order: 1 !important; margin-bottom: 0 !important; flex: 1 !important; flex-basis: 20% !important}
          .outer-wrapper .search-wrapper{padding: 0px !important; display: flex !important; flex-direction: row !important; flex-wrap: wrap !important; justify-content: center !important; align-items: center !important; align-content: space-around !important; gap: 20px 10px !important}
          .search-wrapper .logo-and-wordmark .logo{background-size: 60px !important; height: 60px !important; width: 60px !important}
          .search-wrapper .search-inner-wrapper{min-height: 42px !important; order: 2 !important; flex: 3 !important; flex-basis: 60% !important; top: 4px !important}
          .search-wrapper .search-inner-wrapper{min-height: 42px !important; order: 2 !important; flex: 3 !important; flex-basis: 60% !important; top: 4px !important}
          .outer-wrapper.ds-outer-wrapper-breakpoint-override.only-search.visible-logo{display: flex !important; padding-top: 0px !important;vertical-align: middle}
          .customize-menu{border-radius: 10px 0 0 10px !important}
          #root > div{align-items: center; display: flex}}}

        '';
      };
    };
  };
}
