if vim.g.loaded_commit_draw then
	return
end
vim.g.loaded_commit_draw = true

require("commit_draw").setup()

