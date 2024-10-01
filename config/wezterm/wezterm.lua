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
  saturation = 0.80,
  brightness = 0.85,
}

config.font = wezterm.font('JetBrains Mono', { weight = 'Medium', italic = false })

local function is_vi_process(pane)
  return pane:get_foreground_process_name():find('n?vim') ~= nil
end

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  { key = 'x', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = 'v', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 's', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
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
  { key = 'w', mods = 'CMD', action = act.CloseCurrentPane { confirm = true } },
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false, timeout_milliseconds = 500 },
  },
  { key = '!', mods = 'LEADER', action = act.PaneSelect { mode = 'MoveToNewTab' } },
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

for i = 1, 8 do
  -- CTRL+CMD + number to move to that position
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL|CMD',
    action = wezterm.action.MoveTab(i - 1),
  })
end

config.key_tables = {
  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize { 'Left', 2 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 2 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 2 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 2 } },
    { key = 'Escape', action = 'PopKeyTable' },
  },
}

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  if is_vi_process(pane) then
    window:perform_action(
      act.SendKey({ key = vim_direction, mods = 'CTRL' }),
      pane
    )
  else
    window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
  end
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

-- and finally, return the configuration to wezterm
return config
