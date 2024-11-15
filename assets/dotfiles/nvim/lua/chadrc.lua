-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

-- Your existing chadrc.lua configurations

-- Add the ui section

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "chadracula",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}M.ui = {
    statusline = {
        a = { enabled = true },
        b = { enabled = true },
        c = { enabled = true },
        d = { enabled = true },
        f = { enabled = true },
        l = { enabled = true },
        m = { enabled = true },
        p = { enabled = true },
        r = { enabled = true },
        s = { enabled = true },
        t = { enabled = true },
        w = { enabled = true },
    },
}




return M
