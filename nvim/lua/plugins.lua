require("lazy").setup({
    'wbthomason/packer.nvim',
    'preservim/nerdtree',
    'lepture/vim-jinja',
    'davidhalter/jedi-vim',
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "bash", "cmake", "c", "cpp", "cuda", "gitcommit", "gitignore",
                    "java", "latex", "make", "passwd", "php", "lua", "vim", "vimdoc",
                    "query", "javascript", "html", "typescript", "tsx", "python",
                    "yaml", "scss", "sql", "toml", "vue", },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    },
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
    }
}, opts)

require('plugins.init')
