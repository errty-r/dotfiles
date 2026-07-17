local roslyn_utils = require("roslyn.utils")

roslyn_utils.get_roslyn_lsp_path = function()
  return vim.fn.expand("~/.local/share/roslyn/roslyn-language-server")
end
