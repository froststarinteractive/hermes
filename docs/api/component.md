<div align="center">
<h1>Component</h1>

Component module for Hermes
</div>

<hr>

Can be accessed via `Hermes.Component`

<hr>

# `component.new`

Creates a new component class.

<hr>

# Component Class

#### `Component:Construct`
Called when the component is first initialized.
#### `Component:Start`
Called when a new instance with the `Component.Tag` is created.
#### `Component:Heartbeat`
Called every tick.
#### `Component:Destroy`
Called when the `Component.Tag` is removed from an instance, or when the instance is destroyed.
### `Component:Fly`
Starts up the component, should be the value that is returned in the component ModuleScript.