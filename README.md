# Prackeys

**Encourage better Vim habits by enforcing movement keys (`h`/`j`/`k`/`l`).**

`prackeys` is a simple Neovim plugin that allows you to easily toggle the functionality of the arrow keys (`<Up>`, `<Down>`, `<Left>`, `<Right>`) across Normal, Insert, and Visual modes, remapping them to `<Nop>` (no operation) when the mode is active.

This is useful for both beginners and intermediate users who want to reinforce moving exclusively with the home row keys (`h`/`j`/`k`/`l`) without relying on the arrow keys.

## ✨ Features

* **Quick Toggle:** Activate or deactivate "Practice Mode" with a single command or keybind.
* **Persistent State:** Uses a global variable to track the mode, ensuring reliable toggling.
* **Multi-Mode Coverage:** Disables arrows in Normal, Insert, and Visual modes.
* **Clear Notifications:** Provides notifications upon toggling the state.

## 📦 Installation

Install this plugin using your preferred Neovim package manager.

### `lazy.nvim` (Recommended)

Add the following to your `plugins` specification (e.g., in `lua/plugins/init.lua`):

```
return {
  -- Your other plugins...

  {
    'Thebuilderekes/prackeys',
    config = function()
      -- Call setup to define the :PracticeToggle command
      require('prackeys').setup()
    end,
    -- Define a convenient keymap for toggling the mode
    keys = {
      {
        '<leader>pm',
        function() require('prackeys').toggle_arrows() end,
        desc = "Toggle Nvim Practice Mode (Arrow Keys Off/On)",
      },
    },
  },
}
```

### packer.nvim
```
-- Requires: 'Thebuilderekes/prackeys'
use {
    'Thebuilderekes/prackeys', -- Replace 'Thebuilderekes' 

    -- 1. Configuration: Call the setup function when the plugin is loaded
    config = function()
        require('prackeys').setup()
    end,

    -- 2. Mapping: Define the keybind that calls the toggle function
    -- This ensures the keymap is set up after the plugin is available.
    run = function()
        vim.keymap.set('n', '<leader>pm', function()
            -- Call the specific exported function to toggle the state
            require('prackeys').toggle_arrows()
        end, { desc = "Toggle Nvim Practice Mode (Arrow Keys Off/On)" })
    end
}
```


 ## 🚀 Usage

The plugin offers a Lua function and a Neovim command to control the mode.

You can run the built-in command at any time:

:PracticeToggle or ``<Leader>pm``
