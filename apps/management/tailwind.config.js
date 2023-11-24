const { createGlobPatternsForDependencies } = require('@nx/react/tailwind')
const { join } = require('path')

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    join(
      __dirname,
      '{components,app,prebuilt}/**/*!(*.stories|*.spec).{ts,tsx,jsx,js,html}',
    ),
    ...createGlobPatternsForDependencies(__dirname),
  ],
  theme: {
    container: {
      center: true,
    },
  },
  plugins: [require('daisyui'), require('@tailwindcss/typography')],
}
