{lib}: let
  boolToInt = b:
    toString (
      if b
      then 1
      else 0
    );
  formatLine = key: value: "${key}=${toString value}";
  formatColor = color: lib.removePrefix "0x" color;
in {
  inherit boolToInt formatLine formatColor;

  formatMouseBinds = binds:
    lib.optionalString (binds != []) (
      lib.concatStringsSep "\n" (
        map (
          bind: "mousebind=${
            lib.concatStringsSep "," (
              [
                (lib.concatStringsSep "+" bind.mods)
                bind.button
                bind.command
              ]
              ++ (lib.optional (bind.params != null) bind.params)
            )
          }"
        )
        binds
      )
    );

  formatAxisBinds = binds:
    lib.optionalString (binds != []) (
      lib.concatStringsSep "\n" (
        map (
          bind: "axisbind=${
            lib.concatStringsSep "," (
              [
                (lib.concatStringsSep "+" bind.mods)
                bind.direction
                bind.command
              ]
              ++ (lib.optional (bind.params != null) bind.params)
            )
          }"
        )
        binds
      )
    );

  formatSwitchBinds = binds:
    lib.optionalString (binds != []) (
      lib.concatStringsSep "\n" (
        map (
          bind: "switchbind=${
            lib.concatStringsSep "," [
              bind.foldState
              ""
              bind.command
              (
                if bind.params != null
                then bind.params
                else ""
              )
            ]
          }"
        )
        binds
      )
    );

  formatGestureBinds = binds:
    lib.optionalString (binds != []) (
      lib.concatStringsSep "\n" (
        map (
          bind: "gesturebind=${
            lib.concatStringsSep "," (
              [
                (lib.concatStringsSep "+" bind.mods)
                bind.direction
                (toString bind.fingers)
                bind.command
              ]
              ++ (lib.optional (bind.params != null) bind.params)
            )
          }"
        )
        binds
      )
    );

  formatLayerRules = rules:
    lib.optionalString (rules != []) (
      lib.concatStringsSep "\n" (
        map (
          rule: "layerrule=${
            lib.concatStringsSep "," (lib.mapAttrsToList (name: value: "${name}:${toString value}") rule)
          }"
        )
        rules
      )
    );

  formatMonitors = monitors:
    lib.optionalString (monitors != {}) (
      lib.concatStringsSep "\n" (
        lib.mapAttrsToList (
          name: monitor: "monitorrule=${
            lib.concatStringsSep "," [
              monitor.name
              (toString 0.55)
              (toString 1)
              "tile"
              (toString (
                if monitor.transform == 90
                then 1
                else if monitor.transform == 180
                then 2
                else if monitor.transform == 270
                then 3
                else 0
              ))
              (toString monitor.scale)
              (toString monitor.position.x)
              (toString monitor.position.y)
              (toString monitor.width)
              (toString monitor.height)
              (toString monitor.refreshRate)
            ]
          }"
        )
        monitors
      )
    );

  formatBinds = binds:
    lib.optionalString (binds != []) (
      lib.concatStringsSep "\n" (
        map (
          bind: "bind=${
            lib.concatStringsSep "," (
              [
                (lib.concatStringsSep "+" bind.mods)
                bind.key
                bind.command
              ]
              ++ (lib.optional (bind.params != null) bind.params)
            )
          }"
        )
        binds
      )
    );

  formatTagRules = rules:
    lib.optionalString (rules != []) (
      lib.concatStringsSep "\n" (
        map (
          rule: "tagrule=${
            lib.concatStringsSep "," (lib.mapAttrsToList (name: value: "${name}:${toString value}") rule)
          }"
        )
        rules
      )
    );

  formatWindowRules = rules:
    lib.optionalString (rules != []) (
      lib.concatStringsSep "\n" (
        map (
          rule: "windowrule=${
            lib.concatStringsSep "," (lib.mapAttrsToList (name: value: "${name}:${toString value}") rule)
          }"
        )
        rules
      )
    );

  formatEnvs = envs:
    lib.optionalString (envs != {}) (
      lib.concatStringsSep "\n" (lib.mapAttrsToList (name: value: "env=${name},${value}") envs)
    );

  generateEffectsConfig = effects: ''
    blur=${boolToInt effects.blur}
    blur_layer=${boolToInt effects.blurLayer}
    blur_optimized=${boolToInt effects.blurOptimized}
    blur_params_num_passes=${toString effects.blurPasses}
    blur_params_radius=${toString effects.blurRadius}
    blur_params_noise=${toString effects.blurNoise}
    blur_params_brightness=${toString effects.blurBrightness}
    blur_params_contrast=${toString effects.blurContrast}
    blur_params_saturation=${toString effects.blurSaturation}

    shadows=${boolToInt effects.shadows}
    layer_shadows=${boolToInt effects.layerShadows}
    shadow_only_floating=${boolToInt effects.shadowOnlyFloating}
    shadows_size=${toString effects.shadowsSize}
    shadows_blur=${toString effects.shadowsBlur}
    shadows_position_x=${toString effects.shadowsPositionX}
    shadows_position_y=${toString effects.shadowsPositionY}
    shadowscolor=0x${formatColor effects.shadowsColor}

    border_radius=${toString effects.borderRadius}
    no_radius_when_single=${boolToInt effects.noRadiusWhenSingle}
    focused_opacity=${toString effects.focusedOpacity}
    unfocused_opacity=${toString effects.unfocusedOpacity}
  '';

  generateAnimationsConfig = animations: ''
    animations=${boolToInt animations.enable}
    layer_animations=${boolToInt animations.layerAnimations}
    layer_animation_type_open=${animations.layerAnimationTypeOpen}
    layer_animation_type_close=${animations.layerAnimationTypeClose}
    animation_type_open=${animations.openType}
    animation_type_close=${animations.closeType}
    animation_fade_in=${boolToInt animations.fadeIn}
    animation_fade_out=${boolToInt animations.fadeOut}
    tag_animation_direction=${
      if animations.tagDirection == "vertical"
      then "1"
      else "0"
    }
    zoom_initial_ratio=${toString animations.zoomInitialRatio}
    zoom_end_ratio=${toString animations.zoomEndRatio}
    fadein_begin_opacity=${toString animations.fadeinBeginOpacity}
    fadeout_begin_opacity=${toString animations.fadeoutBeginOpacity}
    animation_duration_move=${toString animations.duration.move}
    animation_duration_open=${toString animations.duration.open}
    animation_duration_tag=${toString animations.duration.tag}
    animation_duration_close=${toString animations.duration.close}
    animation_curve_open=${animations.curve.open}
    animation_curve_move=${animations.curve.move}
    animation_curve_tag=${animations.curve.tag}
    animation_curve_close=${animations.curve.close}
  '';

  generateScrollerConfig = scroller: ''
    scroller_structs=${toString scroller.structs}
    scroller_default_proportion=${toString scroller.defaultProportion}
    scroller_focus_center=${boolToInt scroller.focusCenter}
    scroller_prefer_center=${boolToInt scroller.preferCenter}
    edge_scroller_pointer_focus=${boolToInt scroller.edgeScrollerPointerFocus}
    scroller_default_proportion_single=${toString scroller.defaultProportionSingle}
    scroller_proportion_preset=${lib.concatStringsSep "," (map toString scroller.proportionPreset)}
  '';

  generateMasterStackConfig = masterStack: ''
    new_is_master=${boolToInt masterStack.newIsMaster}
    default_mfact=${toString masterStack.defaultMfact}
    default_nmaster=${toString masterStack.defaultNmaster}
    smartgaps=${boolToInt masterStack.smartGaps}
    center_master_overspread=${boolToInt masterStack.centerMasterOverspread}
    center_when_single_stack=${boolToInt masterStack.centerWhenSingleStack}
  '';

  generateOverviewConfig = overview: ''
    hotarea_size=${toString overview.hotAreaSize}
    enable_hotarea=${boolToInt overview.enableHotArea}
    ov_tab_mode=${boolToInt overview.tabMode}
    overviewgappi=${toString overview.innerGap}
    overviewgappo=${toString overview.outerGap}
  '';

  generateMiscConfig = misc: cursorSize: ''
    no_border_when_single=${boolToInt misc.noBorderWhenSingle}
    axis_bind_apply_timeout=${toString misc.axisBindApplyTimeout}
    focus_on_activate=${boolToInt misc.focusOnActivate}
    inhibit_regardless_of_visibility=${boolToInt misc.inhibitRegardlessOfVisibility}
    sloppyfocus=${boolToInt misc.sloppyFocus}
    warpcursor=${boolToInt misc.warpCursor}
    focus_cross_monitor=${boolToInt misc.focusCrossMonitor}
    focus_cross_tag=${boolToInt misc.focusCrossTag}
    enable_floating_snap=${boolToInt misc.enableFloatingSnap}
    snap_distance=${toString misc.snapDistance}
    cursor_size=${toString cursorSize}
    drag_tile_to_tile=${boolToInt misc.dragTileToTile}
    xwayland_persistence=${boolToInt misc.xwaylandPersistence}
    syncobj_enable=${boolToInt misc.syncobjEnable}
    adaptive_sync=${boolToInt misc.adaptiveSync}
    exchange_cross_monitor=${boolToInt misc.exchangeCrossMonitor}
    scratchpad_cross_monitor=${boolToInt misc.scratchpadCrossMonitor}
    view_current_to_back=${boolToInt misc.viewCurrentToBack}
    cursor_hide_timeout=${toString misc.cursorHideTimeout}
    single_scratchpad=${boolToInt misc.singleScratchpad}
  '';

  generateKeyboardConfig = keyboard: ''
    repeat_rate=${toString keyboard.repeatRate}
    repeat_delay=${toString keyboard.repeatDelay}
    numlockon=${boolToInt keyboard.numlockOn}
    xkb_rules_layout=${keyboard.layout}${
      lib.optionalString (keyboard.rules != null) "\n${formatLine "xkb_rules_rules" keyboard.rules}"
    }${lib.optionalString (keyboard.model != null) "\n${formatLine "xkb_rules_model" keyboard.model}"}${
      lib.optionalString (keyboard.variant != null) "\n${formatLine "xkb_rules_variant" keyboard.variant}"
    }${
      lib.optionalString (keyboard.options != null) "\n${formatLine "xkb_rules_options" keyboard.options}"
    }
  '';

  generateTrackpadConfig = trackpad: ''
    disable_trackpad=${boolToInt trackpad.disable}
    tap_to_click=${boolToInt trackpad.tapToClick}
    tap_and_drag=${boolToInt trackpad.tapAndDrag}
    drag_lock=${boolToInt trackpad.dragLock}
    trackpad_natural_scrolling=${boolToInt trackpad.naturalScrolling}
    disable_while_typing=${boolToInt trackpad.disableWhileTyping}
    left_handed=${boolToInt trackpad.leftHanded}
    middle_button_emulation=${boolToInt trackpad.middleButtonEmulation}
    swipe_min_threshold=${toString trackpad.swipeMinThreshold}
    accel_profile=${toString trackpad.accelProfile}
    accel_speed=${toString trackpad.accelSpeed}
    scroll_method=${toString trackpad.scrollMethod}
    click_method=${toString trackpad.clickMethod}
    send_events_mode=${toString trackpad.sendEventsMode}
    button_map=${toString trackpad.buttonMap}
  '';

  generateMouseConfig = mouse: cursorTheme: ''
    mouse_natural_scrolling=${boolToInt mouse.naturalScrolling}
    ${lib.optionalString (cursorTheme != null) (formatLine "cursor_theme" cursorTheme)}
  '';

  generateAppearanceConfig = appearance: ''
    gappih=${toString appearance.gaps.innerHorizontal}
    gappiv=${toString appearance.gaps.innerVertical}
    gappoh=${toString appearance.gaps.outerHorizontal}
    gappov=${toString appearance.gaps.outerVertical}
    scratchpad_width_ratio=${toString appearance.scratchpad.widthRatio}
    scratchpad_height_ratio=${toString appearance.scratchpad.heightRatio}
    borderpx=${toString appearance.borderpx}
    ${lib.optionalString (
      appearance.colors.root != null
    ) "rootcolor=0x${formatColor appearance.colors.root}"}
    ${lib.optionalString (
      appearance.colors.border != null
    ) "bordercolor=0x${formatColor appearance.colors.border}"}
    ${lib.optionalString (
      appearance.colors.focus != null
    ) "focuscolor=0x${formatColor appearance.colors.focus}"}
    ${lib.optionalString (
      appearance.colors.maximizescreen != null
    ) "maximizescreencolor=0x${formatColor appearance.colors.maximizescreen}"}
    ${lib.optionalString (
      appearance.colors.urgent != null
    ) "urgentcolor=0x${formatColor appearance.colors.urgent}"}
    ${lib.optionalString (
      appearance.colors.scratchpad != null
    ) "scratchpadcolor=0x${formatColor appearance.colors.scratchpad}"}
    ${lib.optionalString (
      appearance.colors.global != null
    ) "globalcolor=0x${formatColor appearance.colors.global}"}
    ${lib.optionalString (
      appearance.colors.overlay != null
    ) "overlaycolor=0x${formatColor appearance.colors.overlay}"}
  '';
}
