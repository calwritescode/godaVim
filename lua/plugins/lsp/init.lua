local installer_ready, installer = pcall(require, 'nvim-lsp-installer')
local config_ready, lspconfig = pcall(require, 'lspconfig')
if (not installer_ready) and (not config_ready) then return end
local keymap = require('plugins.lsp.keymap')

require('plugins.lsp.diagnostics')

installer.setup {
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function on_attach(client, bufnr)
  keymap.apply(bufnr)
end

local flags = {
  debounce_text_changes = 150,
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

lspconfig.util.default_config = vim.tbl_extend(
  'force',
  lspconfig.util.default_config,
  {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
  }
)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, server in ipairs(installer.get_installed_servers()) do
  local opts = require('plugins.lsp.serve.' .. server.name)
  lspconfig[server.name].setup(opts)
end
