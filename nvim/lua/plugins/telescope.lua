return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      -- native fzf sorter for significantly faster fuzzy matching
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable("make") == 1 end,
      },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",              desc = "Find files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                desc = "Recent files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",               desc = "Live grep" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>",             desc = "Grep word under cursor" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",                 desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",               desc = "Help tags" },
      { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy search buffer" },
    },
    config = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix   = "  ",
          selection_caret = " ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            width = 0.87,
            height = 0.80,
          },
          file_ignore_patterns = { "%.git/", "node_modules/", "%.DS_Store" },
          mappings = {
            i = {
              ["<C-j>"]  = actions.move_selection_next,
              ["<C-k>"]  = actions.move_selection_previous,
              ["<C-u>"]  = false, -- clear prompt instead of scroll preview
              ["<C-d>"]  = actions.delete_buffer,
              ["<esc>"]  = actions.close,
            },
          },
        },
        pickers = {
          find_files = { hidden = true },     -- include dotfiles
          buffers    = { sort_mru = true },   -- most recently used first
        },
      })

      -- load fzf native if available
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
