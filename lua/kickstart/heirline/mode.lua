return {
  condition = require("heirline.conditions").is_active,

  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
    --
    -- -- execute this only once, this is required if you want the ViMode
    -- -- component to be updated on operator pending mode
    -- if not self.once then
    --   vim.api.nvim_create_autocmd("ModeChanged", {
    --     pattern = "*:*o",
    --     command = "redrawstatus",
    --   })
    --   self.once = true
    -- end
  end,

  hl = "StatusLineNC",

  -- Now we define some dictionaries to map the output of mode() to the
  -- corresponding string and color. We can put these into `static` to compute
  -- them at initialisation time.
  static = {
    mode_names = { -- change the strings if you like it vvvvverbose!
      n = "N",
      no = "N",
      nov = "N",
      noV = "N",
      ["no\22"] = "N",
      niI = "N",
      niR = "N",
      niV = "N",
      nt = "N",
      v = "V",
      vs = "V",
      V = "V",
      Vs = "V",
      ["\22"] = "V",
      ["\22s"] = "V",
      s = "S",
      S = "S",
      ["\19"] = "S",
      i = "I",
      ic = "I",
      ix = "I",
      R = "R",
      Rc = "R",
      Rx = "R",
      Rv = "R",
      Rvc = "R",
      Rvx = "R",
      c = "C",
      cv = "E",
      r = ".",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },

    mode_colors = {
      n = "green",
      i = "red",
      v = "blue",
      ["\22"] = "cyan",
      c = "orange",
      s = "purple",
      ["\19"] = "purple",
      r = "orange",
      ["!"] = "red",
      t = "red",
    },
  },

  {
    provider = function(self)
      return (" %s "):format(self.mode_names[self.mode])
    end,

    -- Same goes for the highlight. Now the foreground will change according to the current mode.
    hl = function(self)
      local mode = self.mode:sub(1, 1):lower() -- get only the first mode character
      return { fg = self.mode_colors[mode] }
    end,

    -- Re-evaluate the component only on ModeChanged event!
    -- This is not required in any way, but it's there, and it's a small
    -- performance improvement.
    update = {
      "ModeChanged",
    },
  },
}
