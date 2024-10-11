local disabled_plugins = {
  'gzip',
  'netrwPlugin',
  'tarPlugin',
  'tohtml',
  'tutor',
  'zipPlugin',
  'rplugin',
  'editorconfig',
  'matchparen',
  'matchit',
}

for _, plugin in ipairs(disabled_plugins) do
  vim.g[plugin] = 1
end

local options = {
  equalalways = true,
  winbar = '%=%m %F',
  nrformats = { "alpha", "octal", "hex" },
  virtualedit = "block",
  modelines = 5,
  modelineexpr = false,
  modeline = true,
  cursorline = false,
  cursorcolumn = false,
  splitright = true,
  splitbelow = true,
  smartcase = true,
  hlsearch = true,
  ignorecase = true,
  incsearch = true,
  inccommand = "nosplit",
  hidden = true,
  autoindent = true,
  termguicolors = true,
  showmode = false,
  showmatch = true,
  matchtime = 2,
  wildmode = "longest:full,full",
  number = true,
  linebreak = true,
  joinspaces = false,
  ttimeoutlen = 10, -- https://vi.stackexchange.com/a/4471/7339
  path = vim.opt.path + "**",
  isfname = vim.opt.isfname:append("@-@"),
  autochdir = true,
  relativenumber = true,
  numberwidth = 2,
  shada = "!,'50,<50,s10,h,r/tmp",
  expandtab = true,
  smarttab = true,
  smartindent = true,
  shiftround = true,
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  foldenable = false,
  foldlevel = 99,
  foldlevelstart = 99,
  foldcolumn = '1',
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  undodir = os.getenv("HOME") .. "/.local/share/Trash/undodir/",
  undofile = true,
  showtabline = 0,
  mouse = 'a',
  mousescroll = "ver:2,hor:6",
  scrolloff = 3,
  sidescrolloff = 3,
  wrap = true,
  list = true,
  updatetime = 250,
  laststatus = 3,
  confirm = false,
  conceallevel = 3,
  cmdheight = 0,
}

for op, val in pairs(options) do
  vim.opt[op] = val
end

vim.g.matchparen_timeout = 20
vim.g.matchparen_insert_timeout = 20

vim.diagnostic.config {
  float = { border = "rounded" }, -- add border to diagnostic popups
}

if vim.fn.executable("rg") then
  -- if ripgrep installed, use that as a grepper
  vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end


if vim.fn.executable("prettier") then
  vim.opt.formatprg = "prettier --stdin-filepath=%"
end

vim.opt.formatoptions = "l"
vim.opt.formatoptions = vim.opt.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    - "o" -- O and o, don't continue comments
    + "r" -- But do continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- I'm not in gradeschool anymore

vim.o.number = true
vim.opt.smoothscroll = true

-- window-local options
local window_options = {
  numberwidth = 2,
  number = true,
  relativenumber = true,
  linebreak = true,
  cursorline = false,
  foldenable = false,
}

for k, v in pairs(window_options) do
  vim.wo[k] = v
end
