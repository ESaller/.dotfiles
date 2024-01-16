function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- TODO: config seems wrong learn how to do it right
return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            --vim.cmd("colorscheme rose-pine")
            --require('rose-pine').setup({
            --    disable_background = true
            --})
            --ColorMyPencils()
        end
    },
    { {
        "tiagovla/tokyodark.nvim",
        opts = {
            -- custom options here
            transparent_background = false,                                        -- set background to transparent
            gamma = 1.00,                                                          -- adjust the brightness of the theme
            styles = {
                comments = { italic = true },                                      -- style for comments
                keywords = { italic = true },                                      -- style for keywords
                identifiers = { italic = true },                                   -- style for identifiers
                functions = {},                                                    -- style for functions
                variables = {},                                                    -- style for variables
            },
            custom_highlights = {} or function(highlights, palette) return {} end, -- extend highlights
            custom_palette = {} or function(palette) return {} end,                -- extend palette
            terminal_colors = false,                                               -- enable terminal colors
        },
        config = function(_, opts)
            require("tokyodark").setup(opts) -- calling setup is optional
            vim.cmd [[colorscheme tokyodark]]
        end,
    } }
}
