return {
    {
        "folke/sidekick.nvim",
        opts = {
            -- add any options here
            cli = {
                mux = {
                    backend = "zellij",
                    enabled = true,
                },
            },
        },
        keys = {
            {
                "<tab>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>" -- fallback to normal tab
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                "<c-.>",
                function()
                    require("sidekick.cli").focus()
                end,
                desc = "Sidekick Switch Focus",
                mode = { "n", "v" },
            },
            {
                "<leader>k",
                function()
                    require("sidekick.cli").toggle({ focus = true })
                end,
                desc = "Sidekick Toggle CLI",
                mode = { "n", "v" },
            },
            {
                "<leader>ac",
                function()
                    require("sidekick.cli").toggle({ name = "claude", focus = true })
                end,
                desc = "Sidekick Claude Toggle",
                mode = { "n", "v" },
            },
            {
                "<leader>ag",
                function()
                    require("sidekick.cli").toggle({ name = "grok", focus = true })
                end,
                desc = "Sidekick Grok Toggle",
                mode = { "n", "v" },
            },
            {
                "<leader>ap",
                function()
                    require("sidekick.cli").select_prompt()
                end,
                desc = "Sidekick Ask Prompt",
                mode = { "n", "v" },
            },
        },
    },
    -- {
    --     "saghen/blink.cmp",
    --     ---@module 'blink.cmp'
    --     ---@type blink.cmp.Config
    --     build = 'cargo build --release',
    --     lazy = false,
    --     opts = {
    --         chartoggle = { enabled = true },
    --         tree = { enabled = true },
    --         keymap = {
    --             ["<Tab>"] = {
    --                 "snippet_forward",
    --                 function() -- sidekick next edit suggestion
    --                     return require("sidekick").nes_jump_or_apply()
    --                 end,
    --                 function() -- if you are using Neovim's native inline completions
    --                     return vim.lsp.inline_completion.get()
    --                 end,
    --                 "fallback",
    --             },
    --         },
    --     },
    -- },
}
