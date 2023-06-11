local config = require("seiya.config")

local Seiya = {}

function Seiya.clear_bg(hl)
  local hl_opts = {}
  for _, v in ipairs(config.options.target_groups) do
    hl_opts = vim.tbl_extend("force", hl_opts, { [v] = "NONE" })
  end
  vim.api.nvim_set_hl(0, hl, hl_opts)
end

function Seiya.clear_bg_all()
  for _, v in ipairs(config.options.hl_groups) do
    Seiya.clear_bg(v)
  end
end

function Seiya.clear_auto()
  Seiya.clear_bg_all()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = "seiya_auto",
    pattern = "*",
    callback = function ()
      Seiya.clear_bg_all()
    end
  })
end

function Seiya.disable()
  vim.api.nvim_del_augroup_by_name("seiya_auto")
  local colors_name = vim.g.colors_name
  vim.notify("colors_name: " .. colors_name,
    vim.log.levels.INFO, {title = "[seiya]"})
  if colors_name ~= nil and colors_name ~= "" then
    vim.cmd.colorscheme(colors_name)
  end
end

function Seiya.setup(opts)
  config.setup(opts)

  vim.api.nvim_create_augroup("seiya_auto", {clear = true})
  if config.options.auto_enabled then
    vim.api.nvim_create_autocmd("VimEnter", {
      group = "seiya_auto",
      pattern = "*",
      callback = function ()
        Seiya.clear_auto()
      end
    })
  end

  vim.api.nvim_create_user_command("SeiyaEnable", Seiya.clear_auto, {nargs = 0})
  vim.api.nvim_create_user_command("SeiyaDisable", Seiya.disable, {nargs = 0})
end

return Seiya

-- vim:set et:set ts=2:set sw=2:
