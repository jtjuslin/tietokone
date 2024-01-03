return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"luckasRanarison/tree-sitter-hypr",
	},
	init = function()
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		---@diagnostic disable-next-line: inject-field
		parser_config.hypr = {
			install_info = {
				url = "https://github.com/luckasRanarison/tree-sitter-hypr",
				files = { "src/parser.c" },
				branch = "master",
			},
			filetype = "hypr",
		}
	end,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "hypr", "lua", "markdown", "rust", "toml" },
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
			auto_install = true,
		})
	end,
}
