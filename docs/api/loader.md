<div align="center">
<h1>Loader</h1>

Core module loader for Hermes
</div>

<hr>

# `loader:Register`

Register a table of `ModuleScript` instances into the Hermes module cache. 
These modules will be loaded and turned into providers when [`:Fly`](./loader.md#fly) is called.

### Signature

```luau
loader.Register(self: loader, modules: { ModuleScript })
```
<br>
<hr>
<br>
<br>

# `loader:RequireModules`

Requires a table of `ModuleScript` instances. Usually used to require [`Components`](./component.md).


### Signature

```luau
loader.RequireModules(_self: loader, modules: { ModuleScript })
```

<br>
<hr>
<br>
<br>

# `loader:Fly`

Initiates all `ModuleScript` instances inside the Hermes module cache, turning them into providers.


### Signature

```luau
loader.Fly(self: loader)
```

<br>
<hr>
<br>
<br>

# `loader:Use`

Gets a provider from Hermes's provider cache. Returns nil if it was not found.


### Signature

```luau
loader.Use(self: loader, name: string): Provider?
```

### Aliases

#### `loader:UseProvider`

<br>