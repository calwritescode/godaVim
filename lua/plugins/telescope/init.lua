--  PluginName: telescope.nvim
--  Github: github.com/nvim-telescope/telescope.nvim
-- :help telescope.setup()

local telescope_ready, telescope = pcall(require, 'telescope')
if not telescope_ready then return end

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    color_devicons = true,
    file_ignore_patterns = {
      "__pycache__/", "__pycache__/*", "build/", "env/", "node_modules/", "node_modules/*", ".git/", ".github/",
      ".vscode/", "%.ipynb", "%.zip", "%.tar",
    },
  },
  mappings = require('plugins.telescope.keymap'),
  pickers = {},
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  }
}

telescope.load_extension('fzf')
