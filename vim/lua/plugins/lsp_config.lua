local nvim_lsp = require('lspconfig')


local function dorename(win)
  local new_name = vim.trim(vim.fn.getline('.'))
  vim.api.nvim_win_close(win, true)
  vim.lsp.buf.rename(new_name)
end

local function rename()
  local opts = {
    relative = 'cursor',
    row = 0,
    col = 0,
    width = 30,
    height = 1,
    style = 'minimal',
    border = 'single'
  }
  local cword = vim.fn.expand('<cword>')
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_buf_set_option(buf, 'syntax', 'off')
  vim.api.nvim_win_set_option(winid,'scrolloff',0)
  vim.api.nvim_win_set_option(winid,'sidescrolloff',0)
  vim.api.nvim_buf_set_option(bufnr,'modifiable',true)

  local fmt =  '<cmd>lua Rename.dorename(%d)<CR>'

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {cword})
  vim.api.nvim_buf_set_keymap(buf, 'i', '<CR>', string.format(fmt, win), {silent=true})
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', {silent=true})
end

_G.Rename = {
   rename = rename,
   dorename = dorename
}

vim.api.nvim_set_keymap('n', '<leader>ar', '<cmd>lua Rename.rename()<CR>', {silent = true})


local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua PeekDefinition()<cr>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<space>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>ce', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<space>cl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>cf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  -- if client.resolved_capabilities.document_highlight then
  --   vim.api.nvim_exec([[
  --     :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
  --     :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
  --     :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
  --     augroup lsp_document_highlight
  --       autocmd!
  --       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --     augroup END
  --   ]], false)
  -- end
end

-- Update capabilities nvim-cpm
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "solargraph", "pylsp", "jedi_language_server", "tsserver", "eslint" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

-- Eslint
-- local util = require "lspconfig".util

-- local eslint = {
--   lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
--   lintStdin = true,
--   lintFormats = {"%f:%l:%c: %m"},
--   lintIgnoreExitCode = true,
--   formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
--   formatStdin = true
-- }

-- require "lspconfig".efm.setup {
--   init_options = {documentFormatting = true},
--   filetypes = {"javascript", "typescript"},
--   root_dir = function(fname)
--     return util.root_pattern("tsconfig.json")(fname) or
--     util.root_pattern(".eslintrc.js", ".git")(fname);
--   end,
--   settings = {
--     rootMarkers = {".eslintrc.js", ".git/"},
--     languages = {
--       javascript = {eslint},
--       typescript = {eslint}
--     }
--   }
-- }


vim.lsp.handlers["textDocument/rename"] = function(err, result)
  if err then vim.notify(("Error running lsp query 'rename': "..err), vim.log.levels.ERROR) end
  if result and result.changes then
    local msg = ""
    for f, c in pairs(result.changes) do
      local new = c[1].newText
      msg = msg..("%d changes -> %s"):format(#c, f:gsub("file://",""):gsub(vim.fn.getcwd(),".")).."\n"
      msg = msg:sub(1, #msg - 1)
      vim.notify(msg, vim.log.levels.INFO, { title = ("Rename: %s -> %s"):format(vim.fn.expand("<cword>"), new) })
    end
  end
  vim.lsp.util.apply_workspace_edit(result)
end

function _G.rename()
  local currName = vim.fn.expand("<cword>")
  -- local tshl = require("nvim-treesitter-playground.hl-info").get_treesitter_hl()
  -- if tshl and #tshl > 0 then
  --   local ind = tshl[#tshl]:match("^.*()%*%*.*%*%*")
  --   tshl = tshl[#tshl]:sub(ind + 2, -3)
  -- end

  local win = require('plenary.popup').create(currName, {
    title = "New Name",
    style = "minimal",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    relative = "cursor",
    borderhighlight = "FloatBorder",
    titlehighlight = "Title",
    -- highlight = tshl,
    focusable = true,
    width = 25,
    height = 1,
    line = "cursor+2",
    col = "cursor-1"
  })

  local map_opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(0, "i", "<Esc>", "<cmd>stopinsert<CR>", map_opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
  vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "<cmd>stopinsert | lua _rename('"..currName..","..win.."')<CR>", map_opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<cmd>stopinsert | lua _rename('"..currName..","..win.."')<CR>", map_opts)
end

function _G._rename(curr, win)
  local newName = vim.trim(vim.fn.getline('.'))
  vim.api.nvim_win_close(win, true)
  if #newName > 0 and newName ~= curr then
    local params = vim.lsp.util.make_position_params()
    params.newName = newName
    vim.lsp.buf_request(0, "textDocument/rename", params)
  end
end

vim.api.nvim_set_keymap('n', '<leader>gr', '<cmd>lua rename()<CR>', {silent = true})
