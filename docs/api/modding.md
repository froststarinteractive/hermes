<div align="center">
<h1>Modding</h1>

Barebones moding API for Hermes
</div>

<hr>

# `modding:RegisterMod`

Registering a mod (a table) joins it with the main Hermes table, allowing you to do basically anything you want with it.


## Basic example

```lua
local Hermes = require("path/to/hermes")

local Mod = {
    Hello = function(name)
        print(`Hello, {name}!`)
    end
}

Hermes:RegisterMod(Mod)

Hermes.Hello("Bob")
-- Output: Hello, Bob!

```