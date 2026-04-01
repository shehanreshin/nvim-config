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
  rosewater = "#DDF7EE",
  flamingo = "#B7E9D7",
  pink = "#9DE3D2",
  mauve = "#8BA7C9",
  red = "#E05B6F",
  maroon = "#B94A5B",
  peach = "#E59B6C",
  yellow = "#D9C86F",
  green = "#4FBE93",
  teal = "#35B8AC",
  sky = "#58C7D9",
  sapphire = "#48AFCF",
  blue = "#6C90D8",
  lavender = "#A8B6E8",
  text = "#EAF7F3",
  subtext1 = "#BFD4CF",
  subtext0 = "#94ABA8",
  overlay2 = "#7A9190",
  overlay1 = "#617776",
  overlay0 = "#4A6161",
  surface2 = "#364C4D",
  surface1 = "#273A3D",
  surface0 = "#1C2C31",
  base = "#101A20",
  mantle = "#0A1217",
  crust = "#050A0D",
}

local function set_dashboard_highlights()
  vim.api.nvim_set_hl(0, "SnacksDashboardNormal", {
    fg = palette.text,
    bg = palette.base,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardBorder", {
    fg = palette.surface1,
    bg = palette.base,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardHeader", {
    fg = palette.green,
    bg = palette.base,
    bold = true,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardTitle", {
    fg = palette.sky,
    bg = palette.base,
    bold = true,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardIcon", {
    fg = palette.teal,
    bg = palette.base,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardKey", {
    fg = palette.green,
    bg = palette.base,
    bold = true,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardDesc", {
    fg = palette.subtext1,
    bg = palette.base,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardFooter", {
    fg = palette.sapphire,
    bg = palette.base,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardFile", {
    fg = palette.text,
    bg = palette.base,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardDir", {
    fg = palette.blue,
    bg = palette.base,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardSpecial", {
    fg = palette.lavender,
    bg = palette.base,
  })
  vim.api.nvim_set_hl(0, "SnacksDashboardQuote", {
    fg = palette.overlay2,
    bg = palette.base,
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
