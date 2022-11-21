-- Automatically install packer.nvim
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
--vim.cmd [[
--    augroup packer_user_config
--        autocmd!
--        autocmd BufWritePost plugins.lua source <afile> | PackerSync
--    augroup end
--]]
local packer_user_config = vim.api.nvim_create_augroup('packer_user_config', {clear=true})

vim.api.nvim_create_autocmd({'BufWritePost'}, {
    pattern = 'plugins.lua',
    group = packer_user_config,
    command = 'source <afile> | PackerSync'
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
        return require("packer.util").float { border = "rounded" }
        end,
    },
}


--  useage
-- use {
--   "myusername/example",        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports "*" for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
--   requiring a string which matches one of these patterns, the plugin will be loaded.
-- }
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'lewis6991/impatient.nvim' -- speed up loading Lua modules in Neovim to improve startup time
    -- use 'nathom/filetype.nvim' -- speed up neovim startup time

    use 'aserowy/tmux.nvim' -- bridges tmux with neovim


    -- Highlights
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/nvim-treesitter-context'

    -- UI
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    } -- file explorer
    use "p00f/nvim-ts-rainbow" -- rainbow parentheses, a module for nvim-treesitter
    -- use 'JoosepAlviste/nvim-ts-context-commentstring' -- changes the commentstring setting in complex filetypes

    use "ellisonleao/gruvbox.nvim" -- colorschemes
    use 'eddyekofo94/gruvbox-flat.nvim' -- colorschemes
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }  -- status line
    use 'kdheepak/tabline.nvim' -- a "buffer and tab" tabline
    -- use {'akinsho/bufferline.nvim', tag = "v3.*"} -- buffer and tab line
    use 'simrat39/symbols-outline.nvim' -- outline
    use "rcarriga/nvim-notify" -- a fancy, configurable, notification manager for neovim
    use {"akinsho/toggleterm.nvim", tag = '*' } -- persist and toggle multiple terminals during an editing session
    -- use "numToStr/FTerm.nvim" -- floating terminal plugin for neovim
    use "lukas-reineke/indent-blankline.nvim" -- add indent blankline

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use 'williamboman/mason.nvim' -- simple to use lsp and dap
    use 'williamboman/mason-lspconfig.nvim' -- bridges mason.nvim with the lspconfig plugin
    use "ray-x/lsp_signature.nvim" -- show function signature when typing
    use "lukas-reineke/lsp-format.nvim" -- a wrapper around Neovims native LSP formatting
    -- use 'rmagatti/goto-preview' -- previewing native LSP's goto definition, type definition, implementation, and references calls in floating windows


    -- Editor enhance
    use "windwp/nvim-autopairs" -- autopairs, integrates with both cmp and treesitter
    use "hrsh7th/nvim-cmp" -- the completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    -- use "ray-x/cmp-treesitter"
    -- use "rafamadriz/friendly-snippets"
    -- use "onsails/lspkind-nvim"

    use "terrortylor/nvim-comment"  -- comment/uncomment command
    use 'ethanholz/nvim-lastplace' -- auto return back to the last modified positon when open a file
    use {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
    }
    -- use "kevinhwang91/nvim-bqf" -- better quickfix but not support telescope for now
    use "folke/trouble.nvim" -- pretty list for showing diagnostics, references, telescope results, quickfix and location lists
    use "lewis6991/hover.nvim" -- similar to vim.lsp.buf.hover


    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        -- tag = '0.1.0',
        -- or
        branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    } -- native sorter
    use "nvim-telescope/telescope-dap.nvim" -- integration for nvim-dap with telescope.nvim
    use "nvim-telescope/telescope-live-grep-args.nvim" -- live grep args picker for telescope.nvim
    -- use 'nvim-telescope/telescope-ui-select.nvim'
    --


    -- Debugger
    use 'mfussenegger/nvim-dap'


    -- Git
    use {
      'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }
    use 'sindrets/diffview.nvim'



    -- Markdown
    use{ "iamcco/markdown-preview.nvim",
    run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown"},
    }

    -- Automatically set up configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
