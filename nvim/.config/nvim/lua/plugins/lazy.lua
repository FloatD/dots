-- Install lazylazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

    -- Color scheme
    { "catppuccin/nvim",               as = "catppuccin" },

    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    -- {
    --     "FloatD/robotframework-neovim",
    --     lazy = false, -- Load immediately for testing
    --     config = function()
    --         vim.cmd("syntax on")
    --         vim.filetype.add({
    --             extension = {
    --                 robot = "robot",
    --             },
    --         })
    --     end,
    -- },

    -- Fuzzy Finder (files, lsp, etc)
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- File tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },

    -- Save and load buffers (a session) automatically for each folder
    {
        'rmagatti/auto-session',
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Downloads" },
            }
        end
    },

    -- Comment code
    {
        'terrortylor/nvim-comment',
        config = function()
            require("nvim_comment").setup({ create_mappings = false })
        end
    },

    -- Visualize buffers as tabs
    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },

    -- Preview markdown live in web browser
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- Tree-sitter for better syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { "c", "cpp", "lua", "python", "javascript", "html", "css", "markdown", "robot" },
                highlight = {
                    enable = true, -- false will disable the whole extension
                },
                autopairs = {
                    enable = true,
                },
            }
        end,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
            config = function()
            require("nvim-autopairs").setup({
                check_ts = true, -- Enable Tree-sitter integration
            })

            -- Optional: Integrate with nvim-cmp for autocompletion
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    -- Autocompletion (nvim-cmp)
    {
        "hrsh7th/nvim-cmp", -- The main autocompletion plugin
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
            "hrsh7th/cmp-path", -- Path source for nvim-cmp
            "hrsh7th/cmp-cmdline", -- Cmdline source for nvim-cmp
            "saadparwaiz1/cmp_luasnip", -- LuaSnip source for nvim-cmp
            "L3MON4D3/LuaSnip", -- LuaSnip plugin for snippets
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Setup nvim-cmp
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For LuaSnip users
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    -- ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "cmdline" },
                    { name = "luasnip" },
                },
            })

            -- Setup for command-line completion
            cmp.setup.cmdline(":", {
                sources = {
                    { name = "cmdline" },
                    { name = "path" },
                },
            })

            -- Setup for buffer completion in command mode
            cmp.setup.cmdline("/", {
                sources = {
                    { name = "buffer" },
                },
            })
        end,
    },

    -- LSP Management and Configuration
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed =
                {
                  "pyright",
                  "lua_ls",
                  "robotframework_ls",
                  "clangd",
                },
            })
        end
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            -- LSP setup for specific servers
            lspconfig.pyright.setup{
                capabilities = cmp_nvim_lsp.default_capabilities(),
            }
            lspconfig.lua_ls.setup{
                capabilities = cmp_nvim_lsp.default_capabilities(),
            }
            lspconfig.clangd.setup{
                capabilities = cmp_nvim_lsp.default_capabilities(),
            }
            lspconfig.robotframework_ls.setup{
                capabilities = cmp_nvim_lsp.default_capabilities(),
            }

            -- Optionally configure other LSP settings
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
        end
    },

    -- end of file
})

