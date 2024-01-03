local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			local clients = {
				["null-ls"] = true,
				["rust-analyzer"] = true,
			}
			return clients[client.name]
		end,
		bufnr = bufnr,
	})
end

return {
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "jsonls", "lua_ls", "pyright" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("neodev").setup({})

			local lspconfig = require("lspconfig")

			local telescope_builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", telescope_builtin.diagnostics)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<leader>D", telescope_builtin.lsp_type_definitions, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", telescope_builtin.lsp_references, opts)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					vim.keymap.set("n", "<leader>fm", function()
						lsp_formatting(ev.buf)
					end, opts)
				end,
			})
			local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
			--updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
			updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

			-- Completion configuration
			vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
			--updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false
			lspconfig.lua_ls.setup({
				capabilities = updated_capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = updated_capabilities,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- lua
					null_ls.builtins.formatting.stylua,
					-- python
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.diagnostics.flake8,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								lsp_formatting(bufnr)
							end,
						})
					end
				end,
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^3",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				tools = {
					hover_actions = {
						auto_focus = true,
					},
				},
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<leader>ca", function()
							vim.cmd.RustLsp("codeAction")
						end, { desc = "Code actions rust", silent = true, buffer = bufnr })
					end,
					settings = {
						["rust-analyzer"] = {
							check = "clippy",
						},
					},
				},
				-- dap = {},
			}
		end,
	},
}
