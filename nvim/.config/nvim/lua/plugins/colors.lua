return {
    { "catppuccin/nvim" },
    {
        'terrortylor/nvim-comment',
        config = function()
            require("nvim_comment").setup({ create_mappings = false })
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    }
}
