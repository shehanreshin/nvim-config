return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	opts = {
		max_time = 1000,
		max_count = 5,
		hint = true,
		disabled_keys = {
			["<Up>"] = { "", "c", "t", "l" },
			["<Down>"] = { "", "c", "t", "l" },
			["<Left>"] = { "", "c", "t", "l" },
			["<Right>"] = { "", "c", "t", "l" },
		},
	},
}
