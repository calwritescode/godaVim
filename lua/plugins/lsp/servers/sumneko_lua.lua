return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim', 'use', 'require' },
			},
			workspace = {
				library = {
					library = vim.api.nvim_get_runtime_file('', true),
				},
			},
			telemetry = { enable = false },
		},
	},
}
