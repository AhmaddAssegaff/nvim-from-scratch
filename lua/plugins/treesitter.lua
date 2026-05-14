return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,

    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },

    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",

          "javascript",
          "typescript",
          "tsx",

          "html",
          "css",
          "json",
          "yaml",

          "bash",
          "markdown",
          "markdown_inline",

          "gitignore",

          "go",
          "rust",
          "python",
        },

        highlight = {
          enable = true,
        },

        indent = {
          enable = true,
        },
      })

      local ts_select =
        require("nvim-treesitter-textobjects.select")

      local opts = {
        silent = true,
      }

      -- FUNCTIONS
      vim.keymap.set({ "o", "x" }, "af", function()
        ts_select.select_textobject(
          "@function.outer",
          "textobjects"
        )
      end, opts)

      vim.keymap.set({ "o", "x" }, "if", function()
        ts_select.select_textobject(
          "@function.inner",
          "textobjects"
        )
      end, opts)

      -- CLASSES
      vim.keymap.set({ "o", "x" }, "ac", function()
        ts_select.select_textobject(
          "@class.outer",
          "textobjects"
        )
      end, opts)

      vim.keymap.set({ "o", "x" }, "ic", function()
        ts_select.select_textobject(
          "@class.inner",
          "textobjects"
        )
      end, opts)

      -- PARAMETERS
      vim.keymap.set({ "o", "x" }, "aa", function()
        ts_select.select_textobject(
          "@parameter.outer",
          "textobjects"
        )
      end, opts)

      vim.keymap.set({ "o", "x" }, "ia", function()
        ts_select.select_textobject(
          "@parameter.inner",
          "textobjects"
        )
      end, opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = false,
  },
}
