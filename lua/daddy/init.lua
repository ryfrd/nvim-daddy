function go()
  -- take input from user
	vim.ui.input(
    {
      prompt = "Create file and parent directories: ",
      default = prefill,
      completion = "dir"
    },
    function(path)

      -- get current working directory and add trailing slash
      local cwd = vim.fn.getcwd() .. "/"

      -- remove opening slash from path
      -- if it exists
      local first_char = string.sub(path,1,1)

      if first_char == "/" then
        path = path:sub(2)
      end

      -- limit path to directories
      for i = 1, #path do
        local c = path:sub(i,i)
        if c == "/" then
          final_slash_index = i
        end
      end

      local dir_path = cwd .. path:sub(1,final_slash_index)
      local full_path = cwd .. path

      -- make parent directories
      os.execute('mkdir -p ' .. dir_path)
      -- edit file
      vim.api.nvim_command('e ' .. full_path)
    end
  )
end

local M = {}

M.go = go

return M
