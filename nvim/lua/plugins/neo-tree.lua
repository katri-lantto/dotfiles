return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- file icons
      "MunifTanjim/nui.nvim",
    },
    lazy = false, -- load on startup so the tree is always available
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>",                desc = "Toggle file explorer" },
      { "<leader>o", "<cmd>Neotree focus<cr>",                 desc = "Focus file explorer" },
      { "<leader>E", "<cmd>Neotree reveal<cr>",                desc = "Reveal current file in explorer" },
    },
    opts = {
      close_if_last_window = true, -- close nvim when neo-tree is the last window
      popup_border_style = "rounded",

      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          with_expanders = true, -- show expand/collapse icons on dirs
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
        },
        git_status = {
          symbols = {
            added     = "",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁕",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          },
        },
      },

      window = {
        position = "left",
        width = 35,
        mappings = {
          ["<space>"] = "none", -- don't steal leader
          ["P"]       = { "toggle_preview", config = { use_float = true } },
          ["l"]       = "focus_preview",
          ["<cr>"]    = "open",
          ["S"]       = "open_split",
          ["s"]       = "open_vsplit",
          ["t"]       = "open_tabnew",
          ["z"]       = "close_all_nodes",
          ["Z"]       = "expand_all_nodes",
          ["R"]       = "refresh",
          ["a"]       = { "add", config = { show_path = "relative" } },
          ["d"]       = "delete",
          ["r"]       = "rename",
          ["y"]       = "copy_to_clipboard",
          ["x"]       = "cut_to_clipboard",
          ["p"]       = "paste_from_clipboard",
          ["c"]       = "copy",
          ["m"]       = "move",
          ["q"]       = "close_window",
          ["?"]       = "show_help",
        },
      },

      filesystem = {
        filtered_items = {
          visible = false,       -- hidden files are hidden by default
          hide_dotfiles = false, -- show dotfiles (e.g. .env, .gitignore)
          hide_gitignored = true,
          hide_by_name = { ".DS_Store", "thumbs.db" },
        },
        follow_current_file = {
          enabled = true,        -- auto-expand tree to the current buffer's file
        },
        group_empty_dirs = true, -- collapse a/b/c into a/b/c when b is empty
        use_libuv_file_watcher = true, -- auto-refresh on external changes
      },

      buffers = {
        follow_current_file = { enabled = true },
      },
    },
  },
}
