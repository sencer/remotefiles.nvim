local M = {}

vim.api.nvim_create_augroup("RemoteFiles", { clear = true })

M.register = function(pattern, read_cmd_fn, write_cmd_fn)
	vim.api.nvim_create_autocmd("BufReadCmd", {
		group = "RemoteFiles",
		pattern = pattern,
		callback = function(args)
			local handle = io.popen(read_cmd_fn(args.file))
			if handle then
				local result = vim.split(handle:read("a"), "\n", { plain = true })
				handle:close()
				vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.list_slice(result, 1, #result - 1))
				vim.cmd("doautocmd BufReadPost")
				vim.cmd("doautocmd BufEnter")
				vim.cmd("doautocmd FileType")
				if write_cmd_fn == nil then
					vim.cmd("set readonly")
				end
			end
		end,
	})

	if write_cmd_fn ~= nil then
		vim.api.nvim_create_autocmd("BufWriteCmd", {
			group = "RemoteFiles",
			pattern = pattern,
			callback = function(args)
				vim.cmd("silent! w !" .. write_cmd_fn(args.file))
				vim.cmd("set nomodified")
			end,
		})
	end
end

return M
