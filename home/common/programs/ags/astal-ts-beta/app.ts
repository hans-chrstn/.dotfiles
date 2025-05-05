import { App } from 'astal/gtk3';
import style from './style.scss';
import Background from './src/components/background';
import { monitorStyles, reloadCss } from './src/utils/styles';
import { forMonitors } from './src/utils/monitors';
import Settings from './src/components/settings';
import Notch from './src/components/notch';
import Lockscreen from './src/components/lock';
import { programArgs } from 'system';
import mishima from './configurations/mishima';

switch (programArgs[0]) {
    case 'mishima': mishima(); break;
}
