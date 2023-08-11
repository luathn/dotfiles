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
  { "<C-F>f", "<Plug>CtrlSFPrompt" },
  { "<C-F>n", "<Plug>CtrlSFCwordPath" },
  { "<C-F>p", "<Plug>CtrlSFPwordPath" },
  { "<C-F>o", ":CtrlSFOpen<cr>" },
  { "<C-F>t", ":CtrlSFToggle<cr>" },
  { "<C-F>f", "<Plug>CtrlSFVwordPath", mode = "v" },
  { "<C-F>F", "<Plug>CtrlSFVwordExec", mode = "v" },
  { "<C-F>t", "<Esc>:CtrlSFToggle<cr>", mode = "i" },
}

M.diffview = {
  { "<leader>gd", ":DiffviewOpen ", desc = "[G]it [d]iff" },
  { "<leader>gq", ":DiffviewClose<cr>", desc = "[G]it diff [q]uit" },
}

M.neogit = {
  { "<leader>gg", ":Neogit<cr>", desc = "[G]it status" },
  { "<leader>gl", ":Neogit log<cr>", desc = "[G]it [l]og" }
}

M.nvim_bufferline = {
  { "<leader>l", ":BufferLineCycleNext<cr>", desc = "[l] Next buffer" },
  { "<leader>h", ":BufferLineCyclePrev<cr>", desc = "[h] Previous buffer" },
  { "<leader>bl", ":BufferLineMoveNext<cr>", desc = "Move [b]uffer [l]eft" },
  { "<leader>bh", ":BufferLineMovePrev<cr>", desc = "Move [b]uffer rig[h]t" },
  { "<leader>bp", ":BufferLineTogglePin<cr>", desc = "Toggle [b]uffer [p]in" },
  { "<leader>bX", ":BufferLineGroupClose ungrouped<cr>", desc =  "Non-pinned [bX]uffer delete"  },
}

M.nvim_spectre = {
  { "<leader>ss", "<cmd>lua require('spectre').open()<cr>", desc = "[S]pectre [s]earch open" },
  { "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", desc = "[S]earch current [w]ord" },
  { "<leader>sb", "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>", desc = "[S]earch on current [b]uffer"},
  { "<leader>sw", "<esc><cmd>lua require('spectre').open_visual()<cr>", mode = "v", desc = "[S]earch current [w]ord" },
}

M.nvim_telescope = {
  -- { "<leader><leader>", "<cmd>lua require('telescope.builtin').find_files(no_preview)<cr>", desc = "Find files" },
  -- { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files(no_preview)<cr>", desc = "[F]ind [f]ile" },
  -- { "<leader>,",{ "<cmd>lua require('telescope.builtin').buffers(no_preview)<cr>", desc = "Find buffers" },
  -- { "<leader>bb", "<cmd>lua require('telescope.builtin').buffers(no_preview)<cr>", desc = "Find [b]uffers" },
  { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep(with_preview)<cr>", desc = "[F]ind by live[g]rep" },
  { "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string(with_preview)<cr>", desc = "[F]ind current [w]ord" },
  { "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<cr>", desc = "[F]ind [r]esume" },
  { "<leader>gc", "<cmd>lua require('telescope.builtin').git_branches()<cr>", desc = "[G]it [c]heckout branch" },
  { "<leader>fp", "<cmd>lua require('telescope.builtin').find_files(opts = {search_dirs = { vim.fn.expand('%p:h') }})<cr>", desc = "[F]ind current [p]ath" },
}

M.nvim_tree = {
  { "<leader>oe", ":NvimTreeToggle<cr>" },
  { "<leader>mr", ":NvimTreeRefresh<cr>" },
  { "<leader>mf", "<cmd>lua require('nvim-tree.api').tree.find_file({ open = true, focus = true })<cr>" },
}

M.oil = {
  { "-", "<cmd>lua require('oil').open()<cr>", desc = "Open parent directory" },
}

M.vim_fugitive = {
  { "<leader>gb", ":Git blame<cr>", desc = "[G]it [b]lame" }
}

M.vim_test = {
  { "<leader>tn", ":TestNearest<CR>", desc = "[T]est [n]earest" },
  { "<leader>tf", ":TestFile<CR>", desc = "[T]est [f]ile" },
  { "<leader>ts", ":TestSuite<CR>", desc = "[T]est [s]uite" },
  { "<leader>tl", ":TestLast<CR>", desc = "[T]est [l]ast" },
  { "<leader>tv", ":TestVisit<CR>", desc = "[T]est [v]isit" },
}

M.nvim_bufdel = {
  { "<leader>bd", ":BufDel<CR>", desc = "[B]uffer [d]elete" },
  { "<leader>bD", ":BufDelAll<CR>", desc = "[B]uffer [D]elete all" },
  -- { "<leader>x",{ ":BufDel<CR>", desc = "[B]uffer [d]elete" },
  { "<leader>bo", ":BufDelOther<CR>", desc = "[B]uffer delete [o]ther" },
}

M.treesj = {
  { "gS", "<cmd>lua require('treesj').toggle()<cr>", desc = "Toggle [S]plit/Join" },
}

M.harpoon = {
  { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "[H]arpoon add file" },
  { "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "[H]arpoon toggle" },
  { "<leader>,", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "[H]arpoon toggle" },
}

M.fzf = {
  { "<leader><space>", ":Files<CR>", desc = "fzf files" },
  { "<leader>ff", ":Files<CR>", desc = "[f]zf [f]iles" },
  { "<leader>fb", ":FzfBuffers<CR>", desc = "[f]zf [b]uffers" },
  { "<leader>bb", ":FzfBuffers<CR>", desc = "[f]zf [b]uffers" },
}

return M

-- others
-- map <silent> <leader><cr> :call OpenFloatTerm()<cr>
-- autocmd Filetype ruby map <leader>rr :!ruby %<cr>
-- autocmd Filetype python map <leader>rr :!python3 %<cr>
-- autocmd Filetype go map <leader>rr :!go run %<cr>
-- vnoremap <leader>rw "hy:%s/<C-r>h//g<left><left>
