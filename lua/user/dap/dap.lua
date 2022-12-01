local status_dap_ok, dap = pcall(require, "dap")
if not status_dap_ok then
    vim.notify("dap not found!")
    return
end

local dap_breakpoint = {
    error = {
        text = "🛑",
        texthl = "LspDiagnosticsSignError",
        linehl = "",
        numhl = "",
    },
    rejected = {
        text = "",
        texthl = "LspDiagnosticsSignHint",
        linehl = "",
        numhl = "",
    },
    stopped = {
        text = "⭐️",
        texthl = "LspDiagnosticsSignInformation",
        linehl = "DiagnosticUnderlineInfo",
        numhl = "LspDiagnosticsSignInformation",
    },
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

-- TODO: wait dap-ui for fixing temrinal layout
-- the "30" of "30vsplit: doesn't work
dap.defaults.fallback.terminal_win_cmd = '30vsplit new' -- this will be overrided by dapui
dap.set_log_level("DEBUG")

