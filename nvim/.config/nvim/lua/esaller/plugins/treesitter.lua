return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        config = function()
            local ts = require('nvim-treesitter')
            local parsers = {
                "vimdoc", "javascript", "typescript", "css", "c",
                "lua", "rust", "python", "markdown", "dockerfile", "bash"
            }
            for _, parser in ipairs(parsers) do
                ts.install(parser)
            end
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
    },
}
