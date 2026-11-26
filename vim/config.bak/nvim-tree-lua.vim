" Mappings
nnoremap <silent> <leader>oe :NvimTreeToggle<CR>
nnoremap <silent> <leader>mr :NvimTreeRefresh<CR>
nnoremap <silent> <leader>mf :NvimTreeFindFile<CR>

:lua <<EOF
  local tree_cb = require'nvim-tree.config'.nvim_tree_callback

  require'nvim-tree'.setup {
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_setup       = false,
    ignore_buffer_on_setup = false,
    ignore_ft_on_setup  = {},
    auto_reload_on_write = true,
    open_on_tab         = false,
    hijack_cursor       = false,
    update_cwd          = false,
    hijack_unnamed_buffer_when_opening = false,
    create_in_closed_folder = false,
    open_on_setup_file = false,
    sort_by = "name",
    root_dirs = {},
    prefer_startup_root = false,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
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
      custom = { '.git', 'node_modules', '.cache' }
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    view = {
      adaptive_size = false,
      centralize_selection = false,
      width = 35,
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
      mappings = {
        custom_only = false,
        list = {
          { key = { "<2-RightMouse>", "o" },      cb = tree_cb("cd") },
          { key = { "i", "-" },                   cb = tree_cb("dir_up") },
          { key = { "l", "<2-LeftMouse>" },       cb = tree_cb("edit") },
          { key = "<C-v>",                        cb = tree_cb("vsplit") },
          { key = "<C-x>",                        cb = tree_cb("split") },
          { key = "<C-t>",                        cb = tree_cb("tabnew") },
          { key = "<",                            cb = tree_cb("prev_sibling") },
          { key = ">",                            cb = tree_cb("next_sibling") },
          { key = "P",                            cb = tree_cb("parent_node") },
          { key = { "<BS>", "h" },                cb = tree_cb("close_node") },
          { key = "<Tab>",                        cb = tree_cb("preview") },
          { key = "K",                            cb = tree_cb("first_sibling") },
          { key = "J",                            cb = tree_cb("last_sibling") },
          { key = "I",                            cb = tree_cb("toggle_ignored") },
          { key = "H",                            cb = tree_cb("toggle_dotfiles") },
          { key = "<C-r>",                        cb = tree_cb("refresh") },
          { key = "m",                            cb = tree_cb("create") },
          { key = "d",                            cb = tree_cb("remove") },
          { key = "r",                            cb = tree_cb("rename") },
          { key = "R",                            cb = tree_cb("full_rename") },
          { key = "x",                            cb = tree_cb("cut") },
          { key = "c",                            cb = tree_cb("copy") },
          { key = "p",                            cb = tree_cb("paste") },
          { key = "y",                            cb = tree_cb("copy_name") },
          { key = "Y",                            cb = tree_cb("copy_path") },
          { key = "gy",                           cb = tree_cb("copy_absolute_path") },
          { key = "[c",                           cb = tree_cb("prev_git_item") },
          { key = "]c",                           cb = tree_cb("next_git_item") },
          { key = "q",                            cb = tree_cb("close") },
          { key = "g?",                           cb = tree_cb("toggle_help") },
        }
      }
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
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
            buftype  = { "nofile", "terminal", "help", },
          }
        }
      }
    }
  }
EOF
