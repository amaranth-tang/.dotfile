_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_chunks',
    },
    modpaths = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_modpaths',
    }
}

local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
    vim.notify("impatient not found!")
    return
end

impatient.enable_profile()
