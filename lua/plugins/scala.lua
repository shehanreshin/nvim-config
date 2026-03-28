local function scalafix_root(buf)
  local path = vim.api.nvim_buf_get_name(buf or 0)
  local config = vim.fs.find(".scalafix.conf", { path = path, upward = true })[1]
  if not config then
    return nil
  end
  return vim.fs.dirname(config)
end

local function run_scalafix(args)
  local root = scalafix_root(0)
  if not root then
    LazyVim.warn("No `.scalafix.conf` found in this project.", { title = "Scalafix" })
    return
  end
  if vim.fn.executable("sbt") ~= 1 then
    LazyVim.warn("`sbt` is not available in PATH.", { title = "Scalafix" })
    return
  end
  Snacks.terminal({ "sbt", args }, { cwd = root })
end

return {
  {
    "scalameta/nvim-metals",
    optional = true,
    keys = {
      {
        "<leader>mF",
        function()
          run_scalafix("scalafixAll --check")
        end,
        desc = "Scalafix Check",
        ft = { "scala", "sbt", "java" },
      },
      {
        "<leader>mf",
        function()
          run_scalafix("scalafixAll")
        end,
        desc = "Scalafix Apply",
        ft = { "scala", "sbt", "java" },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "java" },
        callback = function(event)
          vim.api.nvim_buf_create_user_command(event.buf, "ScalafixCheck", function()
            run_scalafix("scalafixAll --check")
          end, {})
          vim.api.nvim_buf_create_user_command(event.buf, "ScalafixApply", function()
            run_scalafix("scalafixAll")
          end, {})

          local ok, wk = pcall(require, "which-key")
          if ok then
            wk.add({
              buffer = event.buf,
              mode = "n",
              { "<leader>m", group = "metals" },
            })
          end
        end,
      })
    end,
  },
}
