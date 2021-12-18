local api = vim.api

local utils = {}

-- Function taken from NvimChad
utils.map function(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

utils.nmap function(key, cmd, opts)
  return map("n", key, cmd, opts)
end

utils.vmap function(key, cmd, opts)
  return map("v", key, cmd, opts)
end

utils.xmap function(key, cmd, opts)
  return map("x", key, cmd, opts)
end

utils.imap function(key, cmd, opts)
  return map("i", key, cmd, opts)
end

utils.omap function(key, cmd, opts)
  return map("o", key, cmd, opts)
end

utils.smap = function(key, cmd, opts)
  return map("s", key, cmd, opts)
end

utils.sugar_folds = function()
  local start_line = vim.fn.getline(vim.v.foldstart):gsub("\t", ("\t"):rep(vim.opt.tabstop:get()))
  return string.format("%s ... (%d lines)", start_line, vim.v.foldend - vim.v.foldstart + 1)
end

--- Executes a git command and gets the output
--- @param command string
--- @param remove_newlines boolean
--- @return string
utils.get_git_output = function(command, remove_newlines)
    local git_command_handler = io.popen(system.git_workspace .. command)
    -- Read the command output and remove newlines if wanted
    local command_output = git_command_handler:read("*a")
    if remove_newlines then
        command_output = command_output:gsub("[\r\n]", "")
    end
    -- Close child process
    git_command_handler:close()
    return command_output
end

return utils
