user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.memory.capacity", 524288);
/* user_pref("browser.sessionstore.interval", 15000000); */
user_pref("accessibility.force_disabled", 1);

/*** STARTUP ***/

/* set startup page
 * 0=blank, 1=home, 2=last visited page, 3=resume previous session*/
//user_pref("browser.startup.page", 1);
/* set HOME+NEWWINDOW page
 * about:home=Firefox Home, custom URL, about:blank*/
//user_pref("browser.startup.homepage", "about:home");
/* disable sponsored content on Firefox Home (Activity Stream)
 * [SETTING] Home>Firefox Home Content ***/
user_pref("browser.newtabpage.activity-stream.showSponsored", false); // [FF58+] Pocket > Sponsored Stories
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false); // [FF83+] Sponsored shortcuts
/* clear default topsites
 * [NOTE] This does not block you from adding your own ***/
user_pref("browser.newtabpage.activity-stream.default.sites", "");


/* disable Telemetry Coverage */
/* disable PingCentre telemetry (used in several System Add-ons) [FF57+] */
/* disable Firefox Home (Activity Stream) telemetry ***/
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabledFirstsession", false);
user_pref("browser.vpn_promo.enabled", false);



/*** [GEOLOCATION / LANGUAGE / LOCALE ***/

/* use Mozilla geolocation service instead of Google.*/
/* disable using the OS's geolocation service ***/
user_pref("geo.provider.ms-windows-location", false); // [WINDOWS]
user_pref("geo.provider.use_corelocation", false); // [MAC]
user_pref("geo.provider.use_gpsd", false); // [LINUX]
user_pref("geo.provider.use_geoclue", false); // [FF102+] [LINUX]

// Integrated calculator at urlbar
user_pref("nglayout.initialpaint.delay", 0); 
user_pref("nglayout.initialpaint.delay_in_oopif", 0);
user_pref("content.notify.interval", 100000); 
user_pref("browser.startup.preXulSkeletonUI", false);
user_pref("gfx.webrender.all", true); 
user_pref("gfx.webrender.precache-shaders", true); 
user_pref("gfx.webrender.compositor", true); 
user_pref("layers.gpu-process.enabled", true); 
user_pref("media.hardware-video-decoding.enabled", true); 
user_pref("gfx.canvas.accelerated", true); 
user_pref("gfx.canvas.accelerated.cache-items", 32768); 
user_pref("gfx.canvas.accelerated.cache-size", 4096); 
user_pref("gfx.content.skia-font-cache-size", 80); 
user_pref("image.cache.size", 10485760); 
user_pref("image.mem.decode_bytes_at_a_time", 131072); 
user_pref("image.mem.shared.unmap.min_expiration_ms", 120000); 
user_pref("media.memory_cache_max_size", 1048576); 
user_pref("media.memory_caches_combined_limit_kb", 2560000); 
user_pref("media.cache_readahead_limit", 9000); 
user_pref("media.cache_resume_threshold", 6000);
user_pref("browser.cache.memory.max_entry_size", 0);
user_pref("network.buffer.cache.size", 262144); 
user_pref("network.buffer.cache.count", 128); 
user_pref("network.http.max-connections", 1800); 
user_pref("network.http.max-persistent-connections-per-server", 10); 
user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
user_pref("network.http.pacing.requests.enabled", false);
user_pref("network.dnsCacheExpiration", 3600);
user_pref("network.dns.max_high_priority_threads", 8);
user_pref("network.ssl_tokens_cache_capacity", 32768);

/** SPECULATIVE LOADING ***/
user_pref("network.dns.disablePrefetch", true);
user_pref("network.prefetch-next", false);
user_pref("network.predictor.enabled", false);

/** DISK CACHE ***/
user_pref("browser.cache.jsbc_compression_level", 3);

/** EXPERIMENTAL ***/
user_pref("layout.css.grid-template-masonry-value.enabled", true);
user_pref("dom.enable_web_task_scheduling", true);
user_pref("layout.css.has-selector.enabled", true);
user_pref("dom.security.sanitizer.enabled", true);


/****************************************************************************
 * SECTION: PESKYFOX                                                        *
****************************************************************************/
/** MOZILLA UI ***/
user_pref("browser.privatebrowsing.vpnpromourl", "");
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.preferences.moreFromMozilla", false);
user_pref("browser.tabs.tabmanager.enabled", false);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.aboutwelcome.enabled", false);

/** THEME ADJUSTMENTS ***/
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.compactmode.show", true);
user_pref("browser.display.focus_ring_on_anything", true);
user_pref("browser.display.focus_ring_style", 0);
user_pref("browser.display.focus_ring_width", 0);
user_pref("layout.css.prefers-color-scheme.content-override", 2);
user_pref("browser.privateWindowSeparation.enabled", false); // WINDOWS

/** COOKIE BANNER HANDLING ***/
user_pref("cookiebanners.service.mode", 1);
user_pref("cookiebanners.service.mode.privateBrowsing", 1);

/** FULLSCREEN NOTICE ***/
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.warning.delay", -1);
user_pref("full-screen-api.warning.timeout", 0);

/** URL BAR ***/
user_pref("browser.urlbar.suggest.calculator", true);
user_pref("browser.urlbar.unitConversion.enabled", true);
user_pref("browser.urlbar.trending.featureGate", false);

/** NEW TAB PAGE ***/
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

/** POCKET ***/
user_pref("extensions.pocket.enabled", false);

/** DOWNLOADS ***/
user_pref("browser.download.always_ask_before_handling_new_types", true);
user_pref("browser.download.manager.addToRecentDocs", false);

/** PDF ***/
user_pref("browser.download.open_pdf_attachments_inline", true);

/** TAB BEHAVIOR ***/
user_pref("browser.bookmarks.openInTabClosesMenu", false);
user_pref("browser.menu.showViewImageInfo", true);
user_pref("findbar.highlightAll", true);
user_pref("layout.word_select.eat_space_to_next_word", false);

/****************************************************************************
 * SECTION: SECUREFOX                                                       *
****************************************************************************/
/** TRACKING PROTECTION ***/
user_pref("browser.contentblocking.category", "strict");
user_pref("urlclassifier.trackingSkipURLs", "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com");
user_pref("urlclassifier.features.socialtracking.skipURLs", "*.instagram.com, *.twitter.com, *.twimg.com");
user_pref("network.cookie.sameSite.noneRequiresSecure", true);
user_pref("browser.download.start_downloads_in_tmp_dir", true);
user_pref("browser.helperApps.deleteTempFileOnExit", true);
user_pref("browser.uitour.enabled", false);
user_pref("privacy.globalprivacycontrol.enabled", true);

/** OCSP & CERTS / HPKP ***/
user_pref("security.OCSP.enabled", 0);
user_pref("security.remote_settings.crlite_filters.enabled", true);
user_pref("security.pki.crlite_mode", 2);

/** SSL / TLS ***/
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("browser.xul.error_pages.expert_bad_cert", true);
user_pref("security.tls.enable_0rtt_data", false);

/** DISK AVOIDANCE ***/
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
user_pref("browser.sessionstore.interval", 60000);

/** SHUTDOWN & SANITIZING ***/
user_pref("privacy.history.custom", true);

/** SEARCH / URL BAR ***/
user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
user_pref("browser.urlbar.update2.engineAliasRefresh", true);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.formfill.enable", false);
user_pref("security.insecure_connection_text.enabled", true);
user_pref("security.insecure_connection_text.pbmode.enabled", true);
user_pref("network.IDN_show_punycode", true);

/** HTTPS-FIRST POLICY ***/
user_pref("dom.security.https_first", true);
user_pref("dom.security.https_first_schemeless", true);

/** PASSWORDS ***/
user_pref("signon.formlessCapture.enabled", false);
user_pref("signon.privateBrowsingCapture.enabled", false);
user_pref("network.auth.subresource-http-auth-allow", 1);
user_pref("editor.truncate_user_pastes", false);

/** MIXED CONTENT + CROSS-SITE ***/
user_pref("security.mixed_content.block_display_content", true);
user_pref("security.mixed_content.upgrade_display_content", true);
user_pref("security.mixed_content.upgrade_display_content.image", true);
user_pref("pdfjs.enableScripting", false);
user_pref("extensions.postDownloadThirdPartyPrompt", false);

/** HEADERS / REFERERS ***/
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

/** CONTAINERS ***/
user_pref("privacy.userContext.ui.enabled", true);

/** WEBRTC ***/
user_pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);
user_pref("media.peerconnection.ice.default_address_only", true);

/** SAFE BROWSING ***/
user_pref("browser.safebrowsing.downloads.remote.enabled", false);

/** MOZILLA ***/
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);
user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
user_pref("permissions.manager.defaultsUrl", "");
user_pref("webchannel.allowObject.urlWhitelist", "");

/** TELEMETRY ***/
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("browser.ping-centre.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);

/** EXPERIMENTS ***/
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

/** CRASH REPORTS ***/
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);

/** DETECTION ***/
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false);
user_pref("network.connectivity-service.enabled", false);


/* OVERRIDES */

// PREF: allow websites to ask you to receive site notifications
user_pref("permissions.default.desktop-notification", 0);


/****************************************************************************************
 * Smoothfox                                                                            *
 * "Faber est suae quisque fortunae"                                                    *
 * priority: better scrolling                                                           *
 * version: January 2023                                                                *
 * url: https://github.com/yokoffing/Betterfox                                          *
 ***************************************************************************************/

/****************************************************************************************
 * OPTION 1: INSTANT SCROLLING (SIMPLE ADJUSTMENT)                                      *
****************************************************************************************/
// recommended for 60hz+ displays
user_pref("general.smoothScroll",                       true); // DEFAULT
user_pref("mousewheel.default.delta_multiplier_y",      275);  // 250-400

/****************************************************************************************
 * OPTION 2: SMOOTH SCROLLING                                                           *
****************************************************************************************/
// recommended for 90hz+ displays
user_pref("general.smoothScroll",                       true); // DEFAULT
user_pref("mousewheel.default.delta_multiplier_y",      300); // 250-400
user_pref("general.smoothScroll.msdPhysics.enabled",    true);

/****************************************************************************************
 * OPTION 3: NATURAL SMOOTH SCROLLING V3 [MODIFIED]                                     *
****************************************************************************************/
// recommended for 120hz+ displays
// largely matches Chrome flags: Windows Scrolling Personality and Smooth Scrolling
// from https://github.com/AveYo/fox/blob/cf56d1194f4e5958169f9cf335cd175daa48d349/Natural%20Smooth%20Scrolling%20for%20user.js
user_pref("general.smoothScroll",                                       true); // DEFAULT
user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 12);
user_pref("general.smoothScroll.msdPhysics.enabled",                    true);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant",  600);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant",      650);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS",         25);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio",      2.0);
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant",     250);
user_pref("general.smoothScroll.currentVelocityWeighting",              1.0);
user_pref("general.smoothScroll.stopDecelerationWeighting",             1.0);
user_pref("mousewheel.default.delta_multiplier_y",                      300); // 250-400

user_pref("dom.ipc.processCount", 4); // DEFAULT; Shared Web Content
user_pref("dom.ipc.processCount.webIsolated", 2); // per-site; DEFAULT; Isolated Web Content

user_pref("content.interrupt.parsing", true); // [HIDDEN]
user_pref("content.switch.threshold", 1000000); // alt=1500000; default=750000; [HIDDEN]

user_pref("browser.startup.preXulSkeletonUI", false);

user_pref("layout.css.animation-composition.enabled", true);


