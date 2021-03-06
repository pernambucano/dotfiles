function LspStatus()
   if #vim.lsp.buf_get_clients() < 1 then return "" end
   return require("lsp-status").status()
end
 
require('lualine').setup{
  options = {
    theme = 'oceanicnext',
    section_separators = {'', ''},
    component_separators = {'', ''},
    icons_enabled = true,
  },
  sections = {
    lualine_a = { {'mode', upper = true} },
    lualine_b = { {'branch', icon = ''} },
    lualine_c = { {'filename', file_status = true} },
    lualine_x = { 'encoding', 'fileformat', 'filetype',
    {'diagnostics', sources = {'nvim_lsp'}}},
    lualine_y = { 'progress' },
    lualine_z = { 'location'  },
  },
  inactive_sections = {
    lualine_a = {  },
    lualine_b = {  },
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {  },
    lualine_z = {  }
  },
  extensions = {'nvim-tree'}
}
