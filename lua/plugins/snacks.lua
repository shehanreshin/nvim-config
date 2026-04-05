return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.picker = opts.picker or {}
      opts.picker.win = opts.picker.win or {}
      opts.picker.win.input = opts.picker.win.input or {}
      opts.picker.win.input.keys = opts.picker.win.input.keys or {}
      opts.picker.win.list = opts.picker.win.list or {}
      opts.picker.win.list.keys = opts.picker.win.list.keys or {}

      opts.picker.win.input.keys["<Up>"] = false
      opts.picker.win.input.keys["<Down>"] = false
      opts.picker.win.input.keys["<Left>"] = false
      opts.picker.win.input.keys["<Right>"] = false

      opts.picker.win.list.keys["<Up>"] = false
      opts.picker.win.list.keys["<Down>"] = false
      opts.picker.win.list.keys["<Left>"] = false
      opts.picker.win.list.keys["<Right>"] = false
    end,
  },
}
