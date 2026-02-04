local M = {}

function M.setup(opts)
	require("commit_draw.config").setup(opts)
	require("commit_draw.commands").register()
end

return M
