local statusline = require('mini.statusline')

statusline.section_fileinfo = function()
  return nil
end

statusline.section_location = function()
  return '%2l:%-2v'
end

statusline.section_git = function()
  if vim.fn.exists("g:loaded_fugitive") == 1 then
    return vim.fn.FugitiveStatusline()
  end
  return ""
end

statusline.setup()
