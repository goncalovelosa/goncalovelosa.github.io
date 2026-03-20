/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        'surface': '#0e0e0e',
        'surface-dim': '#0e0e0e',
        'surface-bright': '#2c2c2c',
        'surface-container-lowest': '#000000',
        'surface-container-low': '#131313',
        'surface-container': '#1a1a1a',
        'surface-container-high': '#20201f',
        'surface-container-highest': '#262626',
        'primary': '#81ecff',
        'primary-dim': '#00d4ec',
        'primary-container': '#00e3fd',
        'on-primary': '#005762',
        'on-primary-fixed': '#003840',
        'on-surface': '#ffffff',
        'on-surface-variant': '#adaaaa',
        'outline': '#767575',
        'outline-variant': '#484847',
        'secondary': '#10d5ff',
        'secondary-container': '#00677d',
        'error': '#ff716c',
        'error-container': '#9f0519',
      },
      fontFamily: {
        'headline': ['Inter', 'sans-serif'],
        'body': ['Manrope', 'sans-serif'],
        'label': ['Space Grotesk', 'monospace'],
      },
    },
  },
  plugins: [],
}
