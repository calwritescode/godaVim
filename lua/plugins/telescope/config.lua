local M = {}

M.project_files = function()
    local options = {}
    local ready = pcall(require 'telescope.builtin'.git_files, options)
    if not ready then require 'telescope.builtin'.find_files(options) end
end

return M
