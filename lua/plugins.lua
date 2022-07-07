local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local packer_present, packer = pcall(require, "packer")
if (not packer_present) then return end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use ({
    "wbthomason/packer.nvim",
    "lewis6991/impatient.nvim", -- speeds up startupt time
    "nathom/filetype.nvim", -- replaces 800+ autocommands of filetype.vim with a single autocommand
    "nvim-lua/plenary.nvim", -- lib of lua functions; used by telescope, gitsigns,..
    "nvim-lua/popup.nvim", -- enables vim like popups
  })

  -- Theming
  use 'folke/tokyonight.nvim' -- colorscheme
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  } -- lualine


  -- cmp plugins
  use({
    "hrsh7th/nvim-cmp", -- The completion plugin
    requires = {
      {
        "L3MON4D3/LuaSnip", --snippet engine
        requires = {
          "rafamadriz/friendly-snippets" -- a bunch of snippets to use
        }
      },
      {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"}, -- lsp completion
      {"hrsh7th/cmp-buffer", after = "nvim-cmp"}, -- buffer completions
      {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}, -- nvim lua api completion
      {"hrsh7th/cmp-path", after = "nvim-cmp"}, -- path completion
      {"hrsh7th/cmp-cmdline", after = "nvim-cmp"},
      {"saadparwaiz1/cmp_luasnip", after = "nvim-cmp"}, -- lua snippet completion
    }
  })

  -- LSP
  use({
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    requires = {
      { "williamboman/nvim-lsp-installer" }
    },
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
