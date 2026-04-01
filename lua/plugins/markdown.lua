return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      local uv = vim.uv or vim.loop
      local root = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim"
      local platform = "linux"

      if vim.fn.has("mac") == 1 or vim.fn.has("macvim") == 1 then
        platform = vim.fn.system("arch"):gsub("%s+", "") == "arm64" and "macos-arm64" or "macos"
      elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        platform = "win"
      end

      local bin = root .. "/app/bin/markdown-preview-" .. platform
      if uv.fs_stat(bin) then
        pcall(uv.fs_chmod, bin, 420)
      end
    end,
  },
}
