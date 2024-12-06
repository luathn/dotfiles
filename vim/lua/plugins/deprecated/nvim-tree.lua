local tree_cb = require"nvim-tree.config".nvim_tree_callback

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local bulk_trash = function()
    local nodes = api.marks.list()
    if next(nodes) == nil then
      table.insert(nodes, api.get_node_under_cursor())
    end
    vim.ui.input({ prompt = string.format("Trash %s files? [y/n] ", #nodes) }, function(input)
      if input == "y" then
        for _, node in ipairs(nodes) do
          api.fs.trash(node)
        end
        api.tree.reload()
      end
    end)
  end

  -- My mappings
  vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit,            opts("Open"))
  vim.keymap.set("n", "o",     api.tree.change_root_to_node,          opts("CD"))
  vim.keymap.set("n", "i",     api.tree.change_root_to_parent,        opts("Up"))
  vim.keymap.set("n", "-",     api.tree.change_root_to_parent,        opts("Up"))
  vim.keymap.set("n", "<C-t>", api.node.open.tab,                     opts("Open: New Tab"))
  vim.keymap.set("n", "<C-v>", api.node.open.vertical,                opts("Open: Vertical Split"))
  vim.keymap.set("n", "<C-s>", api.node.open.horizontal,              opts("Open: Horizontal Split"))
  vim.keymap.set("n", "l",     api.node.open.edit,                    opts("Open"))
  vim.keymap.set("n", "<CR>",  api.node.open.edit,                    opts("Open"))
  vim.keymap.set("n", "<BS>",  api.node.navigate.parent_close,        opts("Close Directory"))
  vim.keymap.set("n", "h",     api.node.navigate.parent_close,        opts("Close Directory"))
  vim.keymap.set("n", "a",     api.fs.create,                         opts("Create"))
  vim.keymap.set("n", "c",     api.fs.copy.node,                      opts("Copy"))
  vim.keymap.set("n", "d",     api.fs.remove,                         opts("Delete"))
  vim.keymap.set("n", "x",     api.fs.cut,                            opts("Cut"))
  vim.keymap.set("n", "p",     api.fs.paste,                          opts("Paste"))
  vim.keymap.set("n", "r",     api.fs.rename,                         opts("Rename"))
  vim.keymap.set("n", "R",     api.fs.rename_sub,                     opts("Rename: Omit Filename"))
  vim.keymap.set("n", "gy",    api.fs.copy.absolute_path,             opts("Copy Absolute Path"))
  vim.keymap.set("n", "y",     api.fs.copy.filename,                  opts("Copy Name"))
  vim.keymap.set("n", "Y",     api.fs.copy.relative_path,             opts("Copy Relative Path"))
  vim.keymap.set("n", "H",     api.tree.toggle_hidden_filter,         opts("Toggle Dotfiles"))
  vim.keymap.set("n", "I",     api.tree.toggle_gitignore_filter,      opts("Toggle Git Ignore"))
  vim.keymap.set("n", "m",     api.marks.toggle,                      opts("Toggle Bookmark"))
  vim.keymap.set("n", "S",     api.tree.search_node,                  opts("Search"))
  vim.keymap.set("n", "B",     api.tree.toggle_no_buffer_filter,      opts("Toggle No Buffer"))
  vim.keymap.set("n", "E",     api.tree.expand_all,                   opts("Expand All"))
  vim.keymap.set("n", "W",     api.tree.collapse_all,                 opts("Collapse"))
  vim.keymap.set("n", "<C-r>", api.tree.reload,                       opts("Refresh"))
  vim.keymap.set("n", "g?",    api.tree.toggle_help,                  opts("Help"))
  vim.keymap.set("n", "q",     api.tree.close,                        opts("Close"))
  vim.keymap.set("n", "bx",    api.marks.bulk.move,                   opts("Move Bookmarked"))
  vim.keymap.set("n", "bd",    bulk_trash,                            opts("Bulk Trash Files"))

  -- BEGIN_DEFAULT_ON_ATTACH
  vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer,     opts("Open: In Place"))
  vim.keymap.set("n", "<C-k>", api.node.show_info_popup,              opts("Info"))
  vim.keymap.set("n", "<Tab>", api.node.open.preview,                 opts("Open Preview"))
  vim.keymap.set("n", ">",     api.node.navigate.sibling.next,        opts("Next Sibling"))
  vim.keymap.set("n", "<",     api.node.navigate.sibling.prev,        opts("Previous Sibling"))
  vim.keymap.set("n", "J",     api.node.navigate.sibling.last,        opts("Last Sibling"))
  vim.keymap.set("n", "K",     api.node.navigate.sibling.first,       opts("First Sibling"))
  vim.keymap.set("n", ".",     api.node.run.cmd,                      opts("Run Command"))
  vim.keymap.set("n", "C",     api.tree.toggle_git_clean_filter,      opts("Toggle Git Clean"))
  vim.keymap.set("n", "[c",    api.node.navigate.git.prev,            opts("Prev Git"))
  vim.keymap.set("n", "]c",    api.node.navigate.git.next,            opts("Next Git"))
  vim.keymap.set("n", "D",     api.fs.trash,                          opts("Trash"))
  vim.keymap.set("n", "e",     api.fs.rename_basename,                opts("Rename: Basename"))
  vim.keymap.set("n", "]e",    api.node.navigate.diagnostics.next,    opts("Next Diagnostic"))
  vim.keymap.set("n", "[e",    api.node.navigate.diagnostics.prev,    opts("Prev Diagnostic"))
  vim.keymap.set("n", "F",     api.live_filter.clear,                 opts("Clean Filter"))
  vim.keymap.set("n", "f",     api.live_filter.start,                 opts("Filter"))
  vim.keymap.set("n", "O",     api.node.open.no_window_picker,        opts("Open: No Window Picker"))
  vim.keymap.set("n", "P",     api.node.navigate.parent,              opts("Parent Directory"))
  vim.keymap.set("n", "s",     api.node.run.system,                   opts("Run System"))
  vim.keymap.set("n", "U",     api.tree.toggle_custom_filter,         opts("Toggle Hidden"))
  -- END_DEFAULT_ON_ATTACH
end

require"nvim-tree".setup {
  on_attach = on_attach,
  disable_netrw       = true,
  hijack_netrw        = true,
  auto_reload_on_write = true,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  hijack_unnamed_buffer_when_opening = false,
  create_in_closed_folder = false,
  sort_by = "name",
  root_dirs = {},
  prefer_startup_root = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  ui = {
    confirm = {
      remove = true,
      trash = false,
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        item = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  hijack_directories   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = { "node_modules", ".cache" }
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 55,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", },
          buftype  = { "nofile", "terminal", "help", },
        }
      }
    }
  }
}
