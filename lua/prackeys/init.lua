-- File: lua/prackeys/init.lua

local M = {}

--- Toggles the enabled/disabled state of the arrow keys.
function M.toggle_arrows()
    -- Get current state from a global variable, defaulting to false (enabled)
    -- We use a local variable here to avoid directly modifying global state
    local arrows_disabled = vim.g.practice_mode_arrows_disabled or false

    if arrows_disabled then
        -- 1. ENABLE arrows (Delete the <Nop> mappings)
        -- We must explicitly define the original keys to delete the custom maps.

        -- Normal, Insert, and Visual modes
        local modes = { 'n', 'i', 'v' }
        local keys = { '<Up>', '<Down>', '<Left>', '<Right>' }

        for _, mode in ipairs(modes) do
            for _, key in ipairs(keys) do
                -- Removing a mapping in Neovim is tricky. The best way is to
                -- check if the key is already mapped and only delete if it
                -- was mapped by the plugin. For simplicity here, we assume
                -- this plugin is the only one mapping it to <Nop>.
                -- A direct call to vim.keymap.del will delete the *most recent* mapping.
                pcall(vim.keymap.del, mode, key)
            end
        end

        vim.g.practice_mode_arrows_disabled = false
        vim.notify("Practice Mode OFF: Arrow keys enabled ✓", vim.log.levels.INFO)
    else
        -- 2. DISABLE arrows (Map them to <Nop>)

        -- Normal, Insert, and Visual modes
        local modes = { 'n', 'i', 'v' }
        local keys = { '<Up>', '<Down>', '<Left>', '<Right>' }

        for _, mode in ipairs(modes) do
            for _, key in ipairs(keys) do
                -- Setting the mapping
                vim.keymap.set(mode, key, '<Nop>', { noremap = true, silent = true, desc = 'Practice Mode: Arrows Disabled' })
            end
        end

        vim.g.practice_mode_arrows_disabled = true
        vim.notify("Practice Mode ON: Arrow keys disabled ❌", vim.log.levels.INFO)
    end
end

--- The main setup function. Users will call this from their config.
function M.setup(user_config)
    -- Merge default config with user provided config (if needed later)
    -- For now, we only define the command.

    -- Define a Neovim user command to toggle the state easily: :PracticeToggle
    vim.api.nvim_create_user_command(
        'PracticeToggle',
        M.toggle_arrows,
        {
            nargs = 0,
            desc = 'Toggles Practice Mode (Arrow Keys Off/On)'
        }
    )
end

return M
