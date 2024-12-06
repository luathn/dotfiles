local wezterm = require 'wezterm'
local act = wezterm.action
local utils = require 'utils'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config = {
  -- UI
  use_fancy_tab_bar = false,
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
  window_decorations = "RESIZE",
  -- hide_tab_bar_if_only_one_tab = true,
  color_scheme = 'Catppuccin Frappe',
  inactive_pane_hsb = { saturation = 0.80, brightness = 0.85 },
  font = wezterm.font('JetBrains Mono', { weight = 'Medium', italic = false }),
  font_size = 13,
}

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  { key = 'a', mods = 'LEADER|CTRL', action = act.SendKey({ key = 'a', mods = 'CTRL' }) },
  { key = 'Enter', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = 'v', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 's', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-left') },
  { key = 'j', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-down') },
  { key = 'k', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-up') },
  { key = 'l', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-right') },
  { key = 'f', mods = 'LEADER', action = act.TogglePaneZoomState },
  { key = 'z', mods = 'LEADER', action = act.ToggleFullScreen },
  { key = '/', mods = 'LEADER', action = act.Search { CaseInSensitiveString = 'hash' } },
  { key = 'm', mods = 'LEADER', action = act.PaneSelect { mode = 'SwapWithActiveKeepFocus' } },
  { key = '[', mods = 'LEADER', action = act.MoveTabRelative(-1) },
  { key = ']', mods = 'LEADER', action = act.MoveTabRelative(1) },
  { key = 'w', mods = 'CMD', action = act.CloseCurrentPane { confirm = true } },
  { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false, timeout_milliseconds = 500 } },
  { key = '!', mods = 'LEADER', action = act.PaneSelect { mode = 'MoveToNewTab' } },
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  {
    key = '.',
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
  -- { key = 'l', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action_callback(function(window, pane)
      local choices = {}
      local workspace_names = wezterm.mux.get_workspace_names()
      for _, name in ipairs(workspace_names) do
        table.insert(choices, { label = name })
      end

      window:perform_action(
        act.InputSelector {
          action = wezterm.action_callback(
            function(_, _, _, label)
              wezterm.mux.set_active_workspace(label)
            end
          ),
          title = 'Choose Workspace',
          choices = choices,
          fuzzy = true,
          fuzzy_description = 'Switch to workspace: ',
        },
        pane
      )
    end),
  },
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Rename workspace',
      action = wezterm.action_callback(function(_, _, line)
        if line then
          wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
        end
      end),
    },
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter name for new workspace',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
        end
      end),
    },
  },
  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action_callback(function(window, pane)
      local choices = {}
      local workspace_names = wezterm.mux.get_workspace_names()
      for _, name in ipairs(workspace_names) do
        table.insert(choices, { label = name })
      end

      window:perform_action(
        act.InputSelector {
          action = wezterm.action_callback(
            function(_, _, _, label)
              utils.kill_workspace(label)
            end
          ),
          title = 'Choose Workspace',
          choices = choices,
          fuzzy = true,
          fuzzy_description = 'Kill workspace: ',
        },
        pane
      )
    end),
  },
}

-- CTRL+CMD + number to move to that position
for i = 1, 8 do
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
  search_mode = {
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
    { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
    { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
    { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
    { key = 'w', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
  }
}

local function is_vi_process(pane)
  return pane:get_foreground_process_name():find('n?vim') ~= nil
end

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

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

return config
