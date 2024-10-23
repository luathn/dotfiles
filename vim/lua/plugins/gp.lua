require("gp").setup({
  hooks = {
    -- example of adding command which writes unit tests for the selected code
    UnitTests = function(gp, params)
      local template = "I have the following code:\n\n"
      .. "```{{selection}}\n```\n\n"
      .. "Please respond by writing unit tests for the code above using Rspec."
      local agent = gp.get_command_agent()
      gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
    end,
  },
})
