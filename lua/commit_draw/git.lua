local M = {}

local config = require("commit_draw.config")
local parser = require("commit_draw.parser")
local semver = require("commit_draw.semver")
local changelog = require("commit_draw.changelog")

local function read_file(path)
	local lines = {}
	local f = io.open(path, "r")
	if not f then
		return lines
	end
	for line in f:lines() do
		table.insert(lines, line)
	end
	f:close()
	return lines
end

local function write_file(path, lines)
	local f = io.open(path, "w")
	for _, line in ipairs(lines) do
		f:write(line .. "\n")
	end
	f:close()
end

function M.apply()
	local opts = config.options

	-- 1. Leer COMMIT_DRAW
	local lines = read_file(opts.commit_draw_path)
	if #lines == 0 then
		vim.notify("COMMIT_DRAW está vacío", vim.log.levels.WARN)
		return
	end

	-- 2. Parsear commits
	local commits = parser.parse(lines)
	if #commits == 0 then
		vim.notify("No hay commits válidos", vim.log.levels.ERROR)
		return
	end

	-- 3. Leer versión actual
	local version_lines = read_file(opts.version_file)
	local current_version = version_lines[1] or "0.0.0"

	-- 4. Calcular nueva versión
	local new_version = semver.bump(current_version, commits)

	-- 5. Generar changelog
	local new_changelog = changelog.generate(commits, new_version, opts.changelog_path)

	-- 6. Prepend CHANGELOG.md
	local existing = read_file(opts.changelog_path)
	local final = vim.list_extend(new_changelog, existing)
	write_file(opts.changelog_path, final)

	-- 7. Guardar versión
	write_file(opts.version_file, { new_version })

	-- 8. Limpiar COMMIT_DRAW
	if opts.auto_clear then
		write_file(opts.commit_draw_path, {})
	end

	vim.notify("Release " .. new_version .. " generado", vim.log.levels.INFO)
end

--- Nueva función: Commit real usando COMMIT_DRAW
function M.commit_with_draft()
    local opts = config.options
    local draft_path = opts and opts.commit_draw_path or ".git/COMMIT_DRAW"
    -- Ejecuta el commit usando el contenido del draft
    local result = vim.fn.system({ 'git', 'commit', '-F', draft_path })
    local code = vim.v.shell_error
    if code == 0 then
        vim.notify("Commit realizado correctamente:\n" .. result, vim.log.levels.INFO)
    else
        vim.notify("Error al realizar commit:\n" .. result, vim.log.levels.ERROR)
    end
end

return M
