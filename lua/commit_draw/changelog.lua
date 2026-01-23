local M = {}

-- función que git.lua llama
function M.generate(commits, version, changelog_path)
	local lines = {}
	table.insert(lines, "## " .. version)
	-- por ahora solo imprimimos para pruebas

	for _, c in ipairs(commits) do
		table.insert(lines, "- " .. (c.type or "misc") .. ": " .. (c.description or ""))
	end

	local f, err = io.open(changelog_path, "a")
	if not f then
		print("Error al abrir el archivo de changelog: " .. (err or "error desconocido"))
		return lines
	end
	for _, l in ipairs(lines) do
		f:write(l .. "\n")
	end
	f:close()

	return lines -- 🔹 Muy importante
end

return M

