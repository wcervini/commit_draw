local M = {}

function M.register()
	vim.api.nvim_create_user_command("CommitDrawOpen", function()
		vim.cmd("edit .git/COMMIT_DRAW")
	end, {})

	vim.api.nvim_create_user_command("CommitDrawApply", function()
		require("commit_draw.git").apply()
	end, {})
end

return M
