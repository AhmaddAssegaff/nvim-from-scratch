return {
    "folke/which-key.nvim",
    -- "nvim-tree/nvim-web-devicons",


    config = function()
        local wk = require("which-key")

        vim.o.timeout = true
        vim.o.timeoutlen = 300

        wk.setup({})

        wk.add({
            { "<leader>f", group = "File" },
            { "<leader>g", group = "Git" },
            { "<leader>e", group = "explore" },
        })
    end
}
