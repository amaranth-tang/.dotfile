local options = {
    background = "dark",                          -- try to use colors that look good on a dark background
    backspace = "indent,eol,start",               -- make backspace work
    backup = false,                               -- creates a backup file
    clipboard = "unnamedplus",                    -- allows neovim to access the system clipboard
    cmdheight = 1,                                -- keep status bar position close to bottom
    completeopt = { "menu", "menuone", "noselect"  },     -- mostly just for cmp
    conceallevel = 0,                             -- so that `` is visible in markdown files
    cursorcolumn = true,                          -- highlight the current column.
    cursorline = true,                            -- highlight the current line
    cscopequickfix = "s-,c-,d-,i-,t-,e-",         -- cscope output to quickfix window
    diffopt = "vertical,filler,internal,context:4", -- vertical diff split view
    encoding = "utf-8",                             -- the encoding used inside vim
    expandtab = true,                             -- convert tabs to spaces
    fileencoding = "utf-8",                       -- the encoding written to a file
    fileencodings = "utf-8,ucs-bom,gbk,cp936,gb2312,gb18030", -- a list of encodings when reading a file
    foldenable = false,                           -- no fold to be applied when open a file
    foldlevel = 99,                               -- if not set this, fold will be everywhere
    foldmethod = "indent",                        -- fold with nvim_treesitter
    -- guifont = "monospace:h17",                    -- the font used in graphical neovim applications
    hlsearch = true,                              -- highlight all matches on previous search pattern
    ignorecase = true,                            -- ignore case in search patterns
    laststatus = 2,                               -- display the status line always
    list = true,                                  -- display hidden characters
    mouse = "a",                                  -- allow the mouse to be used in neovim
    number = true,                                -- set numbered lines
    numberwidth = 4,                              -- set number column width{default 4}
    pumheight = 10,                               -- pop up menu height
    -- relativenumber = true,                        -- set relative numbered lines
    ruler= true,                                  -- show the line and column number of the cursor position
    scrolloff = 8,                                -- keep 8 height offset from above and bottom
    shiftwidth = 4,                               -- the number of spaces inserted for each indentation
    showcmd = true,                               -- show the commands which you enter
    showmode = false,                             -- whether show things like -- INSERT --
    showtabline = 2,                              -- always show tabs
    sidescrolloff = 8,                            -- keep 8 width offset from left and right
    signcolumn = "yes",                           -- always show the sign column, otherwise it would shift the text each time
    smartcase = true,                             -- smart case
    smartindent = true,                           -- make indenting smarter again
    softtabstop = 4,                              -- the number of spaces when hitting tab
    spell = false,                                -- add spell support
    spelllang = { 'en_us'  },                     -- support which languages?
    splitbelow = true,                            -- force all horizontal splits to go below current window
    splitright = true,                            -- force all vertical splits to go to the right of current window
    swapfile = false,                             -- creates a swapfile
    tabstop = 4,                                  -- the number of spaces of a tab
    termguicolors = true,                         -- set term gui colors (most terminals support this)
    termencoding = "utf-8",                         -- the encoding used for the terminal
    timeoutlen = 500,                             -- time to wait for a mapped sequence to complete (in milliseconds)
    ttimeoutlen = 0,                              -- fix <Esc> delay
    undofile = true,                              -- enable persistent undo
    updatetime = 300,                             -- faster completion (4000ms default)
    writebackup = false,                          -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    wrap = true,                                 -- whether display lines as one long line

    --autoindent = true, --自动缩进
    --showcmd = true, --右下角显示命令
}

vim.opt.shortmess:append 'c'
for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"              -- make h, l, left and right arrow keys to wrap around lines



-- set relative numbered lines
local relative_numbers = vim.api.nvim_create_augroup('relative_numbers', {clear = true})
vim.api.nvim_create_autocmd({'InsertEnter'}, {
    group = relative_numbers,
    command = "set norelativenumber"
})
vim.api.nvim_create_autocmd({'InsertLeave'}, {
    group = relative_numbers,
    command = "set relativenumber"
})
-- unload powerline
vim.g.powerline_loaded = 1

-- vim.opt.foldmethod     = 'expr'
-- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
---WORKAROUND
vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
    group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
    callback = function()
        vim.opt.foldmethod     = 'expr'
        vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
    end
})
---ENDWORKAROUND

