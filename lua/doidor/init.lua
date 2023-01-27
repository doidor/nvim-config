require("doidor.set")
require("doidor.remap")

local augroup = vim.api.nvim_create_augroup
local doidorGroup = augroup('doidor', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    print("Reloading...")
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = doidorGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd("VimEnter", {
    group = doidorGroup,
    pattern = "*",
    command = "NERDTree | wincmd p"
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25