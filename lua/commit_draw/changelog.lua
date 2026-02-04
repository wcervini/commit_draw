local M = {}

-- función que git.lua llama
function M.generate(commits, version, changelog_path)
	local lines = {}
	table.insert(lines, "## " .. version)

	for i, c in ipairs(commits) do
		table.insert(lines, "- " .. (c.type or "misc") .. ": " .. (c.description or ""))
	end

	local f = io.open(changelog_path, "a")
	if f then
		for _, l in ipairs(lines) do
			f:write(l .. "\n")
		end
		f:close()
	end

	return lines -- 🔹 Muy importante
end

return M

