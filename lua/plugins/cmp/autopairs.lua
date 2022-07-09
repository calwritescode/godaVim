--  PluginName: nvim-autopairs
--  Github: github.com/windwp/nvim-autopairs

local cmp_ready, cmp = pcall(require, 'cmp')
if not cmp_ready then return end

local autopairs_ready, autopairs = pcall(require, 'nvim-autopairs')
if not autopairs_ready then return end

local completion = autopairs.completion.cmp

cmp.event:on('confirm_done', completion.on_confirm_done)
