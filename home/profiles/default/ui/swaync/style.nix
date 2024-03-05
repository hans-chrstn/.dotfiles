{ config, pkgs, ... }:

{
  home.file."/.config/swaync/style.css".text = ''
* {
  all: unset;
  font-size: 14px;
  font-family: "Ubuntu Nerd Font";
  transition: 200ms;
}

.floating-notifications.background .notification-row .notification-background {
  box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #414559;
  border-radius: 12.6px;
  margin: 18px;
  background-color: #303446;
  color: #c6d0f5;
  padding: 0;
}

.floating-notifications.background .notification-row .notification-background .notification {
  padding: 7px;
  border-radius: 12.6px;
}

.floating-notifications.background .notification-row .notification-background .notification.critical {
  box-shadow: inset 0 0 7px 0 #e78284;
}

.floating-notifications.background .notification-row .notification-background .notification .notification-content {
  margin: 7px;
}

.floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
  color: #c6d0f5;
}

.floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
  color: #a5adce;
}

.floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
  color: #c6d0f5;
}

.floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
  min-height: 3.4em;
}

.floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
  border-radius: 7px;
  color: #c6d0f5;
  background-color: #414559;
  box-shadow: inset 0 0 0 1px #51576d;
  margin: 7px;
}

.floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
  box-shadow: inset 0 0 0 1px #51576d;
  background-color: #414559;
  color: #c6d0f5;
}

.floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
  box-shadow: inset 0 0 0 1px #51576d;
  background-color: #85c1dc;
  color: #c6d0f5;
}

.floating-notifications.background .notification-row .notification-background .close-button {
  margin: 7px;
  padding: 2px;
  border-radius: 6.3px;
  color: #303446;
  background-color: #e78284;
}

.floating-notifications.background .notification-row .notification-background .close-button:hover {
  background-color: #ea999c;
  color: #303446;
}

.floating-notifications.background .notification-row .notification-background .close-button:active {
  background-color: #e78284;
  color: #303446;
}

.control-center {
  box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #414559;
  border-radius: 12.6px;
  margin: 18px;
  background-color: #303446;
  color: #c6d0f5;
  padding: 14px;
}

.control-center .widget-title {
  color: #c6d0f5;
  font-size: 1.3em;
}

.control-center .widget-title button {
  border-radius: 7px;
  color: #c6d0f5;
  background-color: #414559;
  box-shadow: inset 0 0 0 1px #51576d;
  padding: 8px;
}

.control-center .widget-title button:hover {
  box-shadow: inset 0 0 0 1px #51576d;
  background-color: #626880;
  color: #c6d0f5;
}

.control-center .widget-title button:active {
  box-shadow: inset 0 0 0 1px #51576d;
  background-color: #85c1dc;
  color: #303446;
}

.control-center .notification-row .notification-background {
  border-radius: 7px;
  color: #c6d0f5;
  background-color: #414559;
  box-shadow: inset 0 0 0 1px #51576d;
  margin-top: 14px;
}

.control-center .notification-row .notification-background .notification {
  padding: 7px;
  border-radius: 7px;
}

.control-center .notification-row .notification-background .notification.critical {
  box-shadow: inset 0 0 7px 0 #e78284;
}

.control-center .notification-row .notification-background .notification .notification-content {
  margin: 7px;
}

.control-center .notification-row .notification-background .notification .notification-content .summary {
  color: #c6d0f5;
}

.control-center .notification-row .notification-background .notification .notification-content .time {
  color: #a5adce;
}

.control-center .notification-row .notification-background .notification .notification-content .body {
  color: #c6d0f5;
}

.control-center .notification-row .notification-background .notification > *:last-child > * {
  min-height: 3.4em;
}

.control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
  border-radius: 7px;
  color: #c6d0f5;
  background-color: #232634;
  box-shadow: inset 0 0 0 1px #51576d;
  margin: 7px;
}

.control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
  box-shadow: inset 0 0 0 1px #51576d;
  background-color: #414559;
  color: #c6d0f5;
}

.control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
  box-shadow: inset 0 0 0 1px #51576d;
  background-color: #85c1dc;
  color: #c6d0f5;
}

.control-center .notification-row .notification-background .close-button {
  margin: 7px;
  padding: 2px;
  border-radius: 6.3px;
  color: #303446;
  background-color: #ea999c;
}

.control-center .notification-row .notification-background .close-button:hover {
  background-color: #e78284;
  color: #303446;
}

.control-center .notification-row .notification-background .close-button:active {
  background-color: #e78284;
  color: #303446;
}

.control-center .notification-row .notification-background:hover {
  box-shadow: inset 0 0 0 1px #51576d;
  background-color: #838ba7;
  color: #c6d0f5;
}

.control-center .notification-row .notification-background:active {
  box-shadow: inset 0 0 0 1px #51576d;
  background-color: #85c1dc;
  color: #c6d0f5;
}

progressbar,
progress,
trough {
  border-radius: 12.6px;
}

progressbar {
  box-shadow: inset 0 0 0 1px #51576d;
}

.notification.critical progress {
  background-color: #e78284;
}

.notification.low progress,
.notification.normal progress {
  background-color: #8caaee;
}

trough {
  background-color: #414559;
}

.control-center trough {
  background-color: #51576d;
}

.control-center-dnd {
  margin-top: 5px;
  border-radius: 8px;
  background: #414559;
  border: 1px solid #51576d;
  box-shadow: none;
}

.control-center-dnd:checked {
  background: #414559;
}

.control-center-dnd slider {
  background: #51576d;
  border-radius: 8px;
}

.widget-dnd {
  margin: 0px;
  font-size: 1.1rem;
}

.widget-dnd > switch {
  font-size: initial;
  border-radius: 8px;
  background: #414559;
  border: 1px solid #51576d;
  box-shadow: none;
}

.widget-dnd > switch:checked {
  background: #414559;
}

.widget-dnd > switch slider {
  background: #51576d;
  border-radius: 8px;
  border: 1px solid #737994;
}

  '';

}
