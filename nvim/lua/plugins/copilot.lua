return {
  -- Copilot core (ghost-text inline suggestions)
  {
    "zbirenbaum/copilot.lua",
    cmd   = "Copilot",
    event = "InsertEnter",
    opts  = {
      suggestion = { enabled = false }, -- handled by copilot-cmp instead
      panel      = { enabled = false },
      copilot_model = "claude-sonnet-4-5", -- use Claude via Copilot
    },
  },

  -- nvim-cmp source for Copilot suggestions
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
