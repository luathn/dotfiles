local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.use_fancy_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_decorations = "RESIZE"

config.color_scheme = 'Catppuccin Latte'

-- config.enable_kitty_keyboard = true
-- config.enable_csi_u_key_encoding = false

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.9,
}

config.font = wezterm.font('JetBrains Mono', { weight = 'Medium', italic = false })

local function isViProcess(pane)
  -- get_foreground_process_name On Linux, macOS and Windows, 
  -- the process can be queried to determine this path. Other operating systems 
  -- (notably, FreeBSD and other unix systems) are not currently supported
  return pane:get_foreground_process_name():find('n?vim') ~= nil
  -- return pane:get_title():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  if isViProcess(pane) then
    window:perform_action(
      -- This should match the keybinds you set in Neovim.
      act.SendKey({ key = vim_direction, mods = 'CTRL' }),
      pane
    )
  else
    window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
  end
end

local super_vim_keys_map = {
  s = utf8.char(0xAA),
  x = utf8.char(0xAB),
  b = utf8.char(0xAC),
  ['.'] = utf8.char(0xAD),
  o = utf8.char(0xAF),
}

local function bind_super_key_to_vim(key)
  return {
    key = key,
    mods = 'CMD',
    action = wezterm.action_callback(function(win, pane)
      local char = super_vim_keys_map[key]
      if char and isViProcess(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
        SendKey = { key = char, mods = nil },
        }, pane)
      else
        win:perform_action({
          SendKey = {
            key = key,
            mods = 'CMD'
          }
        }, pane)
      end
    end)
  }
end


wezterm.on('ActivatePaneDirection-right', function(window, pane)
  conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
  conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
  conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
  conditionalActivatePane(window, pane, 'Down', 'j')
end)

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  { key = 'v', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 's', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = "LEADER", action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = "LEADER", action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = "LEADER", action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = "LEADER", action = act.ActivatePaneDirection 'Right' },
  { key = 'h', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-left') },
  { key = 'j', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-down') },
  { key = 'k', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-up') },
  { key = 'l', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-right') },
  { key = 'H', mods = 'LEADER', action = act.AdjustPaneSize { 'Left', 2 }, },
  { key = 'J', mods = 'LEADER', action = act.AdjustPaneSize { 'Down', 2 } },
  { key = 'K', mods = 'LEADER', action = act.AdjustPaneSize { 'Up', 2 } },
  { key = 'L', mods = 'LEADER', action = act.AdjustPaneSize { 'Right', 2 } },
  { key = 'f', mods = 'LEADER', action = act.TogglePaneZoomState },
  { key = 'z', mods = 'LEADER', action = act.ToggleFullScreen },
  { key = '/', mods = 'LEADER', action = act.Search { CaseInSensitiveString = '' } },
  { key = 'w', mods = 'LEADER', action = act.PaneSelect { mode = 'SwapWithActive' } },
  { key = '[', mods = 'LEADER', action = act.MoveTabRelative(-1) },
  { key = ']', mods = 'LEADER', action = act.MoveTabRelative(1) },
  { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentPane { confirm = true } },
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false, timeout_milliseconds = 500 },
  },
  -- { key = '!', mods = 'LEADER', action = act.PaneSelect { mode = 'MoveToNewTab' } },
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, _, line)
        -- _ is pane
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  bind_super_key_to_vim("x"),
}

config.key_tables = {
  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize { 'Left', 2 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 2 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 2 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 2 } },
    { key = 'Escape', action = 'PopKeyTable' },
  },
}

-- and finally, return the configuration to wezterm
return config
