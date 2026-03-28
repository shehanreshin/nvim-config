local old_art = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡇
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⣀⣀⠀⠀⠀⠀⠀⠀⠀⢀⠎⡌
⠀⠀⠀⠀⠀⠀⠀⠀⡿⢀⠁⠀⠈⣉⡸⠶⠤⠤⠄⠒⢁⡼⠁
⠀⠀⠀⠀⠀⠀⠀⢺⣇⠈⠀⠠⠂⠠⡾⠛⡉⠣⡌⠴⠚⠀⠀
⠀⠀⠀⠀⠀⠀⢠⣿⡿⢆⢸⣷⣤⢤⡢⣉⢃⢆⠹⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣠⣿⡿⠁⢈⣾⣿⣿⠈⠙⢻⣋⣃⠀⢃⠀⠀⠀
⠀⠀⠀⠀⣰⣿⡿⠀⠀⢸⣿⣿⣿⠀⢠⣈⣹⠟⡷⠬⣢⠀⠀
⠀⠀⠀⣴⣿⠏⠀⠀⠀⢸⣿⣿⣿⠉⠉⢈⣀⣟⢳⠄⡧⠀⠀
⠀⠀⣰⣿⠟⠀⠀⠀⠀⢸⣿⣿⣿⡠⠄⠚⠋⢽⣚⡆⡳⠄⠀
⢴⣾⣿⣿⣶⣶⣶⣶⣶⣾⣿⣿⣿⣶⣶⣶⣶⣿⣥⡵⠼⠂⠀
⠀⠙⣿⢟⡋⠉⠉⠈⠀⢹⣿⣿⣿⠁⠈⠉⠉⢻⡏⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⠟⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]

local title_art = [[
 _______  _______  _______          _________ _       
(  ____ )(  ____ \/ ___   )|\     /|\__   __/( (    /|
| (    )|| (    \/\/   )  |( \   / )   ) (   |  \  ( |
| (____)|| (__        /   ) \ (_) /    | |   |   \ | |
|     __)|  __)      /   /   ) _ (     | |   | (\ \) |
| (\ (   | (        /   /   / ( ) \    | |   | | \   |
| ) \ \__| (____/\ /   (_/\( /   \ )___) (___| )  \  |
|/   \__/(_______/(_______/|/     \|\_______/|/    )_)
]]

local function split_lines(block)
  return vim.split(block:gsub("\n$", ""), "\n", { plain = true })
end

local function max_width(lines)
  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, vim.api.nvim_strwidth(line))
  end
  return width
end

local function pad_line(line, width)
  return line .. string.rep(" ", math.max(0, width - vim.api.nvim_strwidth(line)))
end

local function normalize(lines, width, height, valign)
  local padded = {}
  for i, line in ipairs(lines) do
    padded[i] = pad_line(line, width)
  end
  local missing = math.max(0, height - #padded)
  local top = valign == "center" and math.floor(missing / 2) or 0
  local bottom = missing - top
  local blank = string.rep(" ", width)
  for _ = 1, top do
    table.insert(padded, 1, blank)
  end
  for _ = 1, bottom do
    table.insert(padded, blank)
  end
  return padded
end

local function merge_blocks(left_block, right_block, gap)
  local left_lines = split_lines(left_block)
  local right_lines = split_lines(right_block)
  local left_width = max_width(left_lines)
  local right_width = max_width(right_lines)
  local height = math.max(#left_lines, #right_lines)

  left_lines = normalize(left_lines, left_width, height, "top")
  right_lines = normalize(right_lines, right_width, height, "center")

  local merged = {}
  local spacer = string.rep(" ", gap)
  for i = 1, height do
    merged[i] = left_lines[i] .. spacer .. right_lines[i]
  end
  return table.concat(merged, "\n")
end

local right_header = merge_blocks(old_art, title_art, 2)
local right_header_width = max_width(split_lines(right_header))
local quote = "If this eye cannot see a thing, then it does not exist"

local palette = {
  base = "#e0e0d4",
  ink = "#0a0a0a",
  shadow = "#282932",
  green = "#2e8c6a",
  deep_green = "#1a5d4d",
}

local function set_dashboard_highlights()
  vim.api.nvim_set_hl(0, "SnacksDashboardNormal", {
    fg = palette.base,
    bg = palette.shadow,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardBorder", {
    fg = palette.shadow,
    bg = palette.shadow,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardHeader", {
    fg = palette.green,
    bg = palette.shadow,
    bold = true,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardTitle", {
    fg = palette.base,
    bg = palette.shadow,
    bold = true,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardIcon", {
    fg = palette.green,
    bg = palette.shadow,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardKey", {
    fg = palette.green,
    bg = palette.shadow,
    bold = true,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardDesc", {
    fg = palette.base,
    bg = palette.shadow,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardFooter", {
    fg = palette.deep_green,
    bg = palette.shadow,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardFile", {
    fg = palette.base,
    bg = palette.shadow,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardDir", {
    fg = palette.deep_green,
    bg = palette.shadow,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardSpecial", {
    fg = palette.green,
    bg = palette.shadow,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardQuote", {
    fg = palette.deep_green,
    bg = palette.shadow,
    italic = true,
  })
end

return {
  {
    "folke/snacks.nvim",
    init = function()
      set_dashboard_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("ulquiorra_dashboard", { clear = true }),
        callback = function()
          set_dashboard_highlights()
        end,
      })
    end,
    opts = function(_, opts)
      opts.dashboard = opts.dashboard or {}
      opts.dashboard.preset = opts.dashboard.preset or {}
      opts.dashboard.preset.keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      }
      opts.dashboard.width = right_header_width
      opts.dashboard.sections = {
        { header = right_header, padding = { 2, 1 }, align = "left" },
        { section = "keys", gap = 1, align = "left" },
        { text = { { quote, hl = "SnacksDashboardQuote" } }, align = "center", padding = { 1, 2 } },
      }
    end,
  },
}
