return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
	},
	config = function()
		require("telescope").load_extension("fzf")

		local ts_builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", ts_builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fg", ts_builtin.live_grep, { desc = "Grep files" })
	end,
}
