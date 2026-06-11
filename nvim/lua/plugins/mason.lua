return {
  -- Mason: installs LSP servers, linters, formatters
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Bridges mason with lspconfig so installed servers auto-configure
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",        -- Lua
        "pyright",       -- Python
        "rust_analyzer", -- Rust
        "clangd",        -- C / C++
        "ts_ls",         -- TypeScript / JavaScript
        "bashls",        -- Bash
        "html",          -- HTML
        "cssls",         -- CSS
        "marksman",      -- Markdown
      },
      automatic_installation = true,
    },
  },

  -- Bridges mason with null-ls/none-ls for linters & formatters
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = {
      ensure_installed = {
        -- Python
        "ruff",          -- linter + formatter
        -- Lua
        "stylua",        -- formatter
        -- C / C++
        "clang-format",  -- formatter
        -- TypeScript / JS
        "eslint_d",      -- linter
        "prettierd",     -- formatter (html, css, ts, md, json)
        -- Bash
        "shellcheck",    -- linter
        "shfmt",         -- formatter
      },
      automatic_installation = true,
    },
  },

  -- none-ls: hooks linters/formatters into the LSP diagnostics pipeline
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Python
          null_ls.builtins.diagnostics.ruff,
          null_ls.builtins.formatting.ruff_format,

          -- Lua
          null_ls.builtins.formatting.stylua,

          -- C / C++
          null_ls.builtins.formatting.clang_format,

          -- TypeScript / JS / HTML / CSS / Markdown
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.formatting.prettierd,

          -- Bash
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.shfmt,
        },
      })
    end,
  },

  -- nvim-lspconfig: provides server default configs (cmd, filetypes, root detection)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- advertise completion capabilities to servers
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keymaps set whenever any LSP attaches to a buffer (replaces on_attach)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
          end

          map("gd",         vim.lsp.buf.definition,                            "Go to definition")
          map("gD",         vim.lsp.buf.declaration,                           "Go to declaration")
          map("gr",         vim.lsp.buf.references,                            "References")
          map("gi",         vim.lsp.buf.implementation,                        "Go to implementation")
          map("K",          vim.lsp.buf.hover,                                 "Hover docs")
          map("<leader>rn", vim.lsp.buf.rename,                                "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action,                           "Code action")
          map("<leader>f",  function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
          map("[d",         vim.diagnostic.goto_prev,                          "Previous diagnostic")
          map("]d",         vim.diagnostic.goto_next,                          "Next diagnostic")
          map("<leader>d",  vim.diagnostic.open_float,                         "Show diagnostic float")
        end,
      })

      -- Diagnostic display
      vim.diagnostic.config({
        virtual_text     = true,
        signs            = true,
        underline        = true,
        update_in_insert = false,
        severity_sort    = true,
      })

      -- Per-server settings via the new 0.11 API
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime     = { version = "LuaJIT" },
            workspace   = { checkThirdParty = false },
            telemetry   = { enable = false },
            diagnostics = { globals = { "vim" } }, -- silence 'vim' undefined warnings
          },
        },
      })

      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          python = { analysis = { typeCheckingMode = "standard" } },
        },
      })

      -- Remaining servers: only need capabilities injected
      for _, server in ipairs({ "rust_analyzer", "clangd", "ts_ls", "bashls", "html", "cssls", "marksman" }) do
        vim.lsp.config(server, { capabilities = capabilities })
      end

      -- Enable all servers (mason-lspconfig's automatic_enable also does this for
      -- mason-installed servers, but being explicit here keeps things self-contained)
      vim.lsp.enable({
        "lua_ls", "pyright", "rust_analyzer", "clangd", "ts_ls",
        "bashls", "html", "cssls", "marksman",
      })
    end,
  },
}
