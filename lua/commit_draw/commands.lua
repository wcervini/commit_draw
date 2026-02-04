local M = {}

function M.register()
	vim.api.nvim_create_user_command("CommitDrawOpen", function()
		local opts = require("commit_draw.config").options
		vim.cmd("edit " .. opts.commit_draw_path)
	end, {})

	vim.api.nvim_create_user_command("CommitDrawApply", function()
		require("commit_draw.git").apply()
	end, {})

	vim.api.nvim_create_user_command("CommitDrawCommit", function()
		require("commit_draw.git").commit_with_draft()
	end, {})

	vim.api.nvim_create_user_command("CommitDrawAdd", function()
		require("commit_draw.git").add_interactive()
	end, {})
end

return M
