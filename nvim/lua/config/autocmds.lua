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

if vim.fn.has("mac") == 1 then
  local function switch_input()
    vim.g.stored_input = vim.fn.split(vim.fn.system("input_selector current"))[1]
    if vim.g.stored_input ~= "com.apple.keylayout.ABC" then
      vim.fn.system("input_selector select com.apple.keylayout.ABC")
    end
  end

  switch_input()

  create_autocmd("InsertLeave", {
    callback = function()
      switch_input()
    end,
  })

  create_autocmd("InsertEnter", {
    callback = function()
      if vim.g.stored_input == nil then
        vim.g.stored_input = vim.fn.split(vim.fn.system("input_selector current"))[1]
      end
      if vim.fn.split(vim.fn.system("input_selector current"))[1] ~= vim.g.stored_input then
        vim.fn.system("input_selector select " .. vim.g.stored_input)
      end
    end,
  })
end

-- Switch between relative and absolute line numbers when entering/exiting insert mode
create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = false -- Use absolute line numbers in insert mode
  end,
})

create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true -- Use relative line numbers in normal mode
  end,
})
