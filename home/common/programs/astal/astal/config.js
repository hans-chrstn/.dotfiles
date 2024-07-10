const main = '/tmp/astal/main.js';
const entry = `${App.configDir}/main.ts`;

try {
  await Utils.execAsync([
    'bun',
    'build',
    entry,
    '--outfile',
    main,
    '--external',
    'resource://*',
    '--external',
    'gi://*',
    '--external',
    'file://*',
  ]);

  await Utils.execAsync(`sassc ${App.configDir}/scss/main.scss ${App.configDir}/style.css`);
  await import(`file://${main}`);
} catch (error) {
  console.error(error);
  App.quit();
}

export {};
