return {
    {
        -- Mason: install/manage LSP servers
        "mason-org/mason.nvim",
        tag = "v2.0.1",    -- was v1.11.0; v2 requires Neovim >= 0.10
        pin = true,
        lazy = false,
        opts = {},
    },
    {
        -- mason-lspconfig v2: handlers + automatic_installation removed.
        -- Servers are auto-enabled via automatic_enable = true (the default).
        "mason-org/mason-lspconfig.nvim",
        tag = "v2.1.0",    -- was v1.32.0
        pin = true,
        lazy = true,
        config = false, -- configured inside nvim-lspconfig's config below
    },
    {
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                sources = {
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip", keyword_length = 2 },
                    { name = "buffer",  keyword_length = 3 },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"]     = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"]     = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
            })
        end,
    },
    {
        -- LSP configs (just data: filetypes, root markers, default settings)
        -- v2.6.0+ requires Neovim 0.11.3+; require('lspconfig') is fully deprecated.
        "neovim/nvim-lspconfig",
        tag = "v2.6.0",    -- was v1.8.0
        pin = true,
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "mason-org/mason.nvim" },
            { "mason-org/mason-lspconfig.nvim" },
        },
        config = function()
            -- Avoid layout shift from diagnostic signs appearing
            vim.opt.signcolumn = "yes"

            -- Apply cmp capabilities to ALL servers via the wildcard config
            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            -- lua_ls: Neovim-specific settings (must be set before servers are enabled)
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                    },
                },
            })

            -- nil_ls is NOT in ensure_installed (installed via Nix / on PATH),
            -- so mason-lspconfig's automatic_enable won't touch it.
            -- Enable it directly here instead.
            vim.lsp.enable("nil_ls")

            -- Keymaps for when an LSP attaches to a buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf, remap = false }
                    vim.keymap.set("n", "gd",           function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "gD",           function() vim.lsp.buf.declaration() end, opts)
                    vim.keymap.set("n", "gi",           function() vim.lsp.buf.implementation() end, opts)
                    vim.keymap.set("n", "go",           function() vim.lsp.buf.type_definition() end, opts)
                    vim.keymap.set("n", "K",            function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>vws",  function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set("n", "<leader>vd",   function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set("n", "[d",           function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set("n", "]d",           function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "<leader>vca",  function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<leader>vrr",  function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "<leader>vrn",  function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("i", "<C-h>",        function() vim.lsp.buf.signature_help() end, opts)
                end,
            })

            -- Mason: install servers automatically.
            -- In v2, automatic_enable = true (default) replaces the old handlers block.
            -- Mason-lspconfig will call vim.lsp.enable() for each installed server.
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "angularls",
                    "ast_grep",
                    "bashls",
                    "biome",
                    "cssls",
                    "docker_compose_language_service",
                    "dockerls",
                    "html",
                    "jedi_language_server",
                    "ltex",
                    "lua_ls",
                    "marksman",
                    -- nil_ls excluded: install via Nix (pkgs.nil)
                    "rust_analyzer",
                    "sqlls",
                    "terraformls",
                },
                automatic_enable = true, -- default; calls vim.lsp.enable() for each installed server
            })
        end,
    },
}
