if vim.g.loaded_remotefiles ~= nil then
	return
end
vim.g.loaded_remotefiles = true

local function parse_scp_filename(fname)
	local name = fname:sub(7)
	local psplit, _ = name:find("/")
	local host = name:sub(1, psplit - 1)
	local file = name:sub(psplit + 1)

	return host, file
end

require("remotefiles").register("scp://*", function(filename)
	local host, file = parse_scp_filename(filename)
	return "ssh " .. host .. " cat " .. file
end, function(filename)
	local host, file = parse_scp_filename(filename)
	return "ssh " .. host .. " tee " .. file .. ">/dev/null"
end)
