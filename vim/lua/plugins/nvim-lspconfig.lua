local lsp_mappings = {
  n = {
    ["gd"]         = { vim.lsp.buf.definition, "Go to [d]efinition" },
    ["<leader>cd"] = { vim.diagnostic.open_float, "Show line diagnostic" },
    ["<leader>cl"] = { vim.diagnostic.setloclist, "Show diagnostic in loc[l]ist" },
    ["<leader>cq"] = { vim.diagnostic.setqflist, "Show diagnostic in loc[l]ist" },

    ["<leader>cf"] = { vim.lsp.buf.format, "[C]ode format" },
  },
  v = {
    ["<leader>cf"] = { vim.lsp.buf.format, "[C]ode format" },
  }
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    require("core.utils").load_mappings("lsp", { buffer = event.buf }, lsp_mappings)

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local function client_supports_method(client, method, bufnr)
      return client:supports_method(method, bufnr)
    end

    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>ch', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
-- vim.diagnostic.config {
--   severity_sort = true,
--   float = { border = 'rounded', source = 'if_many' },
--   underline = { severity = vim.diagnostic.severity.ERROR },
--   virtual_text = false,
-- }

local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Enable the following language servers
local servers = {
  ruby_lsp = {},
  ts_ls = {},
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = false,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  -- vtsls = {},
  eslint = {},
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  lua_ls = {},
}

local ensure_installed = vim.tbl_keys(servers or {})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

-- mason-lspconfig v2 dropped `handlers`, so apply configs directly;
-- it still calls vim.lsp.enable() for installed servers (automatic_enable)
for server_name, server in pairs(servers) do
  server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
  vim.lsp.config(server_name, server)
end

require('mason-lspconfig').setup {
  ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
}

-- configure Swift serve here since it is not installed via Mason
vim.lsp.config("sourcekit", {
  -- capabilities = capabilities,
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
})
