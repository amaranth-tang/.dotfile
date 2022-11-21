local status_toggleterm_ok, toggleterm = pcall(require, "toggleterm")
if not status_toggleterm_ok then
    vim.notify("toggleterm not found!")
    return
end

toggleterm.setup{
    -- size can be a number or function which is passed the current terminal
    -- size = function(term) -- 20 | function(term)
    --   if term.direction == "horizontal" then
    --     return 15
    --   elseif term.direction == "vertical" then
    --     return vim.o.columns * 0.4
    --   end
    -- end,
    size = 10,
    open_mapping = [[<c-g>]],
    hide_numbers = false, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
    -- highlights = {
    --   -- highlights which map to a highlight group name and a table of it's values
    --   -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
    --   Normal = {
    --     guibg = "<VALUE-HERE>",
    --   },
    --   NormalFloat = {
    --     link = 'Normal'
    --   },
    --   FloatBorder = {
    --     guifg = "<VALUE-HERE>",
    --     guibg = "<VALUE-HERE>",
    --   },
    -- },
    shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
    direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        -- like `size`, width and height can be a number or function which is passed the current terminal
        -- width = <value>,
        -- height = <value>,
        winblend = 10,
        highlights = {
            border = "Normal",
            background = "Normal",
        }
    },
    winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
            return term.name
        end
    },
    -- Add executables on the config.lua
    -- { exec, keymap, name}
    -- lvim.builtin.terminal.execs = {{}} to overwrite
    -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
    -- TODO: pls add mappings in which key and refactor this
}

function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


-- Custom Terminals
local Terminal = require("toggleterm.terminal").Terminal

-- ipython
local ipython = Terminal:new({
    cmd = "ipython",
    direction = 'horizontal',
    hidden = true,
})
function _IPYTHON_TOGGLE()
	ipython:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>ip", "<cmd>lua _IPYTHON_TOGGLE()<CR>", {noremap = true, silent = true})

-- htop
local htop = Terminal:new({
    cmd = "htop",
    direction = 'float',
    hidden = true,
})
function _HTOP_TOGGLE()
	htop:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>ht", "<cmd>lua _HTOP_TOGGLE()<CR>", {noremap = true, silent = true})
