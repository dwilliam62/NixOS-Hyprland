require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- Map <leader>nv to start Nvdash
map("n", "<leader>nv", ":Nvdash<CR>", { desc = "Start Nvdash" })

map("n", "<C-t>", function()
    require("nvchad.themes").open()
end,{})



-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
