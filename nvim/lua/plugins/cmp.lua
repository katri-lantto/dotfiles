return {
  -- Snippet engine (required by nvim-cmp)
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",  -- optional: improves some snippet transforms
    dependencies = {
      "rafamadriz/friendly-snippets", -- community snippet collection
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load() -- load friendly-snippets
    end,
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP source
      "hrsh7th/cmp-buffer",       -- buffer words source
      "hrsh7th/cmp-path",         -- filesystem path source
      "saadparwaiz1/cmp_luasnip", -- snippet source
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-j>"]     = cmp.mapping.select_next_item(),
          ["<C-k>"]     = cmp.mapping.select_prev_item(),
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),        -- manually trigger
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<CR>"]      = cmp.mapping.confirm({ select = false }), -- only confirm explicit selection
          -- Tab: expand or jump snippet, else move to next item
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- highest priority: LSP
          { name = "luasnip" },  -- snippets
          { name = "buffer" },   -- words in open buffers
          { name = "path" },     -- file paths
        }),

        -- show source name in the completion menu
        formatting = {
          format = function(entry, item)
            local labels = {
              nvim_lsp = "[LSP]",
              luasnip  = "[Snip]",
              buffer   = "[Buf]",
              path     = "[Path]",
            }
            item.menu = labels[entry.source.name] or ""
            return item
          end,
        },
      })
    end,
  },
}
