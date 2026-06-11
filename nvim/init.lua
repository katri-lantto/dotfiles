-- leader jey
vim.g.mapleader = " "

-- relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- allow undo after re-open
vim.opt.undofile = true

-- window-splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- plugins
require("config.lazy")


