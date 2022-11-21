-- https://github.com/kyazdani42/nvim-tree.lua
--
-- DEFAULT MAPPINGS                                     *nvim-tree-default-mappings*
-- 
-- <CR>            edit                open a file or folder; root will cd to the above directory
-- o
-- <2-LeftMouse>
-- <C-e>           edit_in_place       edit the file in place, effectively replacing the tree explorer
-- O               edit_no_picker      same as (edit) with no window picker
-- <C-]>           cd                  cd in the directory under the cursor
-- <2-RightMouse>
-- <C-v>           vsplit              open the file in a vertical split
-- <C-x>           split               open the file in a horizontal split
-- <C-t>           tabnew              open the file in a new tab
-- <               prev_sibling        navigate to the previous sibling of current file/directory
-- >               next_sibling        navigate to the next sibling of current file/directory
-- P               parent_node         move cursor to the parent directory
-- <BS>            close_node          close current opened directory or parent
-- <Tab>           preview             open the file as a preview (keeps the cursor in the tree)
-- K               first_sibling       navigate to the first sibling of current file/directory
-- J               last_sibling        navigate to the last sibling of current file/directory
-- I               toggle_git_ignored  toggle visibility of files/folders hidden via |git.ignore| option
-- H               toggle_dotfiles     toggle visibility of dotfiles via |filters.dotfiles| option
-- U               toggle_custom       toggle visibility of files/folders hidden via |filters.custom| option
-- R               refresh             refresh the tree
-- a               create              add a file; leaving a trailing / will add a directory
-- d               remove              delete a file (will prompt for confirmation)
-- D               trash               trash a file via |trash| option
-- r               rename              rename a file
-- <C-r>           full_rename         rename a file and omit the filename on input
-- x               cut                 add/remove file/directory to cut clipboard
-- c               copy                add/remove file/directory to copy clipboard
-- p               paste               paste from clipboard; cut clipboard has precedence over copy; will prompt for confirmation
-- y               copy_name           copy name to system clipboard
-- Y               copy_path           copy relative path to system clipboard
-- gy              copy_absolute_path  copy absolute path to system clipboard
-- [e              prev_diag_item      go to next diagnostic item
-- [c              prev_git_item       go to next git item
-- ]e              next_diag_item      go to prev diagnostic item
-- ]c              next_git_item       go to prev git item
-- -               dir_up              navigate up to the parent directory of the current file/directory
-- s               system_open         open a file with default system application or a folder with default file manager, using |system_open| option
-- f               live_filter         live filter nodes dynamically based on regex matching.
-- F               clear_live_filter   clear live filter
-- q               close               close tree window
-- W               collapse_all        collapse the whole tree
-- E               expand_all          expand the whole tree, stopping after expanding |actions.expand_all.max_folder_discovery| folders; this might hang neovim for a while if running on a big folder
-- S               search_node         prompt the user to enter a path and then expands the tree to match the path
-- .               run_file_command    enter vim command mode with the file the cursor is on
-- <C-k>           toggle_file_info    toggle a popup with file infos about the file under the cursor
-- g?              toggle_help         toggle help
-- m               toggle_mark         Toggle node in bookmarks
-- bmv             bulk_move           Move all bookmarked nodes into specified location
-- each of these are documented in `:help nvim-tree-setup`

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    vim.notify("nvim-tree not found!")
    return
end

nvim_tree.setup{
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  ignore_buf_on_tab_change = {},
  sort_by = "name",
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  on_attach = "disable",
  remove_keymaps = false,
  select_prompts = false,
  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_width = 2,
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    symlink_destination = true,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_root = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    debounce_delay = 50,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
      },
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
  notify = {
    threshold = vim.log.levels.INFO,
  },
}

--
-- with relative path
require "nvim-tree.events".on_file_created(function(file) vim.cmd("edit " .. file.fname) end)
-- with absolute path
-- require"nvim-tree.events".on_file_created(function(file) vim.cmd("edit "..vim.fn.fnamemodify(file.fname, ":p")) end)

-- auto close feature
-- vim.cmd(
--   [[
--       autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
-- ]]
-- )
