return {
    'renerocksai/telekasten.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
        local home_dir = vim.fn.expand("~/notes")
        local time_dir = home_dir .. "/time"
        local current_year = os.date("%Y")
        -- local current_week = os.date("%V") -- %V gives ISO week number
        --
        require('telekasten').setup({


            home = home_dir,
            dailies = time_dir .. "/" .. current_year,
            weeklies = time_dir .. "/" .. current_year,
            templates = home_dir .. "/templates",
            template_new_weekly = home_dir .. "/templates/weekly.md",
            template_new_daily = home_dir .. "/templates/daily.md",
            new_note_location = "prefer_home",

            extension = ".md",
            uuid_type = "%Y%m%d%H%M",
            new_note_filename = "title-uuid",
            filename_space_subst = "_",
            sort = "modified",
            tag_notation = "#tag"


        })

        -- Launch panel if nothing is typed after <leader>z
        vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")

        -- Most used functions
        vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
        vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
        vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
        vim.keymap.set("n", "<leader>zw", "<cmd>Telekasten goto_thisweek<CR>")
        vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
        vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
        vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>")
        vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
        vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")
        vim.keymap.set("n", "<leader>zt", "<cmd>Telekasten toggle_todo<CR>")

        -- Call insert link automatically when we start typing a link
        vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")
    end

}
