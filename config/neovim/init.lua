-- TODO: F#, OCaml, Rust, Keybinds, etc...

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Colorschemes
require('catppuccin').setup({
    flavour = "mocha"
})
require('kanagawa').setup({
    theme = "dragon",
    background = {
        dark = "dragon",
        light = "lotus"
    },
})

vim.o.background = 'dark'
vim.cmd.colorscheme 'catppuccin'

require('zen-mode').setup({
    window = {
        width = 90,
        options = {
            number = true,
            relativenumber = true
        }
    }
})

-- formatting
vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function(ev)
        vim.lsp.buf.format()
    end,
})

require('neo-tree').setup {
    window = {
        mappings = {
            ['l'] = "open"
        }
    }
}
require('nvim-web-devicons').setup()
require('lualine').setup()

vim.cmd([[
  nnoremap <silent> <F2> <CMD>NeoTreeFloatToggle<CR>
  tnoremap <silent> <F2> <C-\><C-n><CMD>NeoTreeFloatToggle<CR>
  nnoremap <silent> <F1> <CMD>FloatermToggle<CR>
  tnoremap <silent> <F1> <C-\><C-n><CMD>FloatermToggle<CR>
]])


require('telescope').setup()
pcall(require('telescope').load_extension, 'fzf')
do
    local tsb = require('telescope.builtin')
    vim.keymap.set('n', '<leader>?', tsb.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', tsb.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sf', tsb.find_files, { desc = '[SF] Search Files' })
    vim.keymap.set('n', '<leader>sF', tsb.git_files, { desc = '[SF] Search Git Files' })
    vim.keymap.set('n', '<leader>sh', tsb.help_tags, { desc = '[SH] Search Help' })
    vim.keymap.set('n', '<leader>sg', tsb.live_grep, { desc = '[SG] Search by Grep' })
    vim.keymap.set('n', '<leader>sd', tsb.diagnostics, { desc = '[SD] Search Diagnostics' })
    vim.keymap.set('n', '<leader>sr', tsb.registers, { desc = '[SR] Search Registers' })

    -- Configure Treesitter
    require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<c-space>',
                node_incremental = '<c-space>',
                scope_incremental = '<c-s>',
                node_decremental = '<M-space>',
            },
        },
    }

    vim.keymap.set('n', '<leader>/', function()
        tsb.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            previewer = false,
        })
    end, { desc = '[/] Fuzzily search in current buffer' })
end

vim.keymap.set('n', '<leader>zz', function()
    require('zen-mode').toggle()
end)

vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)

-- Configure Auto Complete
local cmp = require('cmp')
local luasnip = require('luasnip')

luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

-- Haskell tools configuration

local ht = require('haskell-tools')
local bufnr = vim.api.nvim_get_current_buf()
local def_opts = { noremap = true, silent = true, buffer = bufnr, }
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
-- Evaluate all code snippets
vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>rf', function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, def_opts)
vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)

-- Detect nvim-dap launch configurations
-- (requires nvim-dap and haskell-debug-adapter)
ht.dap.discover_configurations(bufnr)

-- LSP Configuration
-- Setup language servers.
local lspconfig = require('lspconfig')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
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
