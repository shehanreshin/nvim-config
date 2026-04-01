local fallback_palette = {
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

local palette_order = {
  "rosewater",
  "flamingo",
  "pink",
  "mauve",
  "red",
  "maroon",
  "peach",
  "yellow",
  "green",
  "teal",
  "sky",
  "sapphire",
  "blue",
  "lavender",
  "text",
  "subtext1",
  "subtext0",
  "overlay2",
  "overlay1",
  "overlay0",
  "surface2",
  "surface1",
  "surface0",
  "base",
  "mantle",
  "crust",
}

local function get_palette()
  local ok, catppuccin = pcall(require, "catppuccin.palettes")
  if not ok then
    return fallback_palette
  end
  local ok_palette, palette = pcall(catppuccin.get_palette, "mocha")
  return ok_palette and palette or fallback_palette
end

local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

local function text_for_bg(hex)
  local r, g, b = hex_to_rgb(hex)
  local luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255
  return luminance > 0.55 and "#0A0A0A" or "#EAF7F3"
end

local function set_swatch_highlight(name, color)
  vim.api.nvim_set_hl(0, "UlquiorraPreview" .. name, {
    fg = text_for_bg(color),
    bg = color,
    bold = true,
  })
end

local function add_segments(line, segments, lines, extmarks)
  local row = #lines
  local col = 0
  lines[#lines + 1] = line
  for _, segment in ipairs(segments) do
    local text, hl = segment[1], segment[2]
    if hl then
      extmarks[#extmarks + 1] = {
        row = row,
        col = col,
        end_col = col + vim.api.nvim_strwidth(text),
        hl = hl,
      }
    end
    col = col + vim.api.nvim_strwidth(text)
  end
end

local palette = get_palette()
for _, name in ipairs(palette_order) do
  set_swatch_highlight(name, palette[name])
end

local cell_width = 28
local lines = {}
local extmarks = {}

add_segments("Ulquiorra Theme Preview", {
  { "Ulquiorra Theme Preview", "Title" },
}, lines, extmarks)
add_segments("Palette, diagnostics, git, UI, and syntax samples from the current theme.", {
  { "Palette, diagnostics, git, UI, and syntax samples from the current theme.", "Comment" },
}, lines, extmarks)
lines[#lines + 1] = ""
add_segments("Palette Swatches", {
  { "Palette Swatches", "Special" },
}, lines, extmarks)

for i = 1, #palette_order, 2 do
  local left = palette_order[i]
  local right = palette_order[i + 1]

  local left_text = string.format(" %-10s %s ", left, palette[left])
  local segments = {
    { left_text, "UlquiorraPreview" .. left },
  }

  local line = left_text
  if right then
    local right_text = string.format("  %-10s %s ", right, palette[right])
    local padding = math.max(0, cell_width - vim.api.nvim_strwidth(left_text))
    line = left_text .. string.rep(" ", padding) .. right_text
    segments[#segments + 1] = { string.rep(" ", padding), nil }
    segments[#segments + 1] = { right_text, "UlquiorraPreview" .. right }
  end

  add_segments(line, segments, lines, extmarks)
end

lines[#lines + 1] = ""
add_segments("Semantic Samples", {
  { "Semantic Samples", "Special" },
}, lines, extmarks)

add_segments("Diagnostics: ERROR  WARN  INFO  HINT  OK", {
  { "Diagnostics: ", "Identifier" },
  { "ERROR", "DiagnosticError" },
  { "  ", nil },
  { "WARN", "DiagnosticWarn" },
  { "  ", nil },
  { "INFO", "DiagnosticInfo" },
  { "  ", nil },
  { "HINT", "DiagnosticHint" },
  { "  ", nil },
  { "OK", "DiagnosticOk" },
}, lines, extmarks)

add_segments("Git:         ADDED  CHANGED  REMOVED", {
  { "Git:         ", "Identifier" },
  { "ADDED", "DiffAdd" },
  { "  ", nil },
  { "CHANGED", "DiffChange" },
  { "  ", nil },
  { "REMOVED", "DiffDelete" },
}, lines, extmarks)

add_segments("Search/UI:   SEARCH  VISUAL  CURSORLINE  MATCH", {
  { "Search/UI:   ", "Identifier" },
  { "SEARCH", "Search" },
  { "  ", nil },
  { "VISUAL", "Visual" },
  { "  ", nil },
  { "CURSORLINE", "CursorLine" },
  { "  ", nil },
  { "MATCH", "MatchParen" },
}, lines, extmarks)

add_segments("Syntax:      keyword  function  string  number  type  comment  constant", {
  { "Syntax:      ", "Identifier" },
  { "keyword", "Keyword" },
  { "  ", nil },
  { "function", "Function" },
  { "  ", nil },
  { "string", "String" },
  { "  ", nil },
  { "number", "Number" },
  { "  ", nil },
  { "type", "Type" },
  { "  ", nil },
  { "comment", "Comment" },
  { "  ", nil },
  { "constant", "Constant" },
}, lines, extmarks)

add_segments("Treesitter:  @keyword  @function  @string  @type  @property", {
  { "Treesitter:  ", "Identifier" },
  { "@keyword", "@keyword" },
  { "  ", nil },
  { "@function", "@function" },
  { "  ", nil },
  { "@string", "@string" },
  { "  ", nil },
  { "@type", "@type" },
  { "  ", nil },
  { "@property", "@property" },
}, lines, extmarks)

lines[#lines + 1] = ""
add_segments("Press q to close this preview buffer.", {
  { "Press q to close this preview buffer.", "Comment" },
}, lines, extmarks)

local buf = vim.api.nvim_create_buf(false, true)
vim.bo[buf].buftype = "nofile"
vim.bo[buf].bufhidden = "wipe"
vim.bo[buf].swapfile = false
vim.bo[buf].modifiable = true
vim.bo[buf].filetype = "ulquiorra_preview"
vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
vim.bo[buf].modifiable = false

for _, mark in ipairs(extmarks) do
  vim.api.nvim_buf_set_extmark(buf, vim.api.nvim_create_namespace("ulquiorra_preview"), mark.row, mark.col, {
    end_col = mark.end_col,
    hl_group = mark.hl,
  })
end

vim.api.nvim_set_current_buf(buf)
vim.keymap.set("n", "q", "<cmd>bd!<cr>", { buffer = buf, silent = true, desc = "Close preview" })
