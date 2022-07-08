local M = {}

local lsp = vim.lsp

M.apply = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local options = { noremap = true, silent = true }

  buf_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', options)
  buf_set_keymap('n', 'gq', '<cmd>lua vim.diagnostic.set_loclist({})<CR>', options)
  buf_set_keymap('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', options)
  buf_set_keymap('n', 'gb', '<cmd>lua vim.diagnostic.goto_prev()<CR>', options)

  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', options)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', options)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', options)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
  buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', options)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', options)

end

return M
