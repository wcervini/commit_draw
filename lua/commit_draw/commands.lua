local M = {}

function M.register()
	vim.api.nvim_create_user_command("CommitDrawOpen", function()
		vim.cmd("edit .git/COMMIT_DRAW")
	end, {})

	vim.api.nvim_create_user_command("CommitDrawApply", function()
		require("commit_draw.git").apply()
	end, {})

	vim.api.nvim_create_user_command("CommitDrawCommit", function()
		require("commit_draw.git").commit_with_draft()
	end, {})
end

return M
