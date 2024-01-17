return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependecies = {
        {
            "nvim-lua/plenary.nvim"
        }
    },
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", function()
            require("telescope.builtin").find_files({
                find_command = { "rg", "--hidden", "--files", "--glob", "!.git" },
            })
        end, {})
        vim.keymap.set("n", "<C-p>", builtin.git_files, {})
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    end,

}
