return {
  -- Server Configuration
  port_range = { min = 10000, max = 65535 },
  auto_start = true,
  log_level = "info", -- "trace", "debug", "info", "warn", "error"
  terminal_cmd = nil, -- Custom terminal command (default: "claude")
  -- For local installations: "~/.claude/local/claude"
  -- For native binary: use output from 'which claude'

  -- Send/Focus Behavior
  -- When true, successful sends will focus the Claude terminal if already connected
  focus_after_send = false,

  -- Selection Tracking
  track_selection = true,
  visual_demotion_delay_ms = 50,

  -- Terminal Configuration
  terminal = {
    split_side = "right", -- "left" or "right"
    split_width_percentage = 0.30,
    provider = "native", -- "auto", "snacks", "native", "external", "none", or custom provider table
    snacks_win_opts = {},
    -- Provider-specific options
    provider_opts = {
      -- Command for external terminal provider. Can be:
      -- 1. String with %s placeholder: "alacritty -e %s" (backward compatible)
      -- 2. String with two %s placeholders: "alacritty --working-directory %s -e %s" (cwd, command)
      -- 3. Function returning command: function(cmd, env) return "alacritty -e " .. cmd end
      external_terminal_cmd = nil,
    },
  },

  -- Diff Integration
  diff_opts = {
    auto_close_on_accept = true,
    layout = "vertical",
    open_in_new_tab = false,
    keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
  },
}
