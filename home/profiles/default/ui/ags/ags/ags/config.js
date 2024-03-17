import { Bar } from "./bar.js"
import { applauncher } from './launcher.js';

App.config({
    style: './style.css',
    windows: [
       Bar(1), 
       Bar(0),
       applauncher,
  ],
})
