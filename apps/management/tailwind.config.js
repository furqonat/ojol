const { createGlobPatternsForDependencies } = require('@nx/react/tailwind')
const { join } = require('path')

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    join(
      __dirname,
      '{components,app,prebuilt}/**/*!(*.stories|*.spec).{ts,tsx,html}',
    ),
    ...createGlobPatternsForDependencies(__dirname),
  ],
  theme: {},
  daisyui: {
    themes: ['lofi', 'wireframe'],
  },
  plugins: [require('daisyui'), require('@tailwindcss/typography')],
}
