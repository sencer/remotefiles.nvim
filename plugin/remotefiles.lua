require("remotefiles").register("scp://*", function(match)
	local name = match:sub(7)
	local psplit, _ = name:find("/")
	local host = name:sub(1, psplit - 1)
	local file = name:sub(psplit + 1)
	return "ssh " .. host .. " cat " .. file
end, function(match)
	local name = match:sub(7)
	local psplit, _ = name:find("/")
	local host = name:sub(1, psplit - 1)
	local file = name:sub(psplit + 1)
	return "ssh " .. host .. " tee " .. file .. ">/dev/null"
end)
