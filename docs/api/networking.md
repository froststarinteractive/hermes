<div align="center">
<h1>Networking</h1>

Server/Client communication for Hermes
</div>

<hr>

# `networking:Ask`

Asks the server/client a question, and returns and answer


### Parameters

<table style="width:100%; border-collapse: collapse;">
  <thead>
    <tr>
      <th style="padding:8px; text-align:left;">Parameter</th>
      <th style="padding:8px; text-align:left;">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="padding:8px;"><strong>name</strong></td>
      <td style="padding:8px;">The <strong>name</strong> of the remote.</td>
    </tr>
    <tr style="background-color:rgba(0, 0, 0, 0);">
      <td style="padding:8px;"><strong>playerOrAny</strong></td>
      <td style="padding:8px;">If on <strong>server</strong>, specify the <strong>player</strong> you want to fire the remote to.<br>If on <strong>client</strong>, you can pass <em>anything</em>.</td>
    </tr>
    <tr>
      <td style="padding:8px;"><strong>...</strong></td>
      <td style="padding:8px;">Any other values you want to send, <strong>except functions</strong> (due to Roblox restrictions).</td>
    </tr>
  </tbody>
</table>

### Signature

```luau
networking.Ask(_self: networking, name: string, playerOrAny: Player | any, ...: any): any?
```
<br>
<hr>
<br>
<br>

# `networking:Tell`

Tells the server/client to do something.


### Parameters

<table style="width:100%; border-collapse: collapse;">
  <thead>
    <tr>
      <th style="padding:8px; text-align:left;">Parameter</th>
      <th style="padding:8px; text-align:left;">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="padding:8px;"><strong>name</strong></td>
      <td style="padding:8px;">The <strong>name</strong> of the remote.</td>
    </tr>
    <tr style="background-color:rgba(0, 0, 0, 0);">
      <td style="padding:8px;"><strong>playerOrAny</strong></td>
      <td style="padding:8px;">If on <strong>server</strong>, specify the <strong>player</strong> you want to fire the remote to.<br>If not a player, fires <strong>all clients</strong>.</td>
    </tr>
    <tr>
      <td style="padding:8px;"><strong>...</strong></td>
      <td style="padding:8px;">Anything you want to send, <strong>except functions</strong> (due to Roblox restrictions).</td>
    </tr>
  </tbody>
</table>


### Signature

```luau
networking.Tell(_self: networking, name: string, playerOrAny: Player | any, ...: any)
```

<br>
<hr>
<br>
<br>

# `networking:TellUnreliably`

Tells the server/client to do something, but with unreliable remote events.


### Parameters

<table style="width:100%; border-collapse: collapse;">
  <thead>
    <tr>
      <th style="padding:8px; text-align:left;">Parameter</th>
      <th style="padding:8px; text-align:left;">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="padding:8px;"><strong>name</strong></td>
      <td style="padding:8px;">The <strong>name</strong> of the remote.</td>
    </tr>
    <tr style="background-color:rgba(0, 0, 0, 0);">
      <td style="padding:8px;"><strong>playerOrAny</strong></td>
      <td style="padding:8px;">If on <strong>server</strong>, specify the <strong>player</strong> you want to fire the remote to.<br>If not a player, fires <strong>all clients</strong>.</td>
    </tr>
    <tr>
      <td style="padding:8px;"><strong>...</strong></td>
      <td style="padding:8px;">Anything you want to send, <strong>except functions</strong> (due to Roblox restrictions).</td>
    </tr>
  </tbody>
</table>


### Signature

```luau
networking.TellUnreliably(_self: networking, name: string, playerOrAny: Player | any, ...: any)
```

<br>
<hr>
<br>
<br>

# `networking:ListenToTell`

Listens to when the client/server tells the server/client to do something. Returns an RBXScriptConnection


### Signature

```luau
networking.ListenToTell(_self: networking, name: string, callback: (Player | any, any) -> ()): RBXScriptConnection
```

<br>
<hr>
<br>
<br>

# `networking:ListenToUnreliableTell`

Listens to when the client/server tells the server/client to do something unreliable. Returns an RBXScriptConnection.

### Signature

```luau
networking.ListenToUnreliableTell(_self: networking, name: string, callback: (Player | any, any) -> ()): RBXScriptConnection
```

<br>
<hr>
<br>
<br>

# `networking:ListenToAsk`

Listens to when the client/server ask the server/client something. Returns a cleanup function.


### Signature

```luau
networking.ListenToAsk(_self: networking, name: string, callback: (Player | any, any) -> ()): () -> ()
```

<br>
<hr>
<br>
<br>

# `networking:Wait`

Yields until the given remote is fired.


### Signature

```luau
networking.Wait(_self: networking, name: string)
```

<br>
<hr>
<br>
<br>

# `networking:WaitUnreliably`

Yields until the given unreliable remote is fired.


### Signature

```luau
networking.WaitUnreliably(_self: networking, name: string)
```

<br>
