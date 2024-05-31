return {
  "rebelot/heirline.nvim",
  event = "UiEnter",
  config = function()
    local conditions = require("heirline.conditions")
    local utils = require "utils"

    local function is_virtual_line()
      return vim.v.virtnum < 0
    end

    local function is_wrapped_line()
      return vim.v.virtnum > 0
    end

    local function not_in_fold_range()
      return vim.fn.foldlevel(vim.v.lnum) <= 0
    end

    local function not_fold_start(line)
      return vim.fn.foldlevel(line) <= vim.fn.foldlevel(line - 1)
    end

    local function fold_opened(line)
      return vim.fn.foldclosed(line or vim.v.lnum) == -1
    end

    local Number = {
      { provider = "%=", hl = "CursorLine" },
      {
        provider = function()
          local lnum = tostring(vim.v.lnum)
          if is_virtual_line() then
            return string.rep(" ", #lnum)
          elseif is_wrapped_line() then
            return "" .. string.rep(" ", #lnum)
          else
            return (#lnum == 1 and "  " or " ") .. lnum
          end
        end,
        hl = "CursorLine"
      },
      { provider = " ",  hl = "CursorLine" },
    }

    local Fold = {
      provider = function()
        if is_wrapped_line() or is_virtual_line() then
          return ""
        elseif not_in_fold_range() or not_fold_start(vim.v.lnum) then
          return " "
        elseif fold_opened() then
          return utils.icons.misc.expanded
        else
          return utils.icons.misc.collapsed
        end
      end,
      -- hl = {
      --   fg = palette.light.fg.hex,
      --   bg = palette.light.bg.hex,
      --   bold = true,
      -- },
      hl = "CursorLine",
      on_click = {
        name = "heirline_fold_click_handler",
        callback = function()
          local line = vim.fn.getmousepos().line

          if not_fold_start(line) then
            return
          end

          vim.cmd.execute("'" .. line .. "fold" .. (fold_opened(line) and "close" or "open") .. "'")
        end,
      },
    }

    local Border = {
      -- init = function(self)
      --   local ns_id = vim.api.nvim_get_namespaces()["gitsigns_extmark_signs_"]
      --   if ns_id then
      --     local marks = vim.api.nvim_buf_get_extmarks(
      --       0,
      --       ns_id,
      --       { vim.v.lnum - 1, 0 },
      --       { vim.v.lnum, 0 },
      --       { limit = 1, details = true }
      --     )
      --
      --     if #marks > 0 then
      --       local hl_group = marks[1][4]["sign_hl_group"]
      --       self.highlight = hl_group
      --     else
      --       self.highlight = nil
      --     end
      --   end
      -- end,
      provider = utils.icons.misc.v_border,
      hl = function(self)
        return self.highlight or "StatusColumnBorder"
      end,
      -- hl = "CursorLine"
    }

    local Padding = {
      provider = " ",
      -- hl = function()
      --   if not conditions.is_active() then
      --     return { bg = palette.light.leaf.hex }
      --   elseif vim.v.lnum == vim.fn.getcurpos()[2] then
      --     return { bg = palette.light.rose.hex }
      --   else
      --     return { bg = palette.light.bg.hex }
      --   end
      -- end,
    }

    local TerminalStatusColumn = {
      condition = function()
        return conditions.buffer_matches({
          buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
          filetype = { "^git.*", "fugitive" },
        })
      end,

      Padding
    }

    local NormalStatusColumn = {
      Number, Fold, Padding
    }

    local StatusColumn = {
      fallthrough = false,

      TerminalStatusColumn,
      NormalStatusColumn
    }

    require("heirline").setup({
      statuscolumn = StatusColumn,
      -- winbar = require'kickstart.heirline.winbar',
      -- opts = {
      --   disable_winbar_cb = function (args)
      --     return conditions.buffer_matches({
      --       buftype = { "nofile", "prompt", "help", "quickfix" },
      --       filetype = { "^git.*", "fugitive", "Trouble", "dashboard", "Telescope" },
      --     }, args.buf)
      --   end
      -- }
    })
  end
}
