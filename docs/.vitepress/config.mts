import { defineConfig } from 'vitepress'
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Hermes",
  description: "Roblox game framework",

  titleTemplate: ":title | Docs",

  lastUpdated: true,
	cleanUrls: true,
	lang: 'en-US',

  vite: {
        ssr: {
            noExternal: [
                '@nolebase/vitepress-plugin-highlight-targeted-heading',
            ]
        }
  },

  head: [
		['link', { rel: 'icon', href: "https://raw.githubusercontent.com/froststarinteractive/hermes/e1545925d4dae0f904fb02a1c28516131f448fb6/assets/favicon-simplified.svg" }]
	],

  markdown: {
		theme: {
			light: "catppuccin-latte",
			dark: "catppuccin-frappe"
		},
    config(md) {
      md.use(tabsMarkdownPlugin);
    }
	},

  themeConfig: {
    lastUpdated: {
			text: 'Last edit',
			formatOptions: {
			  dateStyle: 'short',
			  timeStyle: 'short',
			  forceLocale: true,
			}
		},

		logo: "https://raw.githubusercontent.com/froststarinteractive/hermes/e1545925d4dae0f904fb02a1c28516131f448fb6/assets/favicon-simplified.svg",

    search: {
      provider: "local"
    },

    footer: {
      message: 'Released under the MIT License.',
    },

    nav: [
      { text: 'Home', link: '/' },
      { text: 'Getting Started', link: '/getting-started' },
      { text: 'API', link: '/api/server/functions/get-service.md' }
    ],

    sidebar: {
      "/api/": []
  },

    socialLinks: [
			{ icon: 'github', link: 'https://github.com/froststarinteractive/hermes' },
			{ icon: 'discord', link: 'https://discord.gg/TRM8TwsjnP' },
      {
        icon: {
          svg: '<svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M49.6025 0L92.9038 25V75L49.6025 100L6.30127 75V25L49.6025 0ZM14.3013 29.6188L49.6025 9.2376L84.9038 29.6188V70.3812L49.6025 90.7624L33.6148 81.5319V67.3848C34.5167 68.5071 35.6388 69.4215 36.981 70.1279C38.9701 71.148 41.0357 71.658 43.1779 71.658C46.442 71.658 49.1452 70.8929 51.2873 69.3629C53.4805 67.7818 55.1126 65.7672 56.1836 63.319C57.0915 61.3382 57.632 59.274 57.8054 57.1263C59.8723 57.7457 62.2157 58.0554 64.8356 58.0554C67.6918 58.0554 70.3695 57.6473 72.8686 56.8313C75.3678 55.9642 77.4079 54.8167 78.989 53.3886L75.7758 47.8038C74.5517 48.9258 72.9961 49.8439 71.109 50.5579C69.2219 51.221 67.2073 51.5525 65.0652 51.5525C61.3929 51.5525 58.6643 50.6854 56.8792 48.9513C56.7195 48.7962 56.567 48.6365 56.4217 48.472C55.6102 47.5539 55.0211 46.4896 54.6546 45.2791L54.6443 45.2452L54.669 45.2791H79.2185V41.9894C79.2185 39.0313 78.5555 36.3536 77.2294 33.9565C75.9543 31.5593 74.0927 29.6467 71.6445 28.2186C69.2474 26.7395 66.3657 26 62.9995 26C59.6843 26 56.8027 26.7395 54.3545 28.2186C51.9064 29.6467 50.0193 31.5593 48.6932 33.9565C47.6743 35.7983 47.0469 37.8057 46.8108 39.9788C45.6888 39.728 44.4778 39.6026 43.1779 39.6026C41.0357 39.6026 38.9701 40.1127 36.981 41.1327C35.3162 41.9651 33.9902 43.1549 33.0028 44.7023V40.3677H20.6855V46.2585H25.8113V77.0266L14.3013 70.3812V29.6188ZM55.1961 36.0986C54.6528 37.1015 54.3321 38.1216 54.234 39.1588H71.7976C71.7976 38.0367 71.4405 36.9401 70.7265 35.8691C70.0634 34.747 69.0689 33.8035 67.7428 33.0384C66.4677 32.2734 64.8867 31.8908 62.9995 31.8908C61.1124 31.8908 59.5058 32.2989 58.1798 33.1149C56.9047 33.88 55.9101 34.8745 55.1961 36.0986ZM49.6451 51.5692C49.3076 50.6641 48.8381 49.871 48.2367 49.1898C48.0885 49.0219 47.9323 48.8609 47.7681 48.7067C46.085 47.0746 44.0449 46.2585 41.6478 46.2585C40.1177 46.2585 38.6131 46.5645 37.134 47.1766C35.8594 47.6773 34.6863 48.5438 33.6148 49.7759V61.47C34.6863 62.6664 35.8594 63.5378 37.134 64.084C38.6131 64.6961 40.1177 65.0021 41.6478 65.0021C44.0449 65.0021 46.085 64.1861 47.7681 62.554C49.4512 60.9219 50.2928 58.6012 50.2928 55.5921C50.2928 54.0679 50.0769 52.727 49.6451 51.5692Z" fill="#F19D1E"></path></svg>'
        }, 
        link: 'https://pesde.dev/packages/hermes/core/'
      }
    ]
  }
})
