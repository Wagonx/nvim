return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "powershell_es" }
      })

      local lspconfig = require("lspconfig")
      
      -- PowerShell LSP configuration
    lspconfig.powershell_es.setup({
    bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {
        cmd = { "pwsh", "-NoLogo", "-NoProfile", "-Command", "..." }, -- Use pwsh instead of powershell
        powershell = {
        -- Reduce analysis features that cause lag
        scriptAnalysis = {
            enable = true,
            settingsPath = "", -- Disable custom PSScriptAnalyzer rules
        },
        -- Disable code lens (can be performance-heavy)
        codeLens = {
            enable = false,
        },
        -- Reduce completion trigger characters
        completion = {
            completionInvocationTimeout = 2000, -- 2 seconds instead of default 5
        },
        -- Disable workspace symbol search for better performance
        workspaceSymbols = {
            enable = false,
        },
        },
    },
    on_attach = function(client, bufnr)
        -- Disable semantic tokens if they cause lag
        client.server_capabilities.semanticTokensProvider = nil
        
        -- Your keymaps here
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    end,
    })
    end,
  }
}