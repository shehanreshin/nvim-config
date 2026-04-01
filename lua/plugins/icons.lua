local palette = {
  white = "#D6E7E2",
  cyan = "#58C7D9",
  teal = "#35B8AC",
  green = "#4FBE93",
  blue = "#63B7D8",
  violet = "#8FA8D6",
  gold = "#CDBE74",
  red = "#D86478",
  gray = "#8FA3A0",
  dark = "#4A6161",
  glow = "#7CE3C8",
}

local function set_icon_highlights()
  vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = palette.cyan, bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniIconsBlue", { fg = palette.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniIconsCyan", { fg = palette.teal, bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniIconsGreen", { fg = palette.green, bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniIconsGrey", { fg = palette.white, bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniIconsOrange", { fg = palette.gold, bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniIconsPurple", { fg = palette.violet, bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniIconsRed", { fg = palette.red, bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniIconsYellow", { fg = palette.glow, bg = "NONE" })

  vim.api.nvim_set_hl(0, "UlquiorraIconNeutral", { fg = palette.gray, bg = "NONE" })
  vim.api.nvim_set_hl(0, "UlquiorraIconDark", { fg = palette.dark, bg = "NONE" })
end

return {
  {
    "nvim-mini/mini.icons",
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end

      set_icon_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("ulquiorra_icons", { clear = true }),
        callback = function()
          set_icon_highlights()
        end,
      })
    end,
  },
}
