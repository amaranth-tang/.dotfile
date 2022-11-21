local status_hop_ok, hop = pcall(require, "hop")
if not status_hop_ok then
    vim.notify("hop not found!")
    return
end

hop.setup()
