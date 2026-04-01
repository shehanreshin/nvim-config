return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Some servers request a client-side diagnostic refresh, but Neovim
      -- does not install a default handler for it.
      vim.lsp.handlers["workspace/diagnostic/refresh"] = function()
        return nil
      end
    end,
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
              },
            },
          },
        },
        bashls = {},
        html = {},
        cssls = {},
        sqlls = {},
        graphql = {},
        denols = {},
        htmx = {},
        emmet_language_server = {},
        lemminx = {},
      },
    },
  },
}
