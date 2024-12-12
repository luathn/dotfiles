local M = {}

local silent_noremap = { silent = true, noremap = true }

M.general = {
  n = {
    ["gp"]         = { "`[v`]" },
    ["gyn"]        = { ":let @+=expand('%:t')<cr>", "[Y]ank [n]ame" },
    ["gys"]        = { ":let @+=expand('%')<cr>", "[Y]ank [s]hort [p]ath" },
    ["gyp"]        = { ":let @+=expand('%:h')<cr>", "[Y]ank [s]hort [p]ath" },
    ["gyf"]        = { ":let @+=expand('%:p')<cr>", "[Y]ank [f]ull [p]ath" },
    ["<leader>tc"] = { ":tabnew<cr>", "[T]ab [c]reate" },
    ["<leader>tx"] = { ":tabclose<cr>", "[T]ab close [x]" },
    ["<esc>"]      = { ":noh<cr><esc>", "[/] No highlight" },
    ["<leader>oq"] = { ":copen<CR>", "[O]pen [q]uickfix" },
    ["<leader>ol"] = { ":lopen<CR>", "[O]pen [l]ocation list" },
    ["<C-.>"]      = { "" },
    ["<C-w>."]     = { "<C-w>5>" },
    ["<C-w><C-.>"] = { "<C-w>5>" },
    ["<C-w>,"]     = { "<C-w>5<" },
    ["<C-w><C-,>"] = { "<C-w>5<" },
  },
  i = {
    ["jk"]         = { "<Esc>" },
  },
}

M.ruby_on_rails = {
  n = {
    ['<leader>rm'] = { ':vsplit | term bin/rails db:migrate RAILS_ENV=development<Cr>' }
  }
}

M.diffview = {
  { "<leader>gd", ":DiffviewOpen ", desc = "[G]it [d]iff" },
  { "<leader>cc", "<cmd>lua require('diffview.config').actions.conflict_choose('all')<cr>", desc = "[C]onflict [C]hoose" },
}

M.neogit = {
  { "<leader>gg", ":Neogit<cr>", desc = "[G]it status" },
  { "<leader>gl", ":Neogit log<cr>", desc = "[G]it [l]og" },
  { "<leader>gb", ":Neogit branch<cr>", desc = "[G]it [b]ranch" },
  { "<leader>gc", "<cmd>lua require('neogit').action('branch', 'checkout_local_branch')<cr>", desc = "[g]it [c]heckout" },
}

M.grug_far = {
  { "<leader>ss", "<cmd>lua require('grug-far').grug_far()<cr>", desc = "[S]each open" },
  { "<leader>sw", "<cmd>lua require('grug-far').grug_far({ startInInsertMode = false, prefills = { search = vim.fn.expand('<cword>') } })<cr>", desc = "[S]each [w]ord" },
  { "<leader>sw", ":<C-u> lua require('grug-far').with_visual_selection({ startInInsertMode = false })<cr>" , mode = "v", desc = "[S]each [w]ord" },
}

M.oil = {
  { "-", "<cmd>lua require('oil').open()<cr>", desc = "Open parent directory" },
}

M.vim_fugitive = {
  { "<leader>gB", ":Git blame<cr>", desc = "[G]it [b]lame" },
  { "<leader>ge", ":Gedit", desc = "[G]it [e]dit" },
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
  { "gs", "<cmd>lua require('treesj').toggle()<cr>", desc = "Toggle [s]plit/join" },
}

M.harpoon = {
  { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "[H]arpoon add file" },
  { "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "[H]arpoon toggle" },
}

M.navigator = {
  { "<C-h>", "<cmd>NavigatorLeft<CR>", mode = { "n", "t" } },
  { "<C-l>", "<cmd>NavigatorRight<CR>", mode = { "n", "t" } },
  { "<C-k>", "<cmd>NavigatorUp<CR>", mode = { "n", "t" } },
  { "<C-j>", "<cmd>NavigatorDown<CR>", mode = { "n", "t" } },
}

M.fzf_lua = {
  { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "[f]zf [f]iles" },
  { "<leader>bb", "<cmd>FzfLua buffers<CR>", desc = "[f]zf [b]uffers" },
  { "<leader>fg", "<cmd>lua require('fzf-lua').live_grep({  multiline = 2, continue_last_search = true })<cr>", desc = "[f]zf live_[g]rep" },
  { "<leader>fw", "<cmd>FzfLua grep_cword<CR>", mode = "n", desc = "[f]zf grep [w]ord" },
  { "<leader>fw", "<cmd>FzfLua grep_visual<CR>", mode = "v", desc = "[f]zf grep [w]ord" },
  { "<leader>gc", "<cmd>FzfLua git_branches<CR>", desc = "[G]it [c]heckout branch" },
  { "<leader>fr", "<cmd>FzfLua resume<CR>", mode = "n", desc = "[f]zf [r]esum" },
}

M.mini_pick = {
  { "<leader><space>", "<cmd>Pick files<cr>", desc = "" },
  { "<c-p>", "<cmd>Pick files<cr>", desc = "" },
  { "<leader>,", "<cmd>lua MiniPick.registry.sorted_buffers()<cr>", desc = "" },
  { "<c-,>", "<cmd>lua MiniPick.registry.sorted_buffers()<cr>", desc = "" },
  { "<leader>fr", "<cmd>Pick resume<CR>", mode = "n", desc = "[r]esum" },
  { "<leader>fg", "<cmd>Pick grep<cr>", desc = "" },
  { "<leader>fl", "<cmd>Pick grep_live<cr>", desc = "" },
}

M.mini_bufremove = {
  { "<leader>bd", "<cmd>lua MiniBufremove.delete()<CR>", desc = "[B]uffer [d]elete" },
  -- { "<leader>bD", ":BufDelAll<CR>", desc = "[B]uffer [D]elete all" },
  -- { "<leader>x",{ ":BufDel<CR>", desc = "[B]uffer [d]elete" },
  -- { "<leader>bo", ":BufDelOther<CR>", desc = "[B]uffer delete [o]ther" },
}

M.mini_git = {
  { "<leader>gB", ":vertical Git blame - %<cr>", desc = "[G]it [b]lame" },
}

M.nvim_dap = {
  { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "" },
  { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "" },
}

M.devdocs = {
  { "<leader>dd", "<cmd>DevdocsOpen<cr>", desc = "[d]ev [d]ocs open" },
  { "<leader>df", "<cmd>DevdocsOpenFloat<cr>", desc = "[d]evdocs open [f]loat" },
}

M.copilot_chat = {
  {
    "<leader>ch",
    function()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.fzflua").pick(actions.help_actions())
    end,
    mode = { "n", "v" },
    desc = "CopilotChat - Help actions",
  },
  -- Show prompts actions with fzf-lua
  {
    "<leader>cp",
    function()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
    end,
    mode = { "n", "v" },
    desc = "CopilotChat - Prompt actions",
  }
}

-- M.nvim_telescope = {
--   { "<leader><leader>", "<cmd>lua require('telescope.builtin').find_files(no_preview)<cr>", desc = "Find files" },
--   { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files(require'telescope.themes'.get_ivy())<cr>", desc = "[F]ind [f]ile" },
--   { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files(my_theme)<cr>", desc = "[F]ind [f]ile" },
--   { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers(half_screen)<cr>", desc = "Find [b]uffers" },
--   { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep(my_theme)<cr>", desc = "[F]ind by live[g]rep" },
--   { "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string(my_theme)<cr>", desc = "[F]ind current [w]ord" },
--   { "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<cr>", desc = "[F]ind [r]esume" },
--   { "<leader>gc", "<cmd>lua require('telescope.builtin').git_branches()<cr>", desc = "[G]it [c]heckout branch" },
--   { "<leader>fp", "<cmd>lua require('telescope.builtin').find_files(opts = {search_dirs = { vim.fn.expand('%p:h') }})<cr>", desc = "[F]ind current [p]ath" },
-- }

-- M.fzf = {
--   { "<leader><space>", ":Files<CR>", desc = "fzf files" },
--   { "<leader>ff", ":Files<CR>", desc = "[f]zf [f]iles" },
--   { "<leader>,", ":FzfBuffers<CR>", desc = "[f]zf [b]uffers" },
--   { "<leader>fb", ":FzfBuffers<CR>", desc = "[f]zf [b]uffers" },
--   { "<leader>bb", ":FzfBuffers<CR>", desc = "[f]zf [b]uffers" },
--   { "<leader>fg", ":Rg <C-R><C-W><CR>", desc = "[f]zf [g]rep" },
-- }

-- M.nvim_spectre = {
  -- { "<leader>ss", "<cmd>lua require('spectre').toggle({is_close = true})<cr>", desc = "[S]pectre [s]earch open" },
  -- { "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", desc = "[S]earch current [w]ord" },
  -- { "<leader>sb", "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>", desc = "[S]earch on current [b]uffer"},
  -- { "<leader>sw", "<esc><cmd>lua require('spectre').open_visual()<cr>", mode = "v", desc = "[S]earch current [w]ord" },
-- }

return M

-- others
-- map <silent> <leader><cr> :call OpenFloatTerm()<cr>
-- autocmd Filetype ruby map <leader>rr :!ruby %<cr>
-- autocmd Filetype python map <leader>rr :!python3 %<cr>
-- autocmd Filetype go map <leader>rr :!go run %<cr>
-- vnoremap <leader>rw "hy:%s/<C-r>h//g<left><left>
