return {
  {
    "neovim/nvim-lspconfig",
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
