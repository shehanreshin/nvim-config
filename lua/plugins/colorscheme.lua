local ulquiorra = {
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

return {
  {
    "catppuccin/nvim",
    opts = {
      flavour = "mocha",
      color_overrides = {
        mocha = ulquiorra,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
