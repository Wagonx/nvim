-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.lsp.set_log_level("debug")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ps1",
  callback = function()
    print("PowerShell file opened - LSP disabled for testing")
  end,
})

vim.filetype.add({
  extension = {
    ps1 = "ps1",
    psm1 = "ps1",
    psd1 = "ps1",
  },
})

-- Increase updatetime to reduce frequent LSP calls
vim.opt.updatetime = 300 -- Default is often 4000, but 300 is a good balance

-- Reduce completion menu update frequency
vim.opt.timeoutlen = 500

-- For PowerShell files specifically
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ps1",
  callback = function()
    -- Disable real-time diagnostics updates
    vim.diagnostic.config({
      update_in_insert = false, -- Don't update diagnostics while typing
      virtual_text = {
        spacing = 2,
        prefix = "●",
      },
    })
  end,
})
