const require = async (file) => {
  return (await Service.import(file));
};
export const Applications = await require('applications');
export const Audio = await require('audio');
export const Mpris = await require('mpris');
export const Greetd = await require('greetd')
export const Battery = await require('battery');
export const Network = await require('network');
export const Hyprland = await require('hyprland');
export const Bluetooth = await require('bluetooth');
export const SystemTray = await require('systemtray');
export const PowerProfiles = await require('powerprofiles');
export const Notifications = await require('notifications');
