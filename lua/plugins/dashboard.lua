return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "hyper",
			disable_move = true,
			shortcut_type = "letter",
			config = {
				header = {
					[[                                             ]],
					[[                                             ]],
					[[                                             ]],
					[[██████╗ ███████╗███████╗██╗  ██╗██╗███╗   ██╗]],
					[[██╔══██╗██╔════╝██╔════╝██║  ██║██║████╗  ██║]],
					[[██████╔╝█████╗  ███████╗███████║██║██╔██╗ ██║]],
					[[██╔══██╗██╔══╝  ╚════██║██╔══██║██║██║╚██╗██║]],
					[[██║  ██║███████╗███████║██║  ██║██║██║ ╚████║]],
					[[╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝]],
					[[                                             ]],
					[[                                             ]],
				},
				footer = {
					[[]],
				},
				disable_move = true,
				shortcut = {
					{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Files",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
					},
					{
						desc = " Apps",
						group = "DiagnosticHint",
						action = "Telescope app",
						key = "a",
					},
					{
						desc = " dotfiles",
						group = "Number",
						action = "Telescope dotfiles",
						key = "d",
					},
				},
			},
			hide = {
				statusline = false,
				tabline = false,
				winbar = false,
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
