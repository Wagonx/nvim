-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.lsp.set_log_level("debug")

vim.filetype.add({
  extension = {
    ps1 = "ps1",
    psm1 = "ps1",
    psd1 = "ps1",
  },
})


