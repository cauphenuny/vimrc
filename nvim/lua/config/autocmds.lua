-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` fonr the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local create_autocmd = vim.api.nvim_create_autocmd

create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.opt.expandtab = false -- Use tabs instead of spaces
  end,
})

create_autocmd("FileType", {
  pattern = "verilog",
  callback = function()
    vim.opt.expandtab = false
    vim.opt.tabstop = 8
  end,
})

-- create_autocmd("FileType", {
--   pattern = "verilog",
--   callback = function()
--     vim.opt.expandtab = false -- Use tabs instead of spaces
--     vim.opt.shiftwidth = 8
--     vim.opt.tabstop = 8
--   end,
-- })

local function load_preset()
  local template_path = vim.fn.stdpath("config") .. "/data/templates/"
  local actions = {
    c = {
      file = "default.c",
      callback = function()
        vim.fn.search("int main(", "w")
      end,
    },
    cpp = {
      file = "default.cpp",
      callback = function()
        vim.fn.search("int main(", "w")
      end,
    },
    cmake = {
      file = "default.cmake",
    },
    typst = {
      file = "homework.typ",
    },
  }
  local filetype = vim.o.filetype
  if actions[filetype] then
    vim.cmd("0r" .. template_path .. actions[filetype].file)
    if actions[filetype].callback then
      actions[filetype].callback()
    else
      vim.cmd("normal G")
    end
  end
end

vim.keymap.set("n", "<leader>p", function()
  load_preset()
end, { desc = "Paste Template Files" })

-- Initialize input method stack if it doesn't exist
vim.g.input_stack = vim.g.input_stack or {}

local function switch_input()
  if vim.fn.has("mac") == 1 then
    -- Get current input method
    local current_input = vim.fn.split(vim.fn.system("input_selector current"))[1]
    -- Push current input method to stack
    table.insert(vim.g.input_stack, current_input)
    -- Switch to ABC if not already using it
    if current_input ~= "com.apple.keylayout.ABC" then
      vim.fn.system("input_selector select com.apple.keylayout.ABC")
    end
  end
end

local function load_input()
  if vim.fn.has("mac") == 1 and #vim.g.input_stack > 0 then
    -- Pop the last input method from stack
    local previous_input = table.remove(vim.g.input_stack)
    -- Get current input method
    local current_input = vim.fn.split(vim.fn.system("input_selector current"))[1]
    -- Only switch if different
    if current_input ~= previous_input then
      vim.fn.system("input_selector select " .. previous_input)
    end
  end
end

switch_input()
create_autocmd("InsertLeave", { callback = switch_input })
create_autocmd("InsertEnter", { callback = load_input })

-- Switch between relative and absolute line numbers when entering/exiting insert mode
create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = false -- Use absolute line numbers in insert mode
  end,
})

create_autocmd("InsertLeave", {
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = true -- Use relative line numbers in normal mode
    end
  end,
})

-- Function to detect the current terminal emulator
local function detect_terminal()
  -- Check if running in Neovide (GUI)
  if vim.g.neovide then
    return "neovide"
  end

  -- Check for iTerm2
  if vim.env.TERM_PROGRAM == "iTerm.app" then
    return "iTerm"
  end

  -- Check for Kitty
  if vim.env.KITTY_WINDOW_ID then
    return "kitty"
  end

  -- Check for Alacritty
  if vim.env.ALACRITTY_LOG or vim.env.ALACRITTY_SOCKET then
    return "alacritty"
  end

  -- Check for common terminal identifiers in $TERM
  local term = vim.env.TERM or ""
  if term:match("kitty") then
    return "kitty"
  elseif term:match("screen") or term:match("tmux") then
    -- For tmux, try to detect parent terminal
    local parent_term = vim.env.TERM_PROGRAM or ""
    if parent_term:match("iTerm") then
      return "iTerm"
    end
  end

  -- Default to Terminal.app if on macOS
  if vim.fn.has("mac") == 1 then
    return "Terminal"
  end

  return "terminal" -- generic fallback
end

-- Function to focus terminal
local function tex_focus_vim()
  -- Replace `TERMINAL` with the name of your terminal application
  -- Example: vim.cmd("silent !open -a iTerm")
  -- Example: vim.cmd("silent !open -a Alacritty")
  vim.cmd("silent !open -a " .. detect_terminal())
  vim.cmd("redraw!")
end

local vimtex_group = vim.api.nvim_create_augroup("vimtex_event_focus", { clear = true })
create_autocmd("User", {
  pattern = "VimtexEventViewReverse",
  group = vimtex_group,
  callback = function()
    -- Call the tex_focus_vim function
    -- Assuming it's defined in the same file/module
    tex_focus_vim()
  end,
})

-- Auto-convert 'mk' to '$<cursor>$' in insert mode for Markdown and Typst files
vim.api.nvim_create_autocmd("InsertCharPre", {
  pattern = { "*.md", "*.markdown", "*.typ", "*.typst" },
  callback = function()
    if vim.v.char == "k" then
      local line = vim.api.nvim_get_current_line()
      local col = vim.api.nvim_win_get_cursor(0)[2]

      if col > 0 and line:sub(col, col) == "m" then
        vim.v.char = ""
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<BS>$$<Left>", true, false, true), "n", false)
        switch_input()
      end
    end
  end,
})

-- Function to handle $ key press for math mode
local function handle_dollar_key()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]

  -- Check if next character is $
  -- Find next non-whitespace character
  local next_non_space = col + 1
  while next_non_space <= #line and line:sub(next_non_space, next_non_space):match("%s") do
    next_non_space = next_non_space + 1
  end

  -- Check if next non-whitespace is $
  if next_non_space <= #line and line:sub(next_non_space, next_non_space) == "$" then
    -- Move cursor past the $
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], next_non_space })
    load_input()
  else
    -- Insert pair of $ with cursor in between
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("$$<Left>", true, false, true), "n", false)
    switch_input()
  end
  return ""
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typst" },
  callback = function()
    vim.keymap.set("i", "$", handle_dollar_key, { expr = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "typst" },
  callback = function()
    vim.keymap.set("i", "¥", "$", { remap = true })
  end,
})

-- Tab to jump out of math mode in Markdown/Typst files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "typst" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "i", "<Tab>", "", {
      noremap = true,
      callback = function()
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2]

        -- Look for the next non-space character
        for i = col + 1, #line do
          local char = line:sub(i, i)
          if char ~= " " then
            -- If next non-space character is $, jump after it
            if char == "$" then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>f$a", true, false, true), "n", true)
              load_input()
              return
            end
            break
          end
        end

        -- Otherwise, insert a normal tab
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
      end,
    })
  end,
})
