local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
    vim.notify("autopairs not found!")
    return
end

autopairs.setup {
    -- use treesitter to check for a pair
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    },
    disable_filetype = { "TelescopePrompt" , "vim" },
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = [=[[%'%"%)%>%]%)%}%,]]=],
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      highlight = 'Search',
      highlight_grey='Comment'
    },
}

-- If you want insert `(` after select function or method item
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    vim.notify("cmp not found!")
    return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { 
    filetypes = { 
        tex = false
    }
}
)
