local status_ok, gruvbox = pcall(require, "gruvbox")
if not status_ok then
    vim.notify("gruvbox theme not found!")
    return
end

vim.o.background = "dark" -- or "light" for light mode

