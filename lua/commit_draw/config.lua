local M = {}

M.defaults = {
	commit_draw_path = ".git/COMMIT_DRAW",
	changelog_path = "CHANGELOG.md",
	version_file = "VERSION",
	auto_clear = true,
}

function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
