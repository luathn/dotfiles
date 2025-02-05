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

local on_attach = function(_, bufnr)
  require("core.utils").load_mappings("lsp", { buffer = bufnr }, lsp_mappings)
end

local servers = {
  solargraph = {},
  -- ruby_lsp = {},
  ts_ls = {},
  -- vtsls = {},
  lua_ls = {},
  eslint = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

vim.diagnostic.config({
  virtual_text = false,
})

-- Mason lspconfig
-- ensure_installed_eg =  { 'eslint_d' }
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}
