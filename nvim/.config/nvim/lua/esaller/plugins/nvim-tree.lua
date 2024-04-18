return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            }, }

        vim.keymap.set("n", "<leader>pt", ':NvimTreeToggle<CR>')
        vim.keymap.set("n", "<leader>ptf", ':NvimTreeFindFile<CR>')
    end,
}
