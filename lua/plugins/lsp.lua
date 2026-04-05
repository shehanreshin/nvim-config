local function extend_unique(list, values)
  list = list or {}
  for _, value in ipairs(values) do
    if not vim.tbl_contains(list, value) then
      table.insert(list, value)
    end
  end
  return list
end

local function vue_typescript_plugin_location()
  local root = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
  return (vim.uv or vim.loop).fs_stat(root) and root or nil
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = extend_unique(opts.ensure_installed or {}, { "vue", "css" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Some servers request a client-side diagnostic refresh, but Neovim
      -- does not install a default handler for it.
      vim.lsp.handlers["workspace/diagnostic/refresh"] = function()
        return nil
      end
    end,
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.lua_ls = opts.servers.lua_ls or {
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
      }
      opts.servers.bashls = opts.servers.bashls or {}
      opts.servers.html = opts.servers.html or {}
      opts.servers.cssls = opts.servers.cssls or {}
      opts.servers.sqlls = opts.servers.sqlls or {}
      opts.servers.graphql = opts.servers.graphql or {}
      opts.servers.denols = opts.servers.denols or {}
      opts.servers.htmx = opts.servers.htmx or {}
      opts.servers.emmet_language_server = opts.servers.emmet_language_server or {}
      opts.servers.lemminx = opts.servers.lemminx or {}
      opts.servers.vue_ls = opts.servers.vue_ls or {}
      opts.servers.vtsls = opts.servers.vtsls or {}
      opts.servers.vtsls.filetypes = extend_unique(opts.servers.vtsls.filetypes, { "vue" })

      local plugin_location = vue_typescript_plugin_location()
      if plugin_location then
        opts.servers.vtsls.settings = opts.servers.vtsls.settings or {}
        opts.servers.vtsls.settings.vtsls = opts.servers.vtsls.settings.vtsls or {}
        opts.servers.vtsls.settings.vtsls.tsserver = opts.servers.vtsls.settings.vtsls.tsserver or {}
        opts.servers.vtsls.settings.vtsls.tsserver.globalPlugins =
          opts.servers.vtsls.settings.vtsls.tsserver.globalPlugins or {}

        local plugins = opts.servers.vtsls.settings.vtsls.tsserver.globalPlugins
        local exists = vim.tbl_contains(vim.tbl_map(function(plugin)
          return plugin.name
        end, plugins), "@vue/typescript-plugin")

        if not exists then
          table.insert(plugins, {
            name = "@vue/typescript-plugin",
            location = plugin_location,
            languages = { "vue" },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          })
        end
      end
    end,
  },
}
