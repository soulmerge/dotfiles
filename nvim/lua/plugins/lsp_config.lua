require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls", "clangd", "cmake", "dockerls", "docker_compose_language_service",
        "html", "jsonls", "tsserver", "ltex", "psalm", "ruff_lsp",
        "sqlls", "vuels", "yamlls", "jedi_language_server",
    }
})

require("lspconfig").bashls.setup {}
require("lspconfig").clangd.setup {}
require("lspconfig").cmake.setup {}
require("lspconfig").dockerls.setup {}
require("lspconfig").docker_compose_language_service.setup {}
require("lspconfig").html.setup {}
require("lspconfig").jsonls.setup {}
require("lspconfig").tsserver.setup {}
require("lspconfig").ltex.setup {}
require("lspconfig").psalm.setup {}
require("lspconfig").ruff_lsp.setup {}
require("lspconfig").sqlls.setup {}
require("lspconfig").vuels.setup {}
require("lspconfig").yamlls.setup {}
require("lspconfig").jedi_language_server.setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
