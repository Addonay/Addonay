return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets = vim.tbl_deep_extend("force", opts.presets or {}, {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      })

      -- Avoid treesitter cmdline highlight errors from outdated parsers.
      opts.cmdline = opts.cmdline or {}
      opts.cmdline.format = vim.tbl_deep_extend("force", opts.cmdline.format or {}, {
        cmdline = { pattern = "^:", icon = "" },
      })
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      render = "compact",
      background_colour = "#1f2335",
    },
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        offsets = {
          { filetype = "neo-tree", text = "Explorer", text_align = "center" },
        },
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "olimorris/onedarkpro.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("onedarkpro.helpers").get_colors()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.purple, guifg = colors.bg },
            InclineNormalNC = { guifg = colors.fg_gutter, guibg = colors.bg_highlight },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local LazyVim = require("lazyvim.util")
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        theme = "auto",
        globalstatus = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      })
      opts.sections.lualine_c[4] = {
        LazyVim.lualine.pretty_path({
          length = 0,
          relative = "cwd",
          modified_hl = "MatchParen",
          directory_hl = "",
          filename_hl = "Bold",
          modified_sign = "",
          readonly_icon = " 󰌾 ",
        }),
      }
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },

  -- Session persistence for reload session
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
      indent = {
        enabled = true,
        indent = { char = "▏" },
        scope = { char = "▏" },
        animate = {
          style = "out",
          duration = { step = 20, total = 300 },
        },
      },
      scroll = {
        enabled = true,
        animate = { duration = { step = 10, total = 200 }, easing = "linear" },
        animate_repeat = { delay = 80, duration = { step = 5, total = 120 }, easing = "linear" },
      },
      styles = {
        dashboard = {
          wo = {
            winhighlight = "Normal:SnacksDashboardNormal,NormalFloat:SnacksDashboardNormal,FloatBorder:SnacksDashboardBorder",
          },
        },
      },
      image = {
        ---@class snacks.image.Config
        ---@field enabled? boolean enable image viewer
        ---@field wo? vim.wo|{} options for windows showing the image
        ---@field bo? vim.bo|{} options for the image buffer
        ---@field formats? string[]
        --- Resolves a reference to an image with src in a file (currently markdown only).
        --- Return the absolute path or url to the image.
        --- When `nil`, the path is resolved relative to the file.
        ---@field resolve? fun(file: string, src: string): string?
        ---@field convert? snacks.image.convert.Config

        formats = {
          "png",
          "jpg",
          "jpeg",
          "gif",
          "bmp",
          "webp",
          "tiff",
          "heic",
          "avif",
          "mp4",
          "mov",
          "avi",
          "mkv",
          "webm",
          "pdf",
        },
        force = false, -- try displaying the image, even if the terminal does not support it
        doc = {
          -- enable image viewer for documents
          -- a treesitter parser must be available for the enabled languages.
          enabled = true,
          -- render the image inline in the buffer
          -- if your env doesn't support unicode placeholders, this will be disabled
          -- takes precedence over `opts.float` on supported terminals
          inline = true,
          -- render the image in a floating window
          -- only used if `opts.inline` is disabled
          float = true,
          max_width = 80,
          max_height = 40,
          -- Set to `true`, to conceal the image text when rendering inline.
          -- (experimental)
          ---@param lang string tree-sitter language
          ---@param type snacks.image.Type image type
          conceal = function(lang, type)
            -- only conceal math expressions
            return type == "math"
          end,
        },
        img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
        -- window options applied to windows displaying image buffers
        -- an image buffer is a buffer with `filetype=image`
        wo = {
          wrap = false,
          number = false,
          relativenumber = false,
          cursorcolumn = false,
          signcolumn = "no",
          foldcolumn = "0",
          list = false,
          spell = false,
          statuscolumn = "",
        },
        cache = vim.fn.stdpath("cache") .. "/snacks/image",
        debug = {
          request = false,
          convert = false,
          placement = false,
        },
        env = {},
        -- icons used to show where an inline image is located that is
        -- rendered below the text.
        icons = {
          math = "󰪚 ",
          chart = "󰄧 ",
          image = " ",
        },
        ---@class snacks.image.convert.Config
        convert = {
          notify = true, -- show a notification on error
          ---@type snacks.image.args
          mermaid = function()
            local theme = vim.o.background == "light" and "neutral" or "dark"
            return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}" }
          end,
          ---@type table<string,snacks.image.args>
          magick = {
            default = { "{src}[0]", "-scale", "1920x1080>" }, -- default for raster images
            vector = { "-density", 192, "{src}[0]" }, -- used by vector images like svg
            math = { "-density", 192, "{src}[0]", "-trim" },
            pdf = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
          },
        },
        math = {
          enabled = true, -- enable math expression rendering
          -- in the templates below, `${header}` comes from any section in your document,
          -- between a start/end header comment. Comment syntax is language-specific.
          -- * start comment: `// snacks: header start`
          -- * end comment:   `// snacks: header end`
          typst = {
            tpl = [[
                      #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
                      #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
                      #set text(size: 12pt, fill: rgb("${color}"))
                      ${header}
                      ${content}]],
          },
          latex = {
            font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
            -- for latex documents, the doc packages are included automatically,
            -- but you can add more packages here. Useful for markdown documents.
            packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
            tpl = [[
                      \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
                      \usepackage{${packages}}
                      \begin{document}
                      ${header}
                      { \${font_size} \selectfont
                        \color[HTML]{${color}}
                      ${content}}
                      \end{document}]],
          },
        },
      },
    },
  },
  -- Color Scheme
  
}
