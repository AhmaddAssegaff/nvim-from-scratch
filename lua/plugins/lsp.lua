return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "stevearc/conform.nvim",

      "williamboman/mason.nvim",
      "mason-org/mason-lspconfig.nvim",

      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",

      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      "j-hui/fidget.nvim",
    },

    config = function()
      ----------------------------------------------------------------
      -- CONFORM
      ----------------------------------------------------------------

      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          go = { "gofmt" },
          rust = { "rustfmt" },
          javascript = { "prettier" },
          typescript = { "prettier" },
        },
      })

      ----------------------------------------------------------------
      -- CMP
      ----------------------------------------------------------------

      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),

          ["<C-y>"] = cmp.mapping.confirm({
            select = true,
          }),

          ["<C-Space>"] = cmp.mapping.complete(),
        }),

        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })

      ----------------------------------------------------------------
      -- CAPABILITIES
      ----------------------------------------------------------------

      local capabilities =
        require("cmp_nvim_lsp").default_capabilities()

      ----------------------------------------------------------------
      -- UI
      ----------------------------------------------------------------

      require("fidget").setup({})

      vim.diagnostic.config({
        float = {
          border = "rounded",
          source = true,
        },
      })

      ----------------------------------------------------------------
      -- MASON
      ----------------------------------------------------------------

      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "gopls",
          "rust_analyzer",
          "vtsls",
          "tailwindcss",
          "basedpyright",
          "ruff",
        },
      })

      ----------------------------------------------------------------
      -- LSP
      ----------------------------------------------------------------

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,

        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },

            diagnostics = {
              globals = { "vim" },
            },

            workspace = {
              library =
                vim.api.nvim_get_runtime_file("", true),

              checkThirdParty = false,
            },

            format = {
              enable = true,
            },
          },
        },
      })

      vim.lsp.config("gopls", {
        capabilities = capabilities,
      })

      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
      })

      vim.lsp.config("vtsls", {
        capabilities = capabilities,
      })

      vim.lsp.config("tailwindcss", {
        capabilities = capabilities,

        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
        },
      })

      vim.lsp.config("basedpyright", {
        capabilities = capabilities,
      })

      vim.lsp.config("ruff", {
        capabilities = capabilities,
      })

      ----------------------------------------------------------------
      -- ENABLE
      ----------------------------------------------------------------

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("gopls")
      vim.lsp.enable("rust_analyzer")
      vim.lsp.enable("vtsls")
      vim.lsp.enable("tailwindcss")

      ----------------------------------------------------------------
      -- KEYMAPS
      ----------------------------------------------------------------

      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "gr", vim.lsp.buf.references)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({
          async = true,
          lsp_fallback = true,
        })
      end)
    end,
  },
}
