-- Intentionally broken Lua file for testing diagnostic colors.
-- Open this file in Neovim to inspect syntax error highlights, signs, and virtual text.

local palette = {
  green = "#4FBE93"
  teal = "#35B8AC",
  sky = "#58C7D9",
}

local function broken_preview()
  print("This line is fine")
end)

if palette.green then
  print("Missing `end` below should trigger another syntax error")
