--  PluginName: nvim-autopairs
--  Github: github.com/windwp/nvim-autopairs

local ready, autopairs = pcall(require, 'nvim-autopairs')
if not ready then return end

local M = {}

M.init = function()
  autopairs.setup {
    check_ts = true,
    ts_config = {
      lua = { 'string', 'source' },
      javascript = { 'template_string', 'string' }
    },
    disable_filetype = { 'TelescopePrompt' }, -- get filetypes using :echo &ft
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = [=[[%'%"%)%>%]%)%}%,]]=],
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      highlight = 'Search',
      highlight_grey = 'Comment'
    },
  }
end

return M
