--  PluginName: treesitter.nvim
--  Github: github.com/nvim-treesitter/nvim-treesitter.nvim

local treesitter_ready, treesitter = pcall(require, 'nvim-treesitter.configs')
if not treesitter_ready then return end

treesitter.setup {
  ensure_installed = { 'comment', 'css', 'fish', 'html', 'javascript', 'jsdoc', 'json', 'json5', 'lua', 'markdown',
    'markdown_inline', 'prisma', 'regex', 'scss', 'tsx', 'typescript', 'yaml' },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
