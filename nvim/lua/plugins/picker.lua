-- Configure snacks picker to exclude node_modules and .venv
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = false,
            exclude = {
              "node_modules",
              ".venv",
              ".git",
              "__pycache__",
              ".cache",
              "*.pyc",
              ".DS_Store",
            },
          },
          grep = {
            hidden = true,
            ignored = false,
            exclude = {
              "node_modules",
              ".venv",
              ".git",
              "__pycache__",
              ".cache",
              "*.pyc",
              ".DS_Store",
            },
          },
        },
        -- Additional file_ignore_patterns for the picker
        matcher = {
          file_ignore_patterns = {
            "node_modules/",
            ".venv/",
            ".git/",
            "__pycache__/",
            ".cache/",
            "%.pyc$",
          },
        },
      },
    },
  },
}