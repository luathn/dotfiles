require("mason").setup({})

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

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>ch', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Diagnostic Config
vim.diagnostic.config {
  underline = { severity = vim.diagnostic.severity.ERROR },
}

-- blink.cmp adds its capabilities to all servers via vim.lsp.config('*')
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      staticcheck = true,
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
})

-- Not installed via Mason: Mason's ruby-lsp always runs with the Ruby that
-- installed it. The asdf shim picks the project's Ruby from .tool-versions.
-- Install once for each Ruby version: `gem install ruby-lsp && asdf reshim ruby`
vim.lsp.config("ruby_lsp", {
  cmd = function(dispatchers, config)
    return vim.lsp.rpc.start(
      { vim.fn.expand("~/.asdf/shims/ruby-lsp") },
      dispatchers,
      { cwd = config.root_dir }
    )
  end,
})
vim.lsp.enable("ruby_lsp")

-- mason-lspconfig calls vim.lsp.enable() for servers installed by Mason
require('mason-lspconfig').setup {}

-- configure Swift serve here since it is not installed via Mason
vim.lsp.config("sourcekit", {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
})

vim.api.nvim_create_user_command(
  "LspLog",
  function() vim.cmd.edit(vim.lsp.log.get_filename()) end,
  {desc = "Show LSP log"}
)
