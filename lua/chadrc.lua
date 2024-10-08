-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
    theme = "vscode_dark",
    transparency = true,

    hl_override = {
        CursorLine = {
            bg = "one_bg",
        },
        LineNr = {
            fg = "light_grey",
        },
        Include = {
            fg = "dark_purple",
        },
        Comment = {
            fg = "comment",
        },
    },
    cmp = {
        icons = true,
        lspkind_text = true,
        style = "default",
    },
    statusline = {
        theme = "vscode_colored",
    },
}

return M
