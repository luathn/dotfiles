local M = {}
local wezterm = require 'wezterm'

local filter = function(tbl, callback)
  local filt_table = {}

  for i, v in ipairs(tbl) do
    if callback(v, i) then
      table.insert(filt_table, v)
    end
  end
  return filt_table
end

M.kill_workspace = function(workspace)
  local success, stdout =
  wezterm.run_child_process({ "/opt/homebrew/bin/wezterm", "cli", "list", "--format=json" })

  if success then
    local json = wezterm.json_parse(stdout)
    if not json then
      return
    end

    local workspace_panes = filter(json, function(p)
      return p.workspace == workspace
    end)

    for _, p in ipairs(workspace_panes) do
      wezterm.run_child_process({
        "/opt/homebrew/bin/wezterm",
        "cli",
        "kill-pane",
        "--pane-id=" .. p.pane_id,
      })
    end
  end
end

return M
