return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
		dependencies = {
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local lspconfig = require("lspconfig")
			local mason = require("mason-lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			mason.setup({
				ensure_installed = { "lua_ls", "tsserver", "jdtls", "html", "tailwindcss", "cssls" },
			})
			mason.setup_handlers({
				function(server_name)
					if server_name ~= "jdtls" then
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end
				end,
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"java-debug-adapter",
					"java-test",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local servers = { "lua_ls", "tsserver", "html", "tailwindcss", "cssls" }
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					capabilities = capabilities,
				})
			end
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
