local lsp_mappings = {
  n = {
    ["<leader>cr"] = { vim.lsp.buf.rename, "[C]ode [R]ename" },
    ["<leader>ca"] = { vim.lsp.buf.code_action, "[C]ode [a]ction" },

    ["gd"]         = { vim.lsp.buf.definition, "Go to [d]efinition" },
    ["gr"]         = { vim.lsp.buf.references, "Go to [r]eference" },
    ["gI"]         = { vim.lsp.buf.implementation, "Go to [I]mplementation" },
    ["<leader>D"]  = { vim.lsp.buf.type_definition, "Type [D]efinition" },

    -- See `:help K` for why this keymap
    -- ["K"]          = { vim.lsp.buf.hover, "Hover documentation" },
    -- ["<C-k>"]      = { vim.lsp.buf.signature_help, "signature documentation" },

    ["<leader>ce"] = { vim.diagnostic.open_float, "Show line diagnostic" },
    ["<leader>cl"] = { vim.diagnostic.setloclist, "Show diagnostic in loc[l]ist" },
    -- ["[d"]         = { vim.diagnostic.goto_prev, "Prev [d]iagnostic" },
    -- ["]d"]         = { vim.diagnostic.goto_next, "Next [d]iagnostic", },

    -- Lesser used LSP functionality
    ["gD"]         = { vim.lsp.buf.declaration, "Go to [D]eclaration" },
    ["<leader>wa"] = { vim.lsp.buf.add_workspace_folder, "[W]orkspace [a]dd Folder" },
    ["<leader>wr"] = { vim.lsp.buf.remove_workspace_folder, "[W]orkspace [r]emove folder" },
    ["<leader>wf"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "[W]orkspace list [f]olders"
    },
    ["<leader>cf"] = { vim.lsp.buf.format, "[C]ode format" },
  },
  v = {
    ["<leader>cf"] = { vim.lsp.buf.format, "[C]ode format" },
  }
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    require("core.utils").load_mappings("lsp", { buffer = bufnr }, lsp_mappings)

    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local function client_supports_method(client, method, bufnr)
      return client:supports_method(method, bufnr)
    end

    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = false,
}

local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local servers = {
  -- solargraph = {},
  ruby_lsp = {},
  ts_ls = {},
  gopls = {},
  -- vtsls = {},
  eslint = {},
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  lua_ls = {},
}

local ensure_installed = vim.tbl_keys(servers or {})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

require('mason-lspconfig').setup {
  ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
  automatic_installation = false,
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for ts_ls)
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}

-- Depricated config
-- local lsp_mappings = {
--   n = {
--     ["<leader>cr"] = { vim.lsp.buf.rename, "[C]ode [R]ename" },
--     ["<leader>ca"] = { vim.lsp.buf.code_action, "[C]ode [a]ction" },
--
--     ["gd"]         = { vim.lsp.buf.definition, "Go to [d]efinition" },
--     ["gr"]         = { vim.lsp.buf.references, "Go to [r]eference" },
--     ["gI"]         = { vim.lsp.buf.implementation, "Go to [I]mplementation" },
--     ["<leader>D"]  = { vim.lsp.buf.type_definition, "Type [D]efinition" },
--
--     -- See `:help K` for why this keymap
--     -- ["K"]          = { vim.lsp.buf.hover, "Hover documentation" },
--     -- ["<C-k>"]      = { vim.lsp.buf.signature_help, "signature documentation" },
--
--     ["<leader>ce"] = { vim.diagnostic.open_float, "Show line diagnostic" },
--     ["<leader>cl"] = { vim.diagnostic.setloclist, "Show diagnostic in loc[l]ist" },
--     -- ["[d"]         = { vim.diagnostic.goto_prev, "Prev [d]iagnostic" },
--     -- ["]d"]         = { vim.diagnostic.goto_next, "Next [d]iagnostic", },
--
--     -- Lesser used LSP functionality
--     ["gD"]         = { vim.lsp.buf.declaration, "Go to [D]eclaration" },
--     ["<leader>wa"] = { vim.lsp.buf.add_workspace_folder, "[W]orkspace [a]dd Folder" },
--     ["<leader>wr"] = { vim.lsp.buf.remove_workspace_folder, "[W]orkspace [r]emove folder" },
--     ["<leader>wf"] = {
--       function()
--         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--       end,
--       "[W]orkspace list [f]olders"
--     },
--     ["<leader>cf"] = { vim.lsp.buf.format, "[C]ode format" },
--   },
--   v = {
--     ["<leader>cf"] = { vim.lsp.buf.format, "[C]ode format" },
--   }
-- }
--
-- local on_attach = function(_, bufnr)
--   require("core.utils").load_mappings("lsp", { buffer = bufnr }, lsp_mappings)
-- end
--
-- local servers = {
--   solargraph = {},
--   -- ruby_lsp = {},
--   ts_ls = {},
--   -- vtsls = {},
--   lua_ls = {},
--   eslint = {},
-- }
--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- -- capabilities = require("cmp_nvim_lsp").default_capabilities()
-- capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     virtual_text = false,
--     signs = true,
--     update_in_insert = true,
--   }
-- )
--
-- vim.diagnostic.config({
--   virtual_text = false,
-- })
--
-- -- Mason lspconfig
-- -- ensure_installed_eg =  { 'eslint_d' }
-- local mason_lspconfig = require "mason-lspconfig"
--
-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }
--
-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require("lspconfig")[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--     }
--   end,
-- }
