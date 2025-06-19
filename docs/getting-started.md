<div align="center">
<img src="https://github.com/froststarinteractive/hermes/blob/27358fea0293f602b065f5602dac0be4a4ac090f/assets/icon.svg?raw=true" alt="Icon"/>

<h1><b>Game Framework</b></h1>
<img alt="Version Number" src="https://img.shields.io/badge/dynamic/toml?url=https%3A%2F%2Fraw.githubusercontent.com%2Ffroststarinteractive%2Fhermes%2Frefs%2Fheads%2Fmain%2Fpesde.toml&query=%24.version&label=version">

<img style="padding-top: 5px" alt="GitHub Downloads" src="https://img.shields.io/github/downloads/froststarinteractive/hermes/total">

</div>

**Hermes** is a game framework for Roblox making it easy and fast to create games.

Hermes's core includes:

- A module loader
- Extremely easy server-client communication functions
- Components system

## Installation

### Pesde

Hermes only supports pesde at the moment, but we are planning to make a wally release in the future.

```cmd
pesde add hermes/core
```

Then, run:

```cmd
pesde i
```

## Setting up your project

Your VSCode file tree should look something like this:

```
roblox_packages (Where Hermes is stored.)
src:
    client:
        components:
        providers:
        init.luau
    server:
        components:
        providers:
        init.luau
    shared:
```

Your *project.json* file should look something like this:

```json
{
  "name": "Generic Hermes Game",
  "tree": {
    "$className": "DataModel",

    "ReplicatedStorage": {
      "Shared": {
        "$path": "src/shared"
      },
      "Packages": {
        "$path": "roblox_packages"
      }
    },

    "ServerScriptService": {
      "Server": {
        "$path": "src/server"
      },
    },

    "StarterPlayer": {
      "StarterPlayerScripts": {
        "Client": {
          "$path": "src/client"
        },
      }
    }
  }
}
```

## Starting Hermes

First, require Hermes:

```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:FindFirstChild("Packages")

local Hermes = require(Packages.Hermes)
```

### Adding Providers

Add your providers by calling:

```luau

Hermes:Register(script.Providers:GetChildren())
```

### Start it!

Lastly, to start Hermes use:

```luau
Hermes:Fly()
```