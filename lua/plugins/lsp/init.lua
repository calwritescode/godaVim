local installer_ready, installer = pcall(require, "nvim-lsp-installer")
local config_ready, config = pcall(require, "lspconfig")
if (not installer_ready) and (not config_ready) then return end
local keymap = require("plugins.lsp.keymap")

require("plugins.lsp.diagnostics")

local lsp = vim.lsp
local handlers = lsp.handlers

installer.setup {
  ui = {
    check_outdated_servers_on_open = true,
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

handlers["textDocument/hover"] = lsp.with(handlers.hover, {
  border = "rounded",
})

handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, {
  border = "rounded",
})

config.util.default_config = vim.tbl_extend(
  "force",
  config.util.default_config,
  {
    on_attach = keymap.apply,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150
    },
  }
)

local installed_servers = installer.get_installed_servers()
if #installed_servers == 0 then return end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, server in ipairs(installed_servers) do
  local opts = require("plugins.lsp.servers." .. server.name)
  config[server.name].setup(opts)
end
