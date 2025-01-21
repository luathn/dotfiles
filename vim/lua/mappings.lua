local M = {}

local silent_noremap = { silent = true, noremap = true }

M.general = {
  n = {
    ["gp"]         = { "`[v`]" },
    ["gyn"]        = { ":let @+=expand("%:t")<cr>", "[Y]ank [n]ame" },
    ["gys"]        = { ":let @+=expand("%")<cr>", "[Y]ank [s]hort [p]ath" },
    ["gyp"]        = { ":let @+=expand("%:h")<cr>", "[Y]ank [s]hort [p]ath" },
    ["gyf"]        = { ":let @+=expand("%:p")<cr>", "[Y]ank [f]ull [p]ath" },
    ["<leader>tc"] = { ":tabnew<cr>", "[T]ab [c]reate" },
    ["<leader>tx"] = { ":tabclose<cr>", "[T]ab close [x]" },
    ["<esc>"]      = { ":noh<cr><esc>", "[/] No highlight" },
    ["<leader>oq"] = { ":copen<CR>", "[O]pen [q]uickfix" },
    ["<leader>ol"] = { ":lopen<CR>", "[O]pen [l]ocation list" },
    ["<C-.>"]      = { "" },
    ["<C-w>."]     = { "<C-w>10>" },
    ["<C-w><C-.>"] = { "<C-w>10>" },
    ["<C-w>,"]     = { "<C-w>10<" },
    ["<C-w><C-,>"] = { "<C-w>10<" },
    ["<C-w>-"]     = { "<C-w>5-" },
    ["<C-w>+"]     = { "<C-w>5+" },
    ["<C-w>m"]     = { "<C-w>5+<C-w>15>" },
  },
  i = {
    ["jk"]         = { "<Esc>" },
  },
  t = {
    ["<esc>"]      = { "<c-\\><c-n>"},
    ["jk"]         = { "<c-\\><c-n>"},
  }
}

M.ruby_on_rails = {
  n = {
    ["<leader>rm"] = { ":vsplit | term bin/rails db:migrate RAILS_ENV=development<Cr>" },
    ["<leader>rc"] = { ":vsplit | term rails console<Cr>" }
  }
}

M.term = {
  n = {
    ["<C-/>"] = { "<cmd>lua require("core.term").toggle()<Cr>" }
  },
}

M.diffview = {
  { "<leader>gd", ":DiffviewOpen ", desc = "[G]it [d]iff" },
  { "<leader>cc", "<cmd>lua require("diffview.config").actions.conflict_choose("all")<cr>", desc = "[C]onflict [C]hoose" },
}

M.neogit = {
  { "<leader>gg", ":Neogit<cr>", desc = "[G]it status" },
  { "<leader>gl", ":Neogit log<cr>", desc = "[G]it [l]og" },
  { "<leader>gb", ":Neogit branch<cr>", desc = "[G]it [b]ranch" },
  { "<leader>gc", "<cmd>lua require("neogit").action("branch", "checkout_local_branch")<cr>", desc = "[g]it [c]heckout" },
}

M.grug_far = {
  { "<leader>ss", "<cmd>lua require("grug-far").grug_far()<cr>", desc = "[S]each open" },
  { "<leader>sw", "<cmd>lua require("grug-far").grug_far({ startInInsertMode = false, prefills = { search = vim.fn.expand("<cword>") } })<cr>", desc = "[S]each [w]ord" },
  { "<leader>sw", ":<C-u> lua require("grug-far").with_visual_selection({ startInInsertMode = false })<cr>" , mode = "v", desc = "[S]each [w]ord" },
}

M.oil = {
  { "-", "<cmd>lua require("oil").open()<cr>", desc = "Open parent directory" },
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
  { "gS", "<cmd>lua require("treesj").toggle()<cr>", desc = "Toggle [S]plit/Join" },
  { "gs", "<cmd>lua require("treesj").toggle()<cr>", desc = "Toggle [s]plit/join" },
}

M.harpoon = {
  { "<leader>ha", "<cmd>lua require("harpoon.mark").add_file()<cr>", desc = "[H]arpoon add file" },
  { "<leader>hh", "<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>", desc = "[H]arpoon toggle" },
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
  { "<leader>fg", "<cmd>lua require("fzf-lua").live_grep({  multiline = 2, continue_last_search = true })<cr>", desc = "[f]zf live_[g]rep" },
  { "<leader>fw", "<cmd>FzfLua grep_cword<CR>", mode = "n", desc = "[f]zf grep [w]ord" },
  { "<leader>fw", "<cmd>FzfLua grep_visual<CR>", mode = "v", desc = "[f]zf grep [w]ord" },
  { "<leader>gc", "<cmd>FzfLua git_branches<CR>", desc = "[G]it [c]heckout branch" },
  { "<leader>fr", "<cmd>FzfLua resume<CR>", mode = "n", desc = "[f]zf [r]esum" },
}

M.mini_pick = {
  { "<leader>ff", "<cmd>Pick files<cr>", desc = "" },
  { "<leader>bb", "<cmd>lua MiniPick.registry.sorted_buffers()<cr>", desc = "" },
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
  { "<leader>dt", "<cmd>lua require"dap".toggle_breakpoint()<cr>", desc = "" },
  { "<leader>dc", "<cmd>lua require"dap".continue()<cr>", desc = "" },
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
      require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
    end,
    mode = { "n", "v" },
    desc = "CopilotChat - Prompt actions",
  }
}

M.codecompanion = {
  { "<leader>aa", "<cmd>CodeCompanionAction<Cr>", mode = { "n", "v" } },
}

M.snacks = {
  { "<leader><space>", "<cmd>lua Snacks.picker.smart()<Cr>", desc = "Find Files" },
  { "<leader>,", "<cmd>lua Snacks.picker.buffers()<Cr>", desc = "Buffers" },
  { "<leader>/", "<cmd>lua Snacks.picker.grep()<Cr>", desc = "Grep" },
  { "<leader>:", "<cmd>lua Snacks.picker.command_history()<Cr>", desc = "Command History" }
}

return M

-- others
-- map <silent> <leader><cr> :call OpenFloatTerm()<cr>
-- autocmd Filetype ruby map <leader>rr :!ruby %<cr>
-- autocmd Filetype python map <leader>rr :!python3 %<cr>
-- autocmd Filetype go map <leader>rr :!go run %<cr>
-- vnoremap <leader>rw "hy:%s/<C-r>h//g<left><left>
