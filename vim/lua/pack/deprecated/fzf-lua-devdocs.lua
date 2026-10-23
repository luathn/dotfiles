-- {
--     alias = "javascript",
--     link = "global_objects/object/proto",
--     name = "Object.proto",
--     next_path = "850",
--     path = "846"
--   }

local M = {}
local list = require("nvim-devdocs.list")
local operations = require("nvim-devdocs.operations")
local plugin_state = require("nvim-devdocs.state")
local plugin_config = require("nvim-devdocs.config")
local fzf_lua = require("fzf-lua")

local function get_idx(item)
  return tonumber(item:match("%[(%d+)%]"))
end

local open_docs = function(entries, selected, opts)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local idx = get_idx(selected[1])

  local lines = plugin_state.get("preview_lines") or operations.read_entry(entries[idx])
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

  plugin_state.set("last_mode", "normal")
  operations.open(entries[idx], bufnr)
end


M.open_picker = function()
  local entries = list.get_doc_entries({ alias = "javascript" })

  local Previewer = {}
  Previewer.base = require('fzf-lua.previewer.builtin').base
  Previewer.buffer_or_file = require('fzf-lua.previewer.builtin').buffer_or_file

  function Previewer:new(o, opts, fzf_win)
    self = setmetatable(Previewer.base(o, opts, fzf_win), {
      __index = vim.tbl_deep_extend("keep",
        self, Previewer.base
        -- only if you need access to specific file methods
        -- self, Previewer.buffer_or_file, Previewer.base
      )})
    return self
  end

  function Previewer:parse_entry(entry_str)
    local idx = get_idx(entry_str)
    return operations.read_entry(entries[idx])
  end

  function Previewer:populate_preview_buf(entry_str)
    local entry = self:parse_entry(entry_str)
    local tmpbuf = self:get_tmp_buffer()
    -- vim.api.nvim_buf_set_option(tmpbuf, 'modifiable', true) 
    self:set_preview_buf(tmpbuf)
    -- mark the buffer for unloading on next preview call
    self.preview_bufloaded = true

    local lines = entry
    -- vim.api.nvim_buf_set_option(self.preview_bufnr, 'modifiable', true)
    vim.api.nvim_buf_set_lines(self.preview_bufnr, 0, -1, false, lines)
    -- uncomment to enable syntax highlighting, e.g. for 'lua':
    local filetype = 'markdown'
    vim.api.nvim_buf_set_option(self.preview_bufnr, 'filetype', filetype)
    -- uncomment if your content line count can be longer than the screen
    -- and you wish to update the scrollar
    self.win:update_scrollbar()
  end


  fzf_lua.fzf_exec(
    function(fzf_cb)
      local i = 1
      for _, e in ipairs(entries) do
        fzf_cb(("[%s] %s %s"):format(
          e.alias,
          fzf_lua.utils.ansi_codes.magenta(e.name),
          fzf_lua.utils.ansi_codes.grey("[" .. tostring(i) .. "]")
        ))
        i = i + 1
      end
      fzf_cb(nil)
    end, {
    prompt = 'Docs❯ ',
    previewer = Previewer,
    actions = {
      ['default'] = function(selected, opts)
        open_docs(entries, selected, opts)
      end,
      ['ctrl-v'] = function(selected, opts)
        vim.cmd("vsplit")
        open_docs(entries, selected, opts)
      end,
    }
  })
end

return M
