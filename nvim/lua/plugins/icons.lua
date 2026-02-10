return {
  {
    "nvim-tree/nvim-web-devicons",
    dependencies = { "catppuccin/nvim" },
    opts = function(_, opts)
      local ok, catppuccin = pcall(require, "catppuccin.palettes")
      local c = ok and catppuccin.get_palette("mocha") or require("onedarkpro.helpers").get_colors()
      opts = opts or {}
      opts.color_icons = true
      opts.default = true
      opts.override_by_extension = vim.tbl_extend("force", opts.override_by_extension or {}, {
        lua = { icon = "", color = c.blue, name = "Lua" },
        js = { icon = "", color = c.yellow, name = "Js" },
        jsx = { icon = "", color = c.peach, name = "Jsx" },
        ts = { icon = "", color = c.blue, name = "Ts" },
        tsx = { icon = "", color = c.blue, name = "Tsx" },
        json = { icon = "", color = c.yellow, name = "Json" },
        md = { icon = "", color = c.teal, name = "Md" },
        yaml = { icon = "", color = c.sapphire, name = "Yaml" },
        yml = { icon = "", color = c.sapphire, name = "Yml" },
        toml = { icon = "", color = c.sapphire, name = "Toml" },
        html = { icon = "", color = c.peach, name = "Html" },
        css = { icon = "", color = c.blue, name = "Css" },
        scss = { icon = "", color = c.pink, name = "Scss" },
        svelte = { icon = "", color = c.red, name = "Svelte" },
        go = { icon = "", color = c.sky, name = "Go" },
        rs = { icon = "", color = c.maroon, name = "Rust" },
        py = { icon = "", color = c.yellow, name = "Python" },
        java = { icon = "", color = c.peach, name = "Java" },
        sh = { icon = "", color = c.green, name = "Sh" },
        zsh = { icon = "", color = c.green, name = "Zsh" },
        vim = { icon = "", color = c.green, name = "Vim" },
        nvim = { icon = "", color = c.green, name = "Nvim" },
        dockerfile = { icon = "󰡨", color = c.blue, name = "Dockerfile" },
        nix = { icon = "", color = c.blue, name = "Nix" },
      })
      return opts
    end,
  },
}
