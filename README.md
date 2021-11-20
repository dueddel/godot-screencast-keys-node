# Screencast Keys node for Godot


## What?

This plugin provides an easy to use screencast keys feature for your Godot project.

![](screencast-keys-demo.gif)

## How?

Just hit the plus button to add a new child node to your scene and search for `ScreencastKeys`.

![](screenshot-add-node.png)

Pressed keys will appear lined up in a row or line-wisely stacked when running your game/app depending on how you set the `ScreencastKey`'s property for where new keys appear.

![](screenshot-set-appearance.png)

Other than that treat it like a usual `Label` node. ❤️


## Pro tip

After adding the `ScreencastKeys` node to your scene set the `max_lines_visible` property to some appropriate limit (e.g. `10` or `20` or whatever fits your needs best) and play around with the `new_keys_appear` property (see above).

![](screenshot-set-line-limit.png)


## Installation

1. Copy the `addons/` folder into your project (respectively copy the sub-folder `screencast_keys/` into your existing `addons/` folder in your project).
2. Activate the **Screencast Keys** plugin in your project settings.
3. There's no 3, that's it.

See also [&rarr; installation instructions for Godot plugins](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html) in the official docs.


## License

This plugin including this documentation, its source code and all other assets (unless stated differently) are licensed under the terms of the MIT license. See also the project's [license file](LICENSE.md).


## Used 3rd party assets

![Button Finger Icon by delapouite](button-finger.svg)

Credits for the [button-finger](https://game-icons.net/1x1/delapouite/button-finger.html) icon which is licensed under [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/) go to [Delapouite](https://delapouite.com/).
