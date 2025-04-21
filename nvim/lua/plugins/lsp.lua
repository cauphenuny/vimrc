return {
  -- fancy diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },

  -- outline
  {
    "hedyhli/outline.nvim",
    opts = {
      keymaps = {
        up_and_jump = "<C-p>",
        down_and_jump = "<C-n>",
        hover_symbol = "H",
      },
    },
    init = function()
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
    end,
  },

  -- lspconfig
  {
    "mfussenegger/nvim-dap",
    config = function() end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        clangd = {
          mason = false,
        },
        verible = {
          cmd = { "verible-verilog-ls", "--indentation_spaces=8", "--wrap_spaces=8" },
        },
        texlab = {
          build = {
            executable = "latexmk",
            args = { "-xelatex", "-synctex=1", "-interaction=nonstopmode", "%f" },
            onSave = true,
          },
        },
        tinymist = {
          settings = {
            formatterMode = "typstyle",
          },
        },
      },
    },
  },
}
