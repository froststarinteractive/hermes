---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Hermes"
  text: "Hermes is a game framework for Roblox."
  tagline: Making games <u>shouldn't</u> be <i>hard</i>.
  image:
    src: https://raw.githubusercontent.com/froststarinteractive/hermes/4b104048cea9a0fa721bd34031abf071fa462fb5/assets/favicon.svg
  actions:
    - theme: brand
      text: Getting Started
      link: /getting-started
    - theme: alt
      text: API
      link: /api/loader

features:
  - title: Lightweight Module Loader
    details: Cleanly organize and require modules without boilerplate.
  - title: Networking Layer
    details: Simple Ask / Tell API for RemoteEvents, RemoteFunctions, and Unreliable remotes.
  - title: Component System
    details: Attach behaviors to tagged instances with lifecycle methods (Construct, Start, Destroy, Heartbeat).
  - title: Modding Support
    details: Extend Hermes with custom mods that seamlessly merge into the main API.
  - title: Clean API
    details: Intuitive, Roblox-style methods (ListenToTell, TellUnreliably, JoinWithMods)
---

