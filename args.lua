local map = vim.keymap.set

-- New args
map("n", "<space>an", ":args ", { desc = "New args" })

-- List args
map("n", "<space>al", "<cmd>args<cr>", { desc = "List args" })

-- Prev/next args
map("n", "<Up>", "<cmd>exe 'N'<bar>args<cr><esc>", { desc = "Prev arg" })
map("n", "<Down>", "<cmd>exe 'n'<bar>args<cr><esc>", { desc = "Next arg" })

-- Go to n arg, e.g. `2ga` to go to 2nd arg
map("n", "ga", function()
	return ":<C-U>" .. (vim.v.count > 0 and vim.v.count or "") .. "argu<bar>args<cr><esc>zz"
end, { desc = "Go to nth arg", expr = true, silent = true })

-- Add/Delete
map("n", "<space>aa", "<cmd>$arge %<bar>argded<bar>args<cr>", { desc = "Add cur file to arglist" })

map("n", "<space>ad", function()
	local count = vim.v.count
	local argd = count > 0 and count .. "," .. count .. "argd" or "argd %"
	return ":<C-U>" .. argd .. "<bar>args<cr>"
end, { desc = "Delete current or nth file from arglist", expr = true, silent = true })

-- Replace arglist with files in visible windows
map("n", "<space>ar", function()
	vim.cmd("%argd")
	local wins = vim.api.nvim_list_wins()
	for _, w in ipairs(wins) do
		local b = vim.api.nvim_win_get_buf(w)
		vim.cmd.argadd(vim.fn.expand(string.format("#%d", b)))
	end
	vim.cmd.argded()
end, { desc = "Replace arglist" })

-- Set results of fd as args
map("n", "<space>af", function()
	vim.ui.input({}, function(c)
		if c and c ~= "" then
			vim.cmd("% argd")
			vim.cmd.arga(table.concat(vim.fn.systemlist({ "fd", ("'%s'").format(c) }), " "))
			vim.cmd("args")
		end
	end)
end, { desc = "fd args" })

-- Edit arglist in floating window
map("n", "<space>ae", function()
	-- Set dimensions
	local abs_height = 15
	local rel_width = 0.7

	-- Create buf
	local argseditor = vim.api.nvim_create_buf(false, true)
	local filetype = "argseditor"
	vim.api.nvim_set_option_value("filetype", filetype, { buf = argseditor })

	-- Create centered floating window
	local rows, cols = vim.opt.lines._value, vim.opt.columns._value
	vim.api.nvim_open_win(argseditor, true, {
		relative = "editor",
		height = abs_height,
		width = math.ceil(cols * rel_width),
		row = math.ceil(rows / 2 - abs_height / 2),
		col = math.ceil(cols / 2 - cols * rel_width / 2),
		border = "single",
		title = filetype,
	})

	-- Put current arglist
	local arglist = vim.fn.argv(-1)
	local to_read = type(arglist) == "table" and arglist or { arglist }
	vim.api.nvim_buf_set_lines(argseditor, 0, -1, false, to_read)

	-- Go to file under cursor
	map("n", "<CR>", function()
		local f = vim.fn.getline(".")
		vim.api.nvim_buf_delete(argseditor, { force = true })
		vim.cmd.e(f)
	end, { desc = "Go to file under cursor" })

	-- Write new arglist and close argseditor
	map("n", "<M-w>", function()
		local to_write = vim.api.nvim_buf_get_lines(argseditor, 0, -1, true)
		vim.cmd("%argd")
		vim.cmd.arga(table.concat(to_write, " "))
		vim.api.nvim_buf_delete(argseditor, { force = true })
	end, { buffer = argseditor, desc = "Update arglist" })
end, { desc = "Edit arglist" })
