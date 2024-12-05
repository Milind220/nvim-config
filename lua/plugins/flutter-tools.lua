return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup {
        flutter_path = vim.fn.expand("~/.local/bin/flutter"),
        ui = {
          border = "rounded",
          notification_style = "native",
        },
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          highlight = "ErrorMsg",
          prefix = ">",
          enabled = true,
        },
        lsp = {
          color = {
            enabled = true,
            background = true,
            virtual_text = true,
            virtual_text_str = "■",
          },
          on_attach = function(client, bufnr)
            -- optional: additional settings here
          end,
        },
        dev_tools = {
          autostart = true, -- autostart devtools server if not detected
          auto_open_browser = true, -- Automatically opens devtools in the browser
        },
      }
    end,
  },
}
