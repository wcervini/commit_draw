local M = {}

local pattern = "^(%w+)(%!?)%((.-)%)%: (.+)$"

function M.parse(lines)
	local commits = {}

	for _, line in ipairs(lines) do
		local type, breaking, scope, message = line:match(pattern)

		if type then
			table.insert(commits, {
				type = type,
				scope = scope,
				message = message,
				breaking = breaking == "!",
			})
		end
	end

	return commits
end

return M
