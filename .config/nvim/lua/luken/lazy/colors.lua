function ColorMyPencils(color)
    color = color or "cyberdream"
    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

return {
    {
        "scottmckendry/cyberdream.nvim",
        config = function()
            require("cyberdream").setup({
                -- Enable transparent background
                transparent = false,

                -- Enable italics comments
                italic_comments = false,

                -- Replace all fillchars with ' ' for the ultimate clean look
                hide_fillchars = false,

                -- Modern borderless telescope theme
                borderless_telescope = true,

                -- Set terminal colors used in `:terminal`
                terminal_colors = false,

                theme = {
                    variant = "default", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
                    highlights = {
                        -- Highlight groups to override, adding new groups is also possible
                        -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values

                        -- Example:
                        Comment = { fg = "#696969", bg = "NONE", italic = true },

                        -- Complete list can be found in `lua/cyberdream/theme.lua`
                    },

                    -- Override a highlight group entirely using the color palette
                    overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
                        -- Example:
                        return {
                            Comment = { fg = colors.green, bg = "NONE", italic = true },
                            ["@property"] = { fg = colors.magenta, bold = true },
                        }
                    end,

                    -- Override a color entirely
                    colors = {
                        bg = "#16181a",
                        bgAlt = "#1e2124",
                        bgHighlight = "#3c4048",
                        fg = "#ffffff",
                        lightGrey = "#bbd3ff",
                        grey = "#7b8496",
                        blue = "#5ea1ff",
                        green = "#5eff6c",
                        cyan = "#5ef1ff",
                        red = "#ff6e5e",
                        yellow = "#f1ff5e",
                        magenta = "#ff5ef1",
                        pink = "#ff5ea0",
                        orange = "#ffbd5e",
                        purple = "#bd5eff",
                    },
                },
            })
            vim.cmd("colorscheme cyberdream")
        end
    },

}

