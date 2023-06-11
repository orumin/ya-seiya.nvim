local M = {}

M.namespace = vim.api.nvim_create_namespace("Seiya")

---@class SeiyaOptions
---@field auto_enabled boolean
---@field target_groups table
local defaults = {
  auto_enabled = false,
  target_groups = {"ctermbg"},
  hl_groups = {
    "Normal",
    "LineNr",
  --  "Folded",
    "SignColumn",
    "VertSplit",
    "NonText"
  }
}

---@type SeiyaOptions
M.options = {}
---@return SeiyaOptions

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})
end

return M
