local icons = require "icons"
-- Heavily based on https://github.com/MariaSolOs/dotfiles. Thank you, Maria!

-- LSP Diagnostics Options Setup
return {
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      local methods = vim.lsp.protocol.Methods

      local client_capabilities = function()
        return vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(),
          -- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
          require('cmp_nvim_lsp').default_capabilities()
        )
      end

      local on_attach = function(client, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end
        local imap = function(keys, func, desc)
          vim.keymap.set("i", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-T>.
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

        -- Find references for the word under your cursor.
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

        -- Fuzzy find all the symbols in your current workspace
        --  Similar to document symbols, except searches over your whole project.
        map(
          "<leader>ws",
          require("telescope.builtin").lsp_dynamic_workspace_symbols,
          "[W]orkspace [S]ymbols"
        )

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")


        map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
        map("]d", vim.diagnostic.goto_next, "Go to next diagnostic")
        map("<leader>e", vim.diagnostic.open_float, "Show diagnostic [E]rror messages")
        map("<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")
        -- map("[e", function()
        --     vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
        --   end,
        --   "Go to previous error")
        -- map("e]", function()
        --     vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
        --   end,
        --   "Go to next error")

        if client.supports_method(methods.textDocument_signatureHelp) then
          imap('<C-k>', function()
            -- Close the completion menu first (if open).
            local cmp = require 'cmp'
            if cmp.visible() then
              cmp.close()
            end

            vim.lsp.buf.signature_help()
          end, 'Signature help')
        end

        -- if client.supports_method(methods.textDocument_inlayHint) then
        --   local inlay_hints_group = vim.api.nvim_create_augroup('toggle_inlay_hints', { clear = false })
        --
        --   vim.defer_fn(function()
        --     local mode = vim.api.nvim_get_mode().mode
        --     vim.lsp.inlay_hint.enable(bufnr, mode == 'n' or mode == 'v')
        --   end, 500)
        --
        --   vim.api.nvim_create_autocmd('InsertEnter', {
        --     group = inlay_hints_group,
        --     desc = 'Disable inlay hints',
        --     buffer = bufnr,
        --     callback = function()
        --       vim.lsp.inlay_hint.enable(bufnr, false)
        --     end,
        --   })
        --   vim.api.nvim_create_autocmd('InsertLeave', {
        --     group = inlay_hints_group,
        --     desc = 'Enable inlay hints',
        --     buffer = bufnr,
        --     callback = function()
        --       vim.lsp.inlay_hint.enable(bufnr, true)
        --     end,
        --   })
        -- end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- I don't think this can happen but it's a wild world out there.
          if not client then
            return
          end

          on_attach(client, args.buf)
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      local capabilities = client_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        -- lua_ls = {
        -- 	-- cmd = {...},
        -- 	-- filetypes { ...},
        -- 	-- capabilities = {},
        -- 	settings = {
        -- 		Lua = {
        -- 			runtime = { version = "LuaJIT" },
        -- 			workspace = {
        -- 				checkThirdParty = false,
        -- 				-- Tells lua_ls where to find all the Lua files that you have loaded
        -- 				-- for your neovim configuration.
        -- 				library = {
        -- 					"${3rd}/luv/library",
        -- 					unpack(vim.api.nvim_get_runtime_file("", true)),
        -- 				},
        -- 				-- If lua_ls is really slow on your computer, you can try this instead:
        -- 				-- library = { vim.env.VIMRUNTIME },
        -- 			},
        -- 			completion = {
        -- 				callSnippet = "Replace",
        -- 			},
        -- 			-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- 			-- diagnostics = { disable = { 'missing-fields' } },
        -- 		},
        -- 	},
        -- },
      }

      require("lspconfig").ruby_lsp.setup({
        capabilities = capabilities,
        cmd = { vim.fn.expandcmd("~/.rbenv/shims/ruby-lsp") }
      })

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      require("mason").setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format lua code
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })

      vim.diagnostic.config({
        underline = true,
        virtual_text = false,
        signs = {
          -- numhl = {
          --   [vim.diagnostic.severity.ERROR] = "DiagnosticError",
          --   [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
          --   [vim.diagnostic.severity.HINT] = "DiagnosticHint",
          --   [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
          -- }
          text = {
            [vim.diagnostic.severity.ERROR] = icons.misc.vertical_bar_thick,
            [vim.diagnostic.severity.WARN] = icons.misc.vertical_bar_thick,
            [vim.diagnostic.severity.HINT] = icons.misc.vertical_bar_thick,
            [vim.diagnostic.severity.INFO] = icons.misc.vertical_bar_thick,
          },
          linehl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
          }
        },
        float = {
          border = 'single',
          source = 'if_many',
          -- Show severity icons as prefixes.
          prefix = function(diag)
            local level = vim.diagnostic.severity[diag.severity]
            local prefix = string.format(' %s ', require 'utils'.icons.diagnostics[level])
            return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
          end,
          -- header = "",
          max_width = math.min(math.floor(vim.o.columns * 0.7), 100),
          max_height = math.min(math.floor(vim.o.lines * 0.3), 30),
        },
      })

      local md_namespace = vim.api.nvim_create_namespace 'lsp_float'
      local function add_inline_highlights(buf)
        for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
          for pattern, hl_group in pairs {
            ['@%S+'] = '@parameter',
            ['^%s*(Parameters:)'] = '@text.title',
            ['^%s*(Return:)'] = '@text.title',
            ['^%s*(See also:)'] = '@text.title',
            ['{%S-}'] = '@parameter',
            ['|%S-|'] = '@text.reference',
          } do
            local from = 1 -- @type integer
            while from do
              local to
              from, to = line:find(pattern, from)

              if from then
                vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
                  end_col = to,
                  hl_group = hl_group,
                })
              end
              from = to and to + 1 or nil
            end
          end
        end
      end

      --- LSP handler that adds extra inline highlights, keymaps, and window options.
      --- Code inspired from `noice`.
      ---@param handler fun(err: any, result: any, ctx: any, config: any): integer?, integer?
      ---@param focusable boolean
      ---@return fun(err: any, result: any, ctx: any, config: any)
      local function enhanced_float_handler(handler, focusable)
        return function(err, result, ctx, config)
          local bufnr, winnr = handler(
            err,
            result,
            ctx,
            vim.tbl_deep_extend('force', config or {}, {
              border = 'single',
              focusable = focusable,
              max_height = math.floor(vim.o.lines * 0.5),
              max_width = math.floor(vim.o.columns * 0.4),
            })
          )

          if not bufnr or not winnr then
            return
          end

          -- Conceal everything.
          vim.wo[winnr].concealcursor = 'n'

          -- Extra highlights.
          add_inline_highlights(bufnr)
        end
      end

      vim.lsp.handlers[methods.textDocument_hover] = enhanced_float_handler(vim.lsp.handlers.hover, true)
      vim.lsp.handlers[methods.textDocument_signatureHelp] = enhanced_float_handler(vim.lsp.handlers.signature_help,
        false)

      -- Workaround for truncating long TypeScript inlay hints.
      -- TODO: Remove this if https://github.com/neovim/neovim/issues/27240 gets addressed.
      -- local inlay_hint_handler = vim.lsp.handlers[methods.textDocument_inlayHint]
      -- vim.lsp.handlers[methods.textDocument_inlayHint] = function(err, result, ctx, config)
      --   local client = vim.lsp.get_client_by_id(ctx.client_id)
      --   if client and client.name == 'typescript-tools' then
      --     result = vim.iter.map(function(hint)
      --       local label = hint.label ---@type string
      --       if label:len() >= 30 then
      --         label = label:sub(1, 29) .. require'utils'.icons.misc.ellipsis
      --       end
      --       hint.label = label
      --       return hint
      --     end, result)
      --   end
      --
      --   inlay_hint_handler(err, result, ctx, config)
      -- end

      -- Update mappings when registering dynamic capabilities.
      local register_capability = vim.lsp.handlers[methods.client_registerCapability]
      vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        if not client then
          return
        end

        on_attach(client, vim.api.nvim_get_current_buf())

        return register_capability(err, res, ctx)
      end
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
