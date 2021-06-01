vim.cmd('highlight LspDiagnosticsUnderlineError guisp=#db4b4b gui=undercurl,bold  cterm=bold,undercurl')

-- lsp diagnostic signs
vim.fn.sign_define('LspDiagnosticsSignError', {text = '', texthl = 'LspDiagnosticsSignError', linehl = '', numhl = ''})
vim.fn.sign_define('LspDiagnosticsSignWarning', {text = '', texthl = 'LspDiagnosticsSignWarning', linehl = '', numhl = ''})
vim.fn.sign_define('LspDiagnosticsSignInformation', {text = '', texthl = 'LspDiagnosticsSignInformation', linehl = '', numhl = ''})
vim.fn.sign_define('LspDiagnosticsSignHint', {text = '', texthl = 'LspDiagnosticsSignHint', linehl = '', numhl = ''})

-- lsp setup
local lsp = require('lspconfig')

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

local set_lsp_config = function(client, bufnr)
  -- require'completion'.on_attach(client)
  print("LSP started.");
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- buf_set_keymap('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
  -- buf_set_keymap('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>df", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- -- Set autocommands conditional on server_capabilities
  -- if client.resolved_capabilities.document_highlight then
  --   vim.api.nvim_exec([[
  --   hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
  --   hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
  --   hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
  --   augroup lsp_document_highlight
  --   autocmd! * <buffer>
  --   autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --   autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --   augroup END
  --   ]], false)
  -- end
end

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

-- Servers With Custom Overrides
lsp.tsserver.setup{
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    set_lsp_config(client, bufnr)
  end
} 

lsp.efm.setup {
  init_options = {documentFormatting = true},
  filetypes = {"javascript", "typescript"},
  on_attach = function(client, bufnr)
    set_lsp_config(client, bufnr)
  end,
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  settings = {
    rootMarkers = {".eslintrc.js", ".git/"},
    languages = {
      javascript = {eslint},
      typescript = {eslint}
    }
  }
}

-- local prettier = {
--   formatCommand = "./node_modules/.bin/prettier --stdin-filepath=${INPUT}",
--   formatStdin = true
-- }



-- -- Custom EFM just for ESLINT
-- lsp.efm.setup{
--   init_options = {
--     documentFormatting = true,
--   },
--   on_attach = function(client, bufnr)
--     set_lsp_config(client, bufnr)
--   end,
--   root_dir = function()
--     if not eslint_config_exists() then
--       return nil
--     end
--     return vim.fn.getcwd()
--   end,
--   settings = {
--     languages = {
--       javascript = {eslint},
--       -- javascriptreact = {eslint},
--       -- ["javascript.jsx"] = {prettier, eslint},
--       typescript = {eslint},
--       -- ["typescript.tsx"] = {prettier, eslint},
--       -- typescriptreact = {prettier, eslint},
--       -- yaml = {prettier},
--       -- json = {prettier},
--       -- html = {prettier},
--       -- scss = {prettier},
--       -- css = {prettier},
--       -- markdown = {prettier},
--     }
--   },
--   filetypes = {
--     "javascript",
--     -- "javascriptreact",
--     -- "javascript.jsx",
--     "typescript",
--     -- "typescript.tsx",
--     -- "typescriptreact"
--   },
-- }

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      signs = true,
      virtual_text = false,
      underline = true
    }
  )
