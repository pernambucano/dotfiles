local icon_color_enabled = false
local conditions = require("heirline.conditions")

local function active_highlight(active)
  active = active or "StatusLine"
  return conditions.is_active() and active or "StatusLineNC"
end

local hidden_filetypes = vim.tbl_extend("keep", {
  "markdown",
}, {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
})

local function smallcaps(str)
  local normal = "ABCDEFGHIJKLMNOPQRSTUVWXYZ<>0123456789"
  local smallCaps = "ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢ‹›⁰¹²³⁴⁵⁶⁷⁸⁹"
  return vim.fn.tr(str:upper(), normal, smallCaps)
end

local function is_highlight_enabled(bufnr)
  bufnr = bufnr and vim.fn.bufnr(bufnr) or vim.fn.bufnr()
  return bufnr > -1 and vim.treesitter.highlighter.active[bufnr] ~= nil
end

local SPECIAL_BUFTYPES = {
  "help",
  "nofile",
  "popup",
  "prompt",
  "quickfix",
  "terminal",
}

local SPECIAL_FILETYPES = {
  "fugitive",
  "gitcommit",
  "gitrebase",
  "lazy",
  "mason",
}

return {
  {
    init = function(self)
      self.filepath = vim.api.nvim_buf_get_name(0)
      self.filetype_text = vim.tbl_contains(hidden_filetypes, vim.bo.filetype)
          and ""
          or " " .. smallcaps(vim.bo.filetype)
    end,
    hl = function()
      return active_highlight()
    end,

    {
      condition = function()
        return vim.bo.filetype ~= ""
      end,

      -- =======================================================================
      -- treesitter highlight status
      -- =======================================================================

      {
        provider = function()
          if
              conditions.buffer_matches({
                buftype = SPECIAL_BUFTYPES,
                filetype = SPECIAL_FILETYPES,
              })
          then
            return ""
          end
          return "    "
        end,
        hl = function()
          return active_highlight(is_highlight_enabled() and "DiffAdd" or "DiffDelete")
        end,
      },

      -- =======================================================================
      -- mode
      -- =======================================================================

      require'kickstart.heirline.mode',

      -- =======================================================================
      -- filetype icon and text
      -- =======================================================================

      {
        init = function(self)
          if vim.bo.buftype ~= "" then
            self.icon = ""
            self.icon_color = ""
          else
            local extension = vim.fn.fnamemodify(self.filepath, ":e")
            local ok, nvim_web_devicons = pcall(require, "nvim-web-devicons")
            if ok then
              self.icon, self.icon_color = nvim_web_devicons.get_icon_color(
                self.filepath,
                extension,
                { default = true }
              )
            end
          end
        end,
        provider = function(self)
          -- Don't bother outputting these, the nerd icon is sufficient
          return self.icon ~= ""
              and (" %s%s "):format(self.icon, self.filetype_text)
              or self.filetype_text .. " "
        end,
        hl = function(self)
          if icon_color_enabled and self.icon_color then
            return { fg = self.icon_color }
          end
          -- TODO: use this highlight somewhere 
          return active_highlight("StatusKey")
        end,
      },
    },

    -- =========================================================================
    -- terminal
    -- =========================================================================

    {
      condition = function()
        return vim.bo.buftype == "terminal"
      end,
      provider = function()
        -- return " [<A-i> hide] [<A-x> mode] "
        return "Terminal"
      end,
      hl = function()
        return active_highlight()
      end,
    },

    -- =========================================================================
    -- filename
    -- =========================================================================
    {
      condition = function()
        return vim.bo.buftype == "" or vim.bo.buftype == "help"
      end,

      {
        provider = function(self)
          if self.filepath == "" then
            return " ᴜɴɴᴀᴍᴇᴅ "
          end

          local filename = vim.fn.fnamemodify(self.filepath, ":t")
          return (" %s "):format(filename)
        end,
        hl = function()
          return vim.bo.modified and "Todo" or active_highlight("StatusLine")
        end,
      },

      {
        condition = function()
          return not vim.bo.modifiable or vim.bo.readonly
        end,
        {
          provider = "  ",
          hl = "LineImportant",
        },
        {
          provider = " ",
        },
      },
    },

    -- =========================================================================
    -- path
    -- =========================================================================

    {
      condition = function()
        return vim.bo.buftype == "" or vim.bo.buftype == "help"
      end,

      {
        provider = function(self)
          if self.filepath == "" then
            return ""
          end

          local path = vim.fn.fnamemodify(self.filepath, ":~:h")

          local win_width = vim.api.nvim_win_get_width(0)
          local extrachars = 3 + 3 + self.filetype_text:len()
          local remaining = win_width - extrachars

          local final
          local relative = vim.fn.fnamemodify(path, ":~:.") or ""
          if relative:len() < remaining then
            final = relative
          else
            local len = 8
            while len > 0 and type(final) ~= "string" do
              local attempt = vim.fn.pathshorten(path, len)
              final = attempt:len() < remaining and attempt
              len = len - 2
            end
            if not final then
              final = vim.fn.pathshorten(path, 1)
            end
          end
          return ("in %s%s/ "):format("%<", final)
        end,
        hl = function()
          return active_highlight("Comment")
        end,
      },
    },
  },

  -- spacer with active bg color
  {
    provider = "%=",
    hl = function()
      return active_highlight()
    end,
  },

  {
    condition = function()
      return vim.bo.buftype == "" -- normal
    end,
    -- require("dko.heirline.package-info"),
    -- require("dko.heirline.lsp"),
    -- require("dko.heirline.diagnostics"),
  },
}
