return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "html",
                "css",
                "markdown",
                "javascript",
                "c",
                "tsx",
            },
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",

            -- optional
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            lang = "python3",
        },
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup {
                background_colour = "#000000",
            }
        end,
    },
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g["vimtex_view_method"] = "zathura"
            vim.g["vimtex_quickfix_mode"] = 0 -- suppress error reporting on save and build
            vim.g["tex_conceal"] = "mgs"
            vim.g["vimtex_matchparen_enabled"] = 0
            vim.g["vimtex_delim_stopline"] = 1
            vim.o.conceallevel = 2
            vim.g["vimtex_log_ignore"] = { -- Error suppression:
                "Underfull",
                "Overfull",
                "specifier changed to",
                "Token not allowed in a PDF string",
            }
        end,
    },
    {
        "sirver/ultisnips",
        lazy = false,
        config = function()
            vim.g["UltiSnipsExpandTrigger"] = "<tab>"
            vim.g["UltiSnipsJumpForwardTrigger"] = "<tab>"
            vim.g["UltiSnipsJumpBackwardTrigger"] = "<s-tab>"
        end,
    },
    {
        "GCBallesteros/jupytext.nvim",
        lazy = true,
        config = function()
            require("jupytext").setup {
                style = "markdown",
                output_extension = "md",
                force_ft = "markdown",
            }
        end,
    },
    {
        "benlubas/molten-nvim",
        lazy = true,
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        build = ":UpdateRemotePlugins",
        init = function()
            -- Key mappings for molten-nvim
            -- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
            -- vim.g.molten_auto_open_output = false

            -- optional, I like wrapping. works for virt text and the output window
            vim.g.molten_wrap_output = true

            -- be buggy with longer images
            vim.g.molten_virt_text_output = true

            -- this will make it so the output shows up below the \`\`\` cell delimiter
            vim.g.molten_virt_lines_off_by_1 = true

            vim.api.nvim_set_hl(0, "MoltenVirtualText", { fg = "#000000", bg = "#FFFFFF" })

            vim.keymap.set("n", "<space>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
            vim.keymap.set(
                "n",
                "<space>e",
                ":MoltenEvaluateOperator<CR>",
                { silent = true, desc = "run operator selection" }
            )
            vim.keymap.set("n", "<space>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
            vim.keymap.set("n", "<space>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
            vim.keymap.set(
                "v",
                "<space>r",
                ":<C-u>MoltenEvaluateVisual<CR>gv",
                { silent = true, desc = "evaluate visual selection" }
            )
            vim.keymap.set("n", "<space>so", ":MoltenShowOutput<CR>", { desc = "show output window", silent = true })
        end,
    },
    {
        "quarto-dev/quarto-nvim",
        lazy = true,
        dependencies = {
            "jmbuhr/otter.nvim",
            "hrsh7th/nvim-cmp",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },

        config = function()
            require "configs.quarto"
        end,
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("obsidian").setup {
                workspaces = {
                    {
                        name = "Paul",
                        path = "/Users/paulyoon/Library/Mobile Documents/iCloud~md~obsidian/documents/paulyoon",
                    },
                },
                notes_subdir = "inbox",
                new_notes_location = "notes_subdir",

                disable_frontmatter = true,
                templates = {
                    subdir = "templates",
                    date_format = "%Y-%m-%d",
                    time_format = "%H:%M:%S",
                },

                mappings = {
                    -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
                    ["gf"] = {
                        action = function()
                            return require("obsidian").util.gf_passthrough()
                        end,
                        opts = { noremap = false, expr = true, buffer = true },
                    },
                },
                completion = {
                    nvim_cmp = true,
                    min_chars = 2,
                },
                ui = {
                    checkboxes = {},
                    bullets = {},
                },
            }
        end,
    },
    -- Ai tool to make nvim like cursor.ai
    {
        "yetone/avante.nvim",
        lazy = true,
        opts = {
            -- add any opts here
            provider = "openai",
            hints = { enabled = false },
        },
        keys = {
            { "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Avante" },
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below is optional, make sure to setup it properly if you have lazy=true
            {
                "MeanderingProgrammer/render-markdown.nvim",
                lazy = true,
                keys = {
                    { "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Avante" },
                },
                opts = {
                    file_types = { "markdown", "Avante" },
                },
            },
        },
    },
}
