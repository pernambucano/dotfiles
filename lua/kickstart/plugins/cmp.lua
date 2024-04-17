local function format(_, item)
  local MAX_ABBR_WIDTH, MAX_MENU_WIDTH = 30, 40

  -- Limit content width.
  if vim.api.nvim_strwidth(item.abbr) > MAX_ABBR_WIDTH then
    item.abbr = vim.fn.strcharpart(item.abbr, 0, MAX_ABBR_WIDTH) .. require 'utils'.icons.misc.ellipsis
  end

  -- Truncate the description part.
  if vim.api.nvim_strwidth(item.menu or '') > MAX_MENU_WIDTH then
    item.menu = vim.fn.strcharpart(item.menu, 0, MAX_MENU_WIDTH) .. require 'utils'.icons.misc.ellipsis
  end

  -- Replace kind with icons.
  item.kind = " " .. (require 'utils'.icons.lsp_kind[item.kind] or require 'utils'.icons.lsp_kind.String) .. " │"

  return item
end

return {
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        opts = function()
          local types = require 'luasnip.util.types'

          return {
            -- Display a cursor-like placeholder in unvisited nodes
            -- of the snippet.
            ext_opts = {
              [types.insertNode] = {
                unvisited = {
                  virt_text = { { '|', 'Conceal' } },
                  virt_text_pos = 'inline',
                },
              },
              [types.exitNode] = {
                unvisited = {
                  virt_text = { { '|', 'Conceal' } },
                  virt_text_pos = 'inline',
                },
              },
            },
          }
        end,

        config = function(_, opts)
          local luasnip = require 'luasnip'
          luasnip.setup(opts)
          -- Use <C-c> to select a choice in a snippet.
          -- vim.keymap.set({ 'i', 's' }, '<C-c>', function()
          --   if luasnip.choice_active() then
          --     require 'luasnip.extras.select_choice' ()
          --   end
          -- end, { desc = 'Select choice' })
          --
          -- vim.api.nvim_create_autocmd('ModeChanged', {
          --   group = vim.api.nvim_create_augroup('unlink_snippet', { clear = true }),
          --   desc = 'Cancel the snippet session when leaving insert mode',
          --   pattern = { 's:n', 'i:*' },
          --   callback = function(args)
          --     if
          --         luasnip.session
          --         and luasnip.session.current_nodes[args.buf]
          --         and not luasnip.session.jump_active
          --         and not luasnip.choice_active()
          --     then
          --       luasnip.unlink_current()
          --     end
          --   end,
          -- })
        end

      },
      "saadparwaiz1/cmp_luasnip",

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",

      -- If you want to add a bunch of pre-configured snippets,
      --    you can use this plugin to help you. It even has snippets
      --    for various frameworks/libraries/etc. but you will have to
      --    set up the ones that are useful for you.
      -- 'rafamadriz/friendly-snippets',
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      -- luasnip.config.setup({})
      local winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None'

      return {
        preselect = cmp.PreselectMode.None,
        completion = { completeopt = "menu,menuone,noinsert" },

        performance = {
          max_view_entries = 10
        },

        window = {
          completion = {
            border = 'single',
            winhighlight = winhighlight,
            scrollbar = true,
          },
          documentation = {
            border = 'single',
            winhighlight = winhighlight,
            max_height = math.floor(vim.o.lines * 0.5),
            max_width = math.floor(vim.o.columns * 0.4),
          },
        },
        view = {
          -- entries = { name = "custom", selection_order = "near_cursor" },
          entries = { follow_cursor = true },
        },

        experimental = {
          ghost_text = true,
        },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          -- Accept the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ["<C-e>"] = cmp.mapping.confirm({
            select = true,
          }),
          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer",  keyword_length = 4 },
          { name = "path" },
        }),

        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = format,
        },
      }
    end,
    config = function(_, opts)
      local cmp = require 'cmp'

      -- Override the documentation handler to remove the redundant detail section.
      ---@diagnostic disable-next-line: duplicate-set-field
      require('cmp.entry').get_documentation = function(self)
        local item = self:get_completion_item()

        if item.documentation then
          return vim.lsp.util.convert_input_to_markdown_lines(item.documentation)
        end

        -- Use the item's detail as a fallback if there's no documentation.
        if item.detail then
          local ft = self.context.filetype
          local dot_index = string.find(ft, '%.')
          if dot_index ~= nil then
            ft = string.sub(ft, 0, dot_index - 1)
          end
          return (vim.split(('```%s\n%s```'):format(ft, vim.trim(item.detail)), '\n'))
        end

        return {}
      end

      -- Inside a snippet, use backspace to remove the placeholder.
      vim.keymap.set('s', '<BS>', '<C-O>s')


      cmp.setup(opts)
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
