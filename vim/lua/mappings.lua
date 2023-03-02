local M = {}

local silent_noremap = { silent = true, noremap = true }

M.general = {
  n = {
    ["<leader>fs"] = { ":update<cr>", "[F]ile [s]ave" },
    ["<C-S>"]      = { ":update<cr>" },
    -- Copy file path
    ["gyn"]        = { ":let @+=expand('%:t')<cr>", "[Y]ank [n]ame" },
    ["gysp"]       = { ":let @+=expand('%')<cr>", "[Y]ank [s]hort [p]ath" },
    ["gyfp"]       = { ":let @+=expand('%:p')<cr>", "[Y]ank [f]ull [p]ath" },
    -- Manage windows
    ["<leader>wv"] = { "<C-W>v", "Split [w]indow [v]ertical" },
    ["<leader>ws"] = { "<C-W>s", "Split [w]indow [s]plit horizontal" },
    ["<leader>wq"] = { "<C-W>q", "[W]indow [q]uit" },
    ["<leader>wh"] = { "<C-W>h", "[W]indow left [h]" },
    ["<leader>wj"] = { "<C-W>j", "[W]indow down [j]" },
    ["<leader>wk"] = { "<C-W>k", "[W]indow up [k]" },
    ["<leader>wl"] = { "<C-W>l", "[W]indow right [l]" },
    ["<leader>wH"] = { "<C-W>H", "Move [w]indow left [H]" },
    ["<leader>wJ"] = { "<C-W>J", "Move [w]indow down [J]" },
    ["<leader>wK"] = { "<C-W>K", "Move [w]indow up [K]" },
    ["<leader>wL"] = { "<C-W>L", "Move [w]indow right [L]" },
    ["<leader>w>"] = { "<C-W>>", "Increase [w]indow width [>]" },
    ["<leader>w<"] = { "<C-W><", "Iecrease [w]indow width [<]" },
    ["<leader>w+"] = { "<C-W>+", "Increase [w]indow height [+]" },
    ["<leader>w-"] = { "<C-W>-", "Decrease [w]indow height [-]" },
    ["<leader>w="] = { "<C-W>=", "Make [w]indow [=]" },
    -- Manage tabs
    ["<leader>tc"] = { ":tabnew<cr>", "[T]ab [c]reate" },
    ["<leader>tx"] = { ":tabclose<cr>", "[T]ab close [x]" },
    -- Turn off search highlight
    ["<leader>/"]  = { ":noh<cr>", "[/] No highlight" },
    -- Open
    ["<leader>oq"]  = { ":copen<CR>", "[O]pen [q]uickfix" },
    ["<leader>ol"]  = { ":lopen<CR>", "[O]pen [l]ocation list" },
  },
  v = {
    ["<C-S>"]      = { "<C-C>:update<cr>" },
  },
  i = {
    ["jk"]         = { "<Esc>" },
    ["<C-S>"]      = { "<Esc>:update<cr>" },
  },
}

M.lsp = {
  n = {
    ["<leader>rn"] = { vim.lsp.buf.rename, "[R]e[n]ame" },
    ["<leader>ca"] = { vim.lsp.buf.code_action, "[C]ode [a]ction" },

    ["gd"]         = { vim.lsp.buf.definition, "Go to [d]efinition" },
    ["gr"]         = { vim.lsp.buf.references, "Go to [r]eference" },
    ["gI"]         = { vim.lsp.buf.implementation, "Go to [I]mplementation" },
    ["<leader>D"]  = { vim.lsp.buf.type_definition, "Type [D]efinition" },

    -- See `:help K` for why this keymap
    ["K"]          = { vim.lsp.buf.hover, "Hover documentation" },
    -- ["<C-k>"]      = { vim.lsp.buf.signature_help, "signature documentation" },

    ["<leader>ce"] = { vim.diagnostic.open_float, "Show line diagnostic" },
    ["<leader>cl"] = { vim.diagnostic.setloclist, "Show diagnostic in loc[l]ist" },
    ["[d"]         = { vim.diagnostic.goto_prev, "Prev [d]iagnostic" },
    ["]d"]         = { vim.diagnostic.goto_next, "Next [d]iagnostic", },

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

M.ctrlsf = {
  n = {
    ["<C-F>f"]     = { "<Plug>CtrlSFPrompt" },
    ["<C-F>n"]     = { "<Plug>CtrlSFCwordPath" },
    ["<C-F>p"]     = { "<Plug>CtrlSFPwordPath" },
    ["<C-F>o"]     = { ":CtrlSFOpen<cr>" },
    ["<C-F>t"]     = { ":CtrlSFToggle<cr>" },
  },
  v = {
    ["<C-F>f"]     = { "<Plug>CtrlSFVwordPath" },
    ["<C-F>F"]     = { "<Plug>CtrlSFVwordExec" },
  },
  i = {
    ["<C-F>t"]     = { "<Esc>:CtrlSFToggle<cr>" },
  },
}

M.diffview = {
  n = {
    ["<leader>gd"] = { ":DiffviewOpen ", "[G]it [d]iff" },
    ["<leader>gq"] = { ":DiffviewClose<cr>", "[G]it diff [q]uit" },
  },
}

M.neogit = {
  n = {
    ["<leader>gg"] = { ":Neogit<cr>", "[G]it status", opts = silent_noremap },
    ["<leader>gl"] = { ":Neogit log<cr>", "[G]it [l]og", opts = silent_noremap }
  },
}

M.nvim_bufferline = {
  n = {
    ["<leader>l"]  =  { ":BufferLineCycleNext<cr>", "[l] Next buffer" },
    ["<leader>h"]  =  { ":BufferLineCyclePrev<cr>", "[h] Previous buffer" },
    ["<leader>bl"] = { ":BufferLineMoveNext<cr>", "Move [b]uffer [l]eft" },
    ["<leader>bh"] = { ":BufferLineMovePrev<cr>", "Move [b]uffer rig[h]t" },
    ["<leader>bp"] = { ":BufferLineTogglePin<cr>", "Toggle [b]uffer [p]in" },
    ["<leader>bX"] = { ":BufferLineGroupClose ungrouped<cr>",  "Non-pinned [bX]uffer delete"  },
  },
}

M.nvim_spectre = {
  n = {
    ["<leader>ss"] = { "<cmd>lua require('spectre').open()<cr>", "[S]pectre [s]earch open" },
    ["<leader>sw"] = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "[S]earch current [w]ord" },
    ["<leader>sb"] = { "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>", "[S]earch on current [b]uffer"},
  },
  v = {
    ["<leader>sw"] = { "<esc><cmd>lua require('spectre').open_visual()<cr>", "[S]earch current [w]ord" },
  },
}

M.nvim_telescope = {
  n = {
    ["<leader><leader>"] = { "<cmd>lua require('telescope.builtin').find_files(no_preview)<cr>", "Find files", opts = silent_noremap },
    ["<leader>ff"] = { "<cmd>lua require('telescope.builtin').find_files(no_preview)<cr>", "[F]ind [f]ile", opts = silent_noremap },
    ["<leader>,"]  = { "<cmd>lua require('telescope.builtin').buffers(no_preview)<cr>", "Find buffers", opts = silent_noremap },
    ["<leader>bb"] = { "<cmd>lua require('telescope.builtin').buffers(no_preview)<cr>", "Find [b]uffers", opts = silent_noremap },
    ["<leader>fg"] = { "<cmd>lua require('telescope.builtin').live_grep(with_preview)<cr>", "[F]ind by live[g]rep", opts = silent_noremap },
    ["<leader>fw"] = { "<cmd>lua require('telescope.builtin').grep_string(with_preview)<cr>", "[F]ind current [w]ord", opts = silent_noremap },
    ["<leader>fr"] = { "<cmd>lua require('telescope.builtin').resume()<cr>", "[F]ind [r]esume", opts = silent_noremap },
    ["<leader>gc"] = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "[G]it [c]heckout branch", opts = silent_noremap },
    ["<leader>fp"] = { "<cmd>lua require('telescope.builtin').find_files(opts = {search_dirs = { vim.fn.expand('%p:h') }})<cr>", "[F]ind current [p]ath", opts = silent_noremap },
  }
}

M.nvim_tree = {
  n = {
    ["<leader>oe"] = { ":NvimTreeToggle<cr>" },
    ["<leader>mr"] = { ":NvimTreeRefresh<cr>" },
    ["<leader>mf"] = { "<cmd>lua require('nvim-tree.api').tree.find_file({ open = true, focus = true })<cr>" },
  }
}

M.oil = {
  n = {
    ["-"]          = { "<cmd>lua require('oil').open()<cr>", "Open parent directory" },
  },
}

M.vim_fugitive = {
  n = {
    ["<leader>gb"] = { ":Git blame<cr>", "[G]it [b]lame" }
  }
}

M.vim_test = {
  n = {
    ["<leader>tn"] = { ":TestNearest<CR>", "[T]est [n]earest" },
    ["<leader>tf"] = { ":TestFile<CR>", "[T]est [f]ile" },
    ["<leader>ts"] = { ":TestSuite<CR>", "[T]est [s]uite" },
    ["<leader>tl"] = { ":TestLast<CR>", "[T]est [l]ast" },
    ["<leader>tv"] = { ":TestVisit<CR>", "[T]est [v]isit" },
  }
}

M.nvim_bufdel = {
  n = {
    ["<leader>bd"] = { ":BufDel<CR>", "[B]uffer [d]elete" },
    ["<leader>bD"] = { ":BufDelAll<CR>", "[B]uffer [D]elete all" },
    -- ["<leader>x"]  = { ":BufDel<CR>", "[B]uffer [d]elete" },
    ["<leader>bo"] = { ":BufDelOther<CR>", "[B]uffer delete [o]ther" },
  }
}

M.treesj = {
  n = {
    ["gS"]         = { "<cmd>lua require('treesj').toggle()<cr>", "Toggle [S]plit/Join" },
  }
}

return M

-- Close quickfix
-- autocmd FileType qf nnoremap <buffer> q :cclose<cr>:lclose<cr>

-- command! Source :source ~/.config/nvim/init.vim

-- others
-- map <silent> <leader><cr> :call OpenFloatTerm()<cr>
-- autocmd Filetype ruby map <leader>rr :!ruby %<cr>
-- autocmd Filetype python map <leader>rr :!python3 %<cr>
-- autocmd Filetype go map <leader>rr :!go run %<cr>
-- vnoremap <leader>rw "hy:%s/<C-r>h//g<left><left>
