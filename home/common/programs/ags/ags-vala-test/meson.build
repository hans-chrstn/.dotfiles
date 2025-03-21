project('simple-bar', 'vala', 'c')

bindir = get_option('prefix') / get_option('bindir')
libdir = get_option('prefix') / get_option('libdir')

pkgconfig_deps = [
  dependency('glib-2.0'),
  dependency('gio-2.0'),
  dependency('gio-unix-2.0'),
  dependency('gobject-2.0'),
  dependency('gtk+-3.0'),
  dependency('libnm'),
  dependency('astal-io-0.1'),
  dependency('astal-3.0'),
  dependency('astal-battery-0.1'),
  dependency('astal-wireplumber-0.1'),
  dependency('astal-network-0.1'),
  dependency('astal-tray-0.1'),
  dependency('astal-mpris-0.1'),
  dependency('astal-hyprland-0.1'),
  dependency('astal-auth-0.1'),
  dependency('astal-bluetooth-0.1'),
  dependency('astal-cava-0.1'),
  dependency('astal-greet-0.1'),
  dependency('astal-notifd-0.1'),
  dependency('astal-power-profiles-0.1'),
  dependency('astal-river-0.1'),
  dependency('astal-apps-0.1')
]

# needed for GLib.Math
deps = pkgconfig_deps + meson.get_compiler('c').find_library('m')

custom_target(
  'style.css',
  command: [
    find_program('sass'),
    meson.project_source_root() / 'src/styles/main.scss',  # Using absolute path
    '@OUTPUT@',
  ],
  output: 'style.css',
  install: true,
  install_dir: libdir,
)

main = configure_file(
  input: 'app.in.vala',
  output: 'app.vala',
  configuration: {'STYLE': libdir / 'style.css', 'CONFIG_DIR': libdir},
)

sources = files(
  'src/TimeLabel.vala',
  'src/AppLauncher.vala',
  'src/Background.vala'
)

executable(
  'simple-bar',
  [sources, main],
  dependencies: deps,
  install: true,
  install_dir: bindir,
)
