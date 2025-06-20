import { bind, Variable } from 'astal';
import { App, Astal, Gtk } from 'astal/gtk3';
import { RoundCorner } from '../../utils/cairo';
import AstalMpris from 'gi://AstalMpris?version=0.1';
import { MediaPlayer } from './mediaPlayer';

const mpris = AstalMpris.get_default();

function NotchHome({ visible }: { visible: Variable<boolean> }) {
    return (
      <revealer
        revealChild={visible()}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transitionDuration={700}
      >
        <box className={'dynamic-notch-inner'}>
          <box
            className={"dynamic-notch-apps-media"}
            child={bind(mpris, "players").as(arr =>
              arr[0] ? <MediaPlayer player={arr[0]} progressBar={true}/> : <box/>
            )}
          />
        </box>
      </revealer>
    )
}

export default function Notch(monitor: number): JSX.Element {
  const visible = Variable(false);
  const home = <NotchHome visible={visible} />
  const base = <box className={'dynamic-notch'} child={home}/>
  return (
    <window
      className={'Notch'}
      name={'Notch'}
      monitor={monitor}
      anchor={Astal.WindowAnchor.TOP}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      application={App}
      namespace={'Notch'}
    >
      <eventbox
        className={'dynamic-notch-container'}
        onClick={() => {
            visible.set(!visible.get());
        }}
      >
        <centerbox>
          <RoundCorner anchor='topleft' className='dynamic-notch-roundcorner-left' sizeX={30} sizeY={30}/>
          {base}
          <RoundCorner anchor='topright' className='dynamic-notch-roundcorner-right' sizeX={30} sizeY={30}/>
        </centerbox>
      </eventbox>
    </window>
  );
}

