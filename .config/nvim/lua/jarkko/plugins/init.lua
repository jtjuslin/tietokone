return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {},
	},
	"folke/neodev.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"tpope/vim-commentary",
	"elkowar/yuck.vim",
	{
		"ggandor/leap.nvim",
		init = function()
			require("leap").create_default_mappings()
		end,
	},
	"tpope/vim-fugitive",
	"airblade/vim-gitgutter",
}
