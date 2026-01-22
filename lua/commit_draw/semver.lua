local M = {}

function M.bump(version, commits)
	local major, minor, patch = version:match("(%d+)%.(%d+)%.(%d+)")
	major, minor, patch = tonumber(major), tonumber(minor), tonumber(patch)

	for _, c in ipairs(commits) do
		if c.breaking then
			return string.format("%d.0.0", major + 1)
		end
	end

	for _, c in ipairs(commits) do
		if c.type == "feat" then
			return string.format("%d.%d.0", major, minor + 1)
		end
	end

	return string.format("%d.%d.%d", major, minor, patch + 1)
end

return M
