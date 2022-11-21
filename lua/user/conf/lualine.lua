local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    vim.notify("lualine not found!")
    return
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
    always_visible = true,
}

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diff = {
    "diff",
    colored = true,
    symbols = { added = "  ", modified = " ", removed = " " },
    diff_color = {
        added = { fg = "#98be65" },
        modified = { fg = "#ecbe7b" },
        removed = { fg = "#ec5f67" },
    },
    cond = hide_in_width
}

local mode = {
    "mode",
    fmt = function(str)
        return "--" .. str .. "--"
    end,
}

local file_name = {
    'filename',
    file_status = true, -- Displays file status (readonly status, modified status)
    path = 1,           -- 0: Just the filename
                        -- 1: Relative path
                        -- 2: Absolute path

    shorting_target = 40, -- Shortens path to leave 40 spaces in the window
    -- for other components. (terrible name, any suggestions?)
    symbols = {
        modified = '[+]',      -- Text to show when the file is modified.
        readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
        newfile = '[New]',     -- Text to show for new created file before first writting
    },
}

local filetype = {
    "filetype",
    icons_enabled = true,
    icon = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

local location = {
    "location",
    padding = 0,
}


lualine.setup {
    options = {
        icons_enabled = true, -- enable icons on all components
        theme = 'auto',  -- lualine theme
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {       -- Filetypes to disable lualine for.
                statusline = {},     -- only ignores the ft for statusline.
                winbar = {},         -- only ignores the ft for winbar.
        },
        ignore_focus = {},           -- If current filetype is in this list it'll
                                     -- always be drawn as inactive statusline
                                     -- and the last window will be drawn as active statusline.
                                     -- for example if you don't want statusline of
                                     -- your file tree / sidebar window to have active
                                     -- statusline you can add their filetypes here.

        always_divide_middle = true, -- When set to true, left sections i.e. 'a','b' and 'c'
                                     -- can't take over the entire statusline even
                                     -- if neither of 'x', 'y' or 'z' are present.

        globalstatus = false,        -- enable global statusline (have a single statusline
                                     -- at bottom of neovim instead of one for  every window).
                                     -- This feature is only available in neovim 0.7 and higher.

        refresh = {                  -- sets how often lualine should refreash it's contents (in ms)
            statusline = 1000,       -- The refresh option sets minimum time that lualine tries
            tabline = 1000,          -- to maintain between refresh. It's not guarantied if situation
            winbar = 1000            -- arises that lualine needs to refresh itself before this time
        }                            -- it'll do it.
    },
    sections = {
        lualine_a = { branch, diagnostics },
        lualine_b = { mode },
        lualine_c = { file_name },
        lualine_x = { diff, 'encoding', 'fileformat', filetype },
        lualine_y = { 'progress' },
        lualine_z = { location }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { file_name },
        lualine_x = { location },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
