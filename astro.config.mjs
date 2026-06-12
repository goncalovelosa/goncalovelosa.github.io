import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';

export default defineConfig({
  site: 'https://goncalovelosa.github.io',
  integrations: [mdx()],
  build: {
    assets: 'assets',
  },
});
