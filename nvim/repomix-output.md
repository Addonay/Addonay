This file is a merged representation of the entire codebase, combined into a single document by Repomix.

# File Summary

## Purpose
This file contains a packed representation of the entire repository's contents.
It is designed to be easily consumable by AI systems for analysis, code review,
or other automated processes.

## File Format
The content is organized as follows:
1. This summary section
2. Repository information
3. Directory structure
4. Repository files (if enabled)
5. Multiple file entries, each consisting of:
  a. A header with the file path (## File: path/to/file)
  b. The full contents of the file in a code block

## Usage Guidelines
- This file should be treated as read-only. Any changes should be made to the
  original repository files, not this packed version.
- When processing this file, use the file path to distinguish
  between different files in the repository.
- Be aware that this file may contain sensitive information. Handle it with
  the same level of security as you would the original repository.

## Notes
- Some files may have been excluded based on .gitignore rules and Repomix's configuration
- Binary files are not included in this packed representation. Please refer to the Repository Structure section for a complete list of file paths, including binary files
- Files matching patterns in .gitignore are excluded
- Files matching default ignore patterns are excluded
- Files are sorted by Git change count (files with more changes are at the bottom)

# Directory Structure
```
lua/
  config/
    autocmds.lua
    keymaps.lua
    lazy.lua
    options.lua
  plugins/
    example.lua
    picker.lua
    ui.lua
    which-key.lua
.gitignore
.neoconf.json
.repomixignore
init.lua
lazy-lock.json
lazyvim.json
LICENSE
README.md
repomix.config.json
stylua.toml
```

# Files

## File: lua/config/autocmds.lua
```lua
-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
```

## File: lua/config/keymaps.lua
```lua
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Live grep project (NOTE: This overrides the git group!)
map("n", "<leader>g", function()
  Snacks.picker.grep()
end, { desc = "Live Grep Project" })

-- Live grep current file
map("n", "<leader>gf", function()
  Snacks.picker.grep_buffers()
end, { desc = "Live Grep Current File" })

-- Terminal
map("n", "<leader>t", function()
  Snacks.terminal()
end, { desc = "Terminal" })

-- Split window (horizontal)
-- NOTE: This overrides the search group! Use <leader>/ for search instead
map("n", "<leader>s", "<C-w>s", { desc = "Split Window Horizontal" })

-- Format and save
map("n", "<leader>F", function()
  LazyVim.format({ force = true })
  vim.cmd("write")
end, { desc = "Format and Save" })

-- Home dashboard (alpha-nvim)
map("n", "<leader>h", "<cmd>Alpha<cr>", { desc = "Home Dashboard" })

-- Select all
map("n", "<leader>a", "ggVG", { desc = "Select All" })

-- Move Lines Up/Down in Normal Mode
map("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })

-- Move Selection Up/Down in Visual Mode
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
```

## File: lua/config/lazy.lua
```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
```

## File: lua/config/options.lua
```lua
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
```

## File: lua/plugins/example.lua
```lua
-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },

  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
```

## File: lua/plugins/picker.lua
```lua
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
```

## File: lua/plugins/ui.lua
```lua
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

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
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
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
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
  -- Alpha dashboard
}
```

## File: lua/plugins/which-key.lua
```lua
-- Which-key configuration to update keymap groups
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = { "n", "x" },
          -- Override <leader>g to be live grep instead of git
          { "<leader>g", desc = "Live Grep", icon = " " },
          { "<leader>gf", desc = "Grep Current File", icon = " " },
          -- Override <leader>s to be split instead of search
          { "<leader>s", desc = "Split Horizontal", icon = " " },
          -- New keymaps
          { "<leader>t", desc = "Terminal", icon = " " },
          { "<leader>F", desc = "Format & Save", icon = " " },
          { "<leader>h", desc = "Home Dashboard", icon = " " },
          { "<leader>a", desc = "Select All", icon = "󰒆 " },
        },
      },
    },
  },
}
```

## File: .gitignore
```
tt.*
.tests
doc/tags
debug
.repro
foo.*
*.log
data
```

## File: .neoconf.json
```json
{
  "neodev": {
    "library": {
      "enabled": true,
      "plugins": true
    }
  },
  "neoconf": {
    "plugins": {
      "lua_ls": {
        "enabled": true
      }
    }
  }
}
```

## File: .repomixignore
```
# Add patterns to ignore here, one per line
# Example:
# *.log
# tmp/
```

## File: init.lua
```lua
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
```

## File: lazy-lock.json
```json
{
  "LazyVim": { "branch": "main", "commit": "28db03f958d58dfff3c647ce28fdc1cb88ac158d" },
  "alpha-nvim": { "branch": "main", "commit": "3979b01cb05734331c7873049001d3f2bb8477f4" },
  "blink.cmp": { "branch": "main", "commit": "b19413d214068f316c78978b08264ed1c41830ec" },
  "bufferline.nvim": { "branch": "main", "commit": "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3" },
  "catppuccin": { "branch": "main", "commit": "ce4a8e0d5267e67056f9f4dcf6cb1d0933c8ca00" },
  "conform.nvim": { "branch": "master", "commit": "ffe26e8df8115c9665d24231f8a49fadb2d611ce" },
  "flash.nvim": { "branch": "main", "commit": "fcea7ff883235d9024dc41e638f164a450c14ca2" },
  "friendly-snippets": { "branch": "main", "commit": "572f5660cf05f8cd8834e096d7b4c921ba18e175" },
  "gitsigns.nvim": { "branch": "main", "commit": "5813e4878748805f1518cee7abb50fd7205a3a48" },
  "grug-far.nvim": { "branch": "main", "commit": "b58b2d65863f4ebad88b10a1ddd519e5380466e0" },
  "incline.nvim": { "branch": "main", "commit": "6a3b0635bcd2490dbb1fa124217d41bf69ca0fa2" },
  "lazy.nvim": { "branch": "main", "commit": "85c7ff3711b730b4030d03144f6db6375044ae82" },
  "lazydev.nvim": { "branch": "main", "commit": "5231c62aa83c2f8dc8e7ba957aa77098cda1257d" },
  "lualine.nvim": { "branch": "master", "commit": "47f91c416daef12db467145e16bed5bbfe00add8" },
  "mason-lspconfig.nvim": { "branch": "main", "commit": "0b9bb925c000ae649ff7e7149c8cd00031f4b539" },
  "mason.nvim": { "branch": "main", "commit": "57e5a8addb8c71fb063ee4acda466c7cf6ad2800" },
  "mini.ai": { "branch": "main", "commit": "bfb26d9072670c3aaefab0f53024b2f3729c8083" },
  "mini.icons": { "branch": "main", "commit": "ff2e4f1d29f659cc2bad0f9256f2f6195c6b2428" },
  "mini.pairs": { "branch": "main", "commit": "472ec50092a3314ec285d2db2baa48602d71fe93" },
  "neo-tree.nvim": { "branch": "main", "commit": "d1cb86129009ee9875f177a7c2632809e87c10b3" },
  "noice.nvim": { "branch": "main", "commit": "7bfd942445fb63089b59f97ca487d605e715f155" },
  "nui.nvim": { "branch": "main", "commit": "de740991c12411b663994b2860f1a4fd0937c130" },
  "nvim-lint": { "branch": "master", "commit": "5122c0c00a65cf6ce434b16b6a7587b62b6af00d" },
  "nvim-lspconfig": { "branch": "master", "commit": "f7c6e585fd80d5a2c075ab27ac312ac55bcf1550" },
  "nvim-notify": { "branch": "master", "commit": "8701bece920b38ea289b457f902e2ad184131a5d" },
  "nvim-treesitter": { "branch": "main", "commit": "75797cdd8ac125c7ace065b17788b439dcf89a71" },
  "nvim-treesitter-textobjects": { "branch": "main", "commit": "dfbf9596f8aa8b4bed5301647485594ff7252955" },
  "nvim-ts-autotag": { "branch": "main", "commit": "c4ca798ab95b316a768d51eaaaee48f64a4a46bc" },
  "nvim-web-devicons": { "branch": "master", "commit": "8dcb311b0c92d460fac00eac706abd43d94d68af" },
  "persistence.nvim": { "branch": "main", "commit": "b20b2a7887bd39c1a356980b45e03250f3dce49c" },
  "plenary.nvim": { "branch": "master", "commit": "b9fd5226c2f76c951fc8ed5923d85e4de065e509" },
  "snacks.nvim": { "branch": "main", "commit": "fe7cfe9800a182274d0f868a74b7263b8c0c020b" },
  "solarized-osaka.nvim": { "branch": "main", "commit": "f796014c14b1910e08d42cc2077fef34f08e0295" },
  "todo-comments.nvim": { "branch": "main", "commit": "31e3c38ce9b29781e4422fc0322eb0a21f4e8668" },
  "tokyonight.nvim": { "branch": "main", "commit": "5da1b76e64daf4c5d410f06bcb6b9cb640da7dfd" },
  "trouble.nvim": { "branch": "main", "commit": "bd67efe408d4816e25e8491cc5ad4088e708a69a" },
  "ts-comments.nvim": { "branch": "main", "commit": "123a9fb12e7229342f807ec9e6de478b1102b041" },
  "which-key.nvim": { "branch": "main", "commit": "3aab2147e74890957785941f0c1ad87d0a44c15a" },
  "zen-mode.nvim": { "branch": "main", "commit": "8564ce6d29ec7554eb9df578efa882d33b3c23a7" }
}
```

## File: lazyvim.json
```json
{
  "extras": [

  ],
  "install_version": 8,
  "news": {
    "NEWS.md": "11866"
  },
  "version": 8
}
```

## File: LICENSE
```
Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

   1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but
      not limited to compiled object code, generated documentation,
      and conversions to other media types.

      "Work" shall mean the work of authorship, whether in Source or
      Object form, made available under the License, as indicated by a
      copyright notice that is included in or attached to the work
      (an example is provided in the Appendix below).

      "Derivative Works" shall mean any work, whether in Source or Object
      form, that is based on (or derived from) the Work and for which the
      editorial revisions, annotations, elaborations, or other modifications
      represent, as a whole, an original work of authorship. For the purposes
      of this License, Derivative Works shall not include works that remain
      separable from, or merely link (or bind by name) to the interfaces of,
      the Work and Derivative Works thereof.

      "Contribution" shall mean any work of authorship, including
      the original version of the Work and any modifications or additions
      to that Work or Derivative Works thereof, that is intentionally
      submitted to Licensor for inclusion in the Work by the copyright owner
      or by an individual or Legal Entity authorized to submit on behalf of
      the copyright owner. For the purposes of this definition, "submitted"
      means any form of electronic, verbal, or written communication sent
      to the Licensor or its representatives, including but not limited to
      communication on electronic mailing lists, source code control systems,
      and issue tracking systems that are managed by, or on behalf of, the
      Licensor for the purpose of discussing and improving the Work, but
      excluding communication that is conspicuously marked or otherwise
      designated in writing by the copyright owner as "Not a Contribution."

      "Contributor" shall mean Licensor and any individual or Legal Entity
      on behalf of whom a Contribution has been received by Licensor and
      subsequently incorporated within the Work.

   2. Grant of Copyright License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      copyright license to reproduce, prepare Derivative Works of,
      publicly display, publicly perform, sublicense, and distribute the
      Work and such Derivative Works in Source or Object form.

   3. Grant of Patent License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      (except as stated in this section) patent license to make, have made,
      use, offer to sell, sell, import, and otherwise transfer the Work,
      where such license applies only to those patent claims licensable
      by such Contributor that are necessarily infringed by their
      Contribution(s) alone or by combination of their Contribution(s)
      with the Work to which such Contribution(s) was submitted. If You
      institute patent litigation against any entity (including a
      cross-claim or counterclaim in a lawsuit) alleging that the Work
      or a Contribution incorporated within the Work constitutes direct
      or contributory patent infringement, then any patent licenses
      granted to You under this License for that Work shall terminate
      as of the date such litigation is filed.

   4. Redistribution. You may reproduce and distribute copies of the
      Work or Derivative Works thereof in any medium, with or without
      modifications, and in Source or Object form, provided that You
      meet the following conditions:

      (a) You must give any other recipients of the Work or
          Derivative Works a copy of this License; and

      (b) You must cause any modified files to carry prominent notices
          stating that You changed the files; and

      (c) You must retain, in the Source form of any Derivative Works
          that You distribute, all copyright, patent, trademark, and
          attribution notices from the Source form of the Work,
          excluding those notices that do not pertain to any part of
          the Derivative Works; and

      (d) If the Work includes a "NOTICE" text file as part of its
          distribution, then any Derivative Works that You distribute must
          include a readable copy of the attribution notices contained
          within such NOTICE file, excluding those notices that do not
          pertain to any part of the Derivative Works, in at least one
          of the following places: within a NOTICE text file distributed
          as part of the Derivative Works; within the Source form or
          documentation, if provided along with the Derivative Works; or,
          within a display generated by the Derivative Works, if and
          wherever such third-party notices normally appear. The contents
          of the NOTICE file are for informational purposes only and
          do not modify the License. You may add Your own attribution
          notices within Derivative Works that You distribute, alongside
          or as an addendum to the NOTICE text from the Work, provided
          that such additional attribution notices cannot be construed
          as modifying the License.

      You may add Your own copyright statement to Your modifications and
      may provide additional or different license terms and conditions
      for use, reproduction, or distribution of Your modifications, or
      for any such Derivative Works as a whole, provided Your use,
      reproduction, and distribution of the Work otherwise complies with
      the conditions stated in this License.

   5. Submission of Contributions. Unless You explicitly state otherwise,
      any Contribution intentionally submitted for inclusion in the Work
      by You to the Licensor shall be under the terms and conditions of
      this License, without any additional terms or conditions.
      Notwithstanding the above, nothing herein shall supersede or modify
      the terms of any separate license agreement you may have executed
      with Licensor regarding such Contributions.

   6. Trademarks. This License does not grant permission to use the trade
      names, trademarks, service marks, or product names of the Licensor,
      except as required for reasonable and customary use in describing the
      origin of the Work and reproducing the content of the NOTICE file.

   7. Disclaimer of Warranty. Unless required by applicable law or
      agreed to in writing, Licensor provides the Work (and each
      Contributor provides its Contributions) on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
      implied, including, without limitation, any warranties or conditions
      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
      PARTICULAR PURPOSE. You are solely responsible for determining the
      appropriateness of using or redistributing the Work and assume any
      risks associated with Your exercise of permissions under this License.

   8. Limitation of Liability. In no event and under no legal theory,
      whether in tort (including negligence), contract, or otherwise,
      unless required by applicable law (such as deliberate and grossly
      negligent acts) or agreed to in writing, shall any Contributor be
      liable to You for damages, including any direct, indirect, special,
      incidental, or consequential damages of any character arising as a
      result of this License or out of the use or inability to use the
      Work (including but not limited to damages for loss of goodwill,
      work stoppage, computer failure or malfunction, or any and all
      other commercial damages or losses), even if such Contributor
      has been advised of the possibility of such damages.

   9. Accepting Warranty or Additional Liability. While redistributing
      the Work or Derivative Works thereof, You may choose to offer,
      and charge a fee for, acceptance of support, warranty, indemnity,
      or other liability obligations and/or rights consistent with this
      License. However, in accepting such obligations, You may act only
      on Your own behalf and on Your sole responsibility, not on behalf
      of any other Contributor, and only if You agree to indemnify,
      defend, and hold each Contributor harmless for any liability
      incurred by, or claims asserted against, such Contributor by reason
      of your accepting any such warranty or additional liability.

   END OF TERMS AND CONDITIONS

   APPENDIX: How to apply the Apache License to your work.

      To apply the Apache License to your work, attach the following
      boilerplate notice, with the fields enclosed by brackets "[]"
      replaced with your own identifying information. (Don't include
      the brackets!)  The text should be enclosed in the appropriate
      comment syntax for the file format. We also recommend that a
      file or class name and description of purpose be included on the
      same "printed page" as the copyright notice for easier
      identification within third-party archives.

   Copyright [yyyy] [name of copyright owner]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```

## File: README.md
```markdown
# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.
```

## File: repomix.config.json
```json
{
  "$schema": "https://repomix.com/schemas/latest/schema.json",
  "input": {
    "maxFileSize": 52428800
  },
  "output": {
    "filePath": "repomix-output.md",
    "style": "markdown",
    "parsableStyle": false,
    "fileSummary": true,
    "directoryStructure": true,
    "files": true,
    "removeComments": false,
    "removeEmptyLines": false,
    "compress": false,
    "topFilesLength": 5,
    "showLineNumbers": false,
    "truncateBase64": false,
    "copyToClipboard": false,
    "includeFullDirectoryStructure": false,
    "tokenCountTree": false,
    "git": {
      "sortByChanges": true,
      "sortByChangesMaxCommits": 100,
      "includeDiffs": false,
      "includeLogs": false,
      "includeLogsCount": 50
    }
  },
  "include": [],
  "ignore": {
    "useGitignore": true,
    "useDotIgnore": true,
    "useDefaultPatterns": true,
    "customPatterns": []
  },
  "security": {
    "enableSecurityCheck": true
  },
  "tokenCount": {
    "encoding": "o200k_base"
  }
}
```

## File: stylua.toml
```toml
indent_type = "Spaces"
indent_width = 2
column_width = 120
```
