local function extend_unique(t, key, values)
  t[key] = t[key] or {}
  for _, value in ipairs(values) do
    if not vim.tbl_contains(t[key], value) then
      table.insert(t[key], value)
    end
  end
end

local function in_deno_project(path)
  return vim.fs.find({ "deno.json", "deno.jsonc", "deno.lock" }, { path = path, upward = true })[1] ~= nil
end

return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "checkstyle",
        "dotenv-linter",
        "google-java-format",
        "htmlhint",
        "jsonlint",
        "markdownlint-cli2",
        "markdown-toc",
        "ruff",
        "shellcheck",
        "sqlfluff",
        "stylelint",
        "xmlformatter",
        "yamlfmt",
        "yamllint",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters = opts.formatters or {}
      opts.formatters.deno_fmt = {
        condition = function(_, ctx)
          return in_deno_project(ctx.filename)
        end,
      }
      opts.formatters_by_ft.javascript = { "deno_fmt", "prettier", stop_after_first = true }
      opts.formatters_by_ft.javascriptreact = { "deno_fmt", "prettier", stop_after_first = true }
      opts.formatters_by_ft.typescript = { "deno_fmt", "prettier", stop_after_first = true }
      opts.formatters_by_ft.typescriptreact = { "deno_fmt", "prettier", stop_after_first = true }
      extend_unique(opts.formatters_by_ft, "java", { "google-java-format" })
      extend_unique(opts.formatters_by_ft, "python", { "ruff_organize_imports", "ruff_fix", "ruff_format" })
      extend_unique(opts.formatters_by_ft, "scala", { "scalafmt" })
      extend_unique(opts.formatters_by_ft, "sbt", { "scalafmt" })
      extend_unique(opts.formatters_by_ft, "sh", { "shfmt" })
      extend_unique(opts.formatters_by_ft, "bash", { "shfmt" })
      opts.formatters_by_ft.yaml = { "yamlfmt" }
      extend_unique(opts.formatters_by_ft, "xml", { "xmlformat" })
      extend_unique(opts.formatters_by_ft, "xsd", { "xmlformat" })
      extend_unique(opts.formatters_by_ft, "xsl", { "xmlformat" })
      extend_unique(opts.formatters_by_ft, "xslt", { "xmlformat" })
      extend_unique(opts.formatters_by_ft, "svg", { "xmlformat" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      extend_unique(opts.linters_by_ft, "java", { "checkstyle" })
      extend_unique(opts.linters_by_ft, "python", { "ruff" })
      extend_unique(opts.linters_by_ft, "html", { "htmlhint" })
      extend_unique(opts.linters_by_ft, "css", { "stylelint" })
      extend_unique(opts.linters_by_ft, "scss", { "stylelint" })
      extend_unique(opts.linters_by_ft, "less", { "stylelint" })
      extend_unique(opts.linters_by_ft, "dotenv", { "dotenv_linter" })
      extend_unique(opts.linters_by_ft, "sh", { "shellcheck" })
      extend_unique(opts.linters_by_ft, "bash", { "shellcheck" })
      extend_unique(opts.linters_by_ft, "yaml", { "yamllint" })
      extend_unique(opts.linters_by_ft, "json", { "jsonlint" })
      extend_unique(opts.linters_by_ft, "markdown", { "markdownlint-cli2" })
      extend_unique(opts.linters_by_ft, "markdown.mdx", { "markdownlint-cli2" })
      extend_unique(opts.linters_by_ft, "sql", { "sqlfluff" })
      extend_unique(opts.linters_by_ft, "mysql", { "sqlfluff" })
      extend_unique(opts.linters_by_ft, "plsql", { "sqlfluff" })
    end,
  },
}
