-- keys:
-- visual, <M-j> / <M-k>: move selected texts
-- normal, <leader>o: open outline
-- normal, [q / ]q: jump among quickfix items
-- normal, [a / ]a / [A / ]A: jump among parameters
-- normal::outline, <C-p> / <C-n>: down/up and jump

local snippets_dir = vim.fn.stdpath("config") .. "/data/snippets"

return {
  -- auto detect indent
  {
    "tpope/vim-sleuth",
  },

  -- snippets
  {
    "chrisgrieser/nvim-scissors",
    opts = {
      snippetDir = snippets_dir,
    },
  },

  -- completion
  {
    "blink.cmp",
    opts = {
      completion = {
        list = {
          selection = {
            preselect = function(ctx)
              return not require("blink.cmp").snippet_active({ direction = 1 })
            end,
          },
        },
      },
      keymap = {
        preset = "super-tab",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        -- LSP completions only
        ["<C-l>"] = {
          function(cmp)
            cmp.show({ providers = { "lsp" } })
          end,
        },
        -- Snippet completions only
        ["<C-s>"] = {
          function(cmp)
            cmp.show({ providers = { "snippets" } })
          end,
        },
        -- Buffer completions only
        ["<C-b>"] = {
          function(cmp)
            cmp.show({ providers = { "buffer" } })
          end,
        },
      },
      sources = {
        providers = {
          snippets = {
            opts = {
              search_paths = { snippets_dir },
            },
          },
        },
      },
    },
  },

  -- -- easymotion
  -- {
  --   "easymotion/vim-easymotion",
  --   init = function()
  --     -- vim.keymap.set("n", "s", "<Plug>(easymotion-overwin-f2)", { desc = "Easymotion Jump" })
  --   end,
  -- },

  -- terminal
  {
    "skywind3000/vim-terminal-help",
    init = function()
      vim.g.terminal_key = "<c-.>"
      vim.g.terminal_height = 15
    end,
  },

  -- treesitter
  {
    "nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "<CR>",
          node_decremental = "<BS>",
          scope_incremental = "<TAB>",
        },
      },
      indent = {
        enable = true,
      },
    },
  },

  -- run and debug
  {
    "puremourning/vimspector",
    config = function()
      vim.g.vimspector_enable_mappings = "HUMAN"
    end,
  },
  {
    "skywind3000/asyncrun.vim",
    config = function()
      local wk = require("which-key")
      wk.add({
        { "<localleader>a", group = "asyncrun" },
        { "<localleader>ar", ":AsyncRun", desc = "Run Asyncrun" },
        { "<localleader>as", "<cmd>AsyncStop<cr>", desc = "Stop Asyncrun" },
      })
    end,
  },
  {
    "skywind3000/asynctasks.vim",
    dependencies = { "skywind3000/asyncrun.vim", "voldikss/vim-floaterm" },
    config = function()
      local dir = vim.fn.stdpath("config") .. "/data/asynctasks"
      vim.g.asyncrun_open = 10
      vim.g.asynctask_template = dir .. "/templates.ini"
      vim.g.asynctasks_extra_config = {
        dir .. "/tasks.ini",
      }
      vim.g.asynctasks_profile = "release"
      vim.g.synctasks_system = "macos"
      vim.g.asynctasks_term_pos = "bottom"
      vim.g.asynctasks_term_rows = 10
      local fzf_lua = require("fzf-lua")
      vim.keymap.set("n", "<leader>t", function()
        local rows = vim.fn["asynctasks#source"](math.floor(vim.go.columns * 48 / 100))
        fzf_lua.fzf_exec(function(cb)
          for _, e in ipairs(rows) do
            local color = fzf_lua.utils.ansi_codes
            local line = color.green(e[1]) .. " " .. color.cyan(e[2]) .. ": " .. color.yellow(e[3])
            cb(line)
          end
          cb()
        end, {
          actions = {
            ["default"] = function(selected)
              local str = fzf_lua.utils.strsplit(selected[1], " ")
              local command = "AsyncTask " .. vim.fn.fnameescape(str[1])
              vim.api.nvim_exec2(command, { output = false })
            end,
          },
          fzf_opts = {
            ["--no-multi"] = "",
            ["--nth"] = "1",
          },
          winopts = {
            height = 0.6,
            width = 0.6,
          },
        })
      end, { noremap = true, silent = true, desc = "Run Tasks" })
    end,
  },

  -- ai support
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "copilot-chat" },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      highlight_headers = false,
      -- separator = "\n---",
      -- error_header = "> [!ERROR] Error",
      model = "claude-3.7-sonnet-thought",
      window = {
        width = 0.3,
      },
    },
  },
}
