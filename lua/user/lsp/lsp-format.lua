local status_lsp_format_ok, lsp_format = pcall(require, "lsp-format")
if not status_lsp_format_ok then
    vim.notify("lsp-format not found!")
    return
end

lsp_format.setup{}

local on_attach = function(client)
    lsp_format.on_attach(client)
end

require("lspconfig").gopls.setup { on_attach = on_attach }
