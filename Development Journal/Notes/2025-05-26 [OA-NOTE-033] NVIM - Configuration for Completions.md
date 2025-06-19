# Neovim CONFIGS

## Parse environment variables that evalute to *a file* or *a directory*

```lua
--[[
Requirements:
- It should work globally, as it will later be passed through a preprocessor.
- Autocomplete environment variable names (e.g. $HOME, $PWD, $OA_SANDBOX_PATH) which are evaluated to paths or files.
- When an env var should autocomplete, provide parameter suggestions that would resolve to valid directories and files.
- The env var should not be expanded in the inserted text, but its value is used for scanning.
- A directory should show its contents as completion items.
- Support tilde (~) as a shortcut to HOME.
- Must work inside markdown files and inside fenced code blocks.
- No duplicated entries in completion.
- Display folders with "/" at the end.
- Entries must include documentation showing the full path.
- The ENV_VARS are to be named in the completion as variables.
- Completion should be triggered by '/', '~', or '$'.
- The completions should be provided as a source for completions.
- Fallback to cmp-path, buffer, lsp, and luasnip sources as well.
- Must match ENV_VARS that resolve to both files and directories.
- It should provide suggested completions for variables such that `$XDG_HOME_CONFIG` would be a completion candidate for "$XD".
- Needs to handle nested variables or spaces in paths 
- Trigger characters should trigger without conflicts 
- When providing the path the variable needs to be intepreted as resolved, and provide the correct directory.
]]

local M = {}

-------------------------------------------------
-- Utility functions
-------------------------------------------------

-- get_resolved_path converts the unexpanded "base" (like "$XDG_HOME_CONFIG/" or "~/" ) 
-- into the real filesystem path for scanning.
local function get_resolved_path(prefix)
  if prefix:sub(1, 1) == "~" then
    return (vim.env.HOME or "") .. prefix:sub(2)
  elseif prefix:sub(1, 1) == "$" then
    local varName = prefix:match("^%$([%w_]+)")
    if varName then
      local varValue = vim.env[varName] or ""
      local rest = prefix:sub(#varName + 2)  -- Characters after the variable name and the '$'
      return varValue .. rest
    end
  end
  return prefix
end

-- Suggest environment variable completions.
-- For example, if the user types "$XD", then "$XDG_HOME_CONFIG" might be suggested.
local function suggest_env_variables(partial)
  local items = {}
  -- Compare the typed text (e.g. "$xd") with each env variable (case-insensitive).
  for k, v in pairs(vim.env) do
    local token = "$" .. k
    if token:lower():find(partial:lower(), 1, true) then
      table.insert(items, {
        label = token,
        insertText = token,
        filterText = token,
        documentation = { kind = "markdown", value = "`" .. v .. "`" },
        kind = require("cmp").lsp.CompletionItemKind.Variable,
      })
    end
  end
  return items
end

-- Suggest files and directories from a resolved path.
--   resolved: the actual filesystem path (obtained by expanding the base: "$XDG_HOME_CONFIG/" becomes "/home/user/.config/")
--   query: the part typed after the last slash (may be empty)
--   base: the original text up to (and including) the last slash (e.g. "$XDG_HOME_CONFIG/")
local function suggest_path_entries(resolved, query, base)
  local items = {}
  local scan = require("plenary.scandir").scan_dir
  local ok, entries = pcall(scan, resolved, { hidden = true, add_dirs = true, depth = 1 })
  if not ok or not entries then
    return items
  end

  local seen = {}
  for _, entry in ipairs(entries) do
    -- Grab the file or directory name from the full path.
    local name = entry:match("([^/]+)$")
    if name then
      -- Optionally, filter by query: if query is not empty, only match names that start with it (case-insensitive)
      if query == "" or name:sub(1, #query):lower() == query:lower() then
        if not seen[name] then
          seen[name] = true
          local is_dir = vim.fn.isdirectory(entry) == 1
          local suffix = is_dir and "/" or ""
          table.insert(items, {
            label = name .. suffix,
            insertText = base .. name .. suffix,
            filterText = base .. name .. suffix,
            documentation = { kind = "markdown", value = "`" .. entry .. "`" },
            kind = is_dir and require("cmp").lsp.CompletionItemKind.Folder or require("cmp").lsp.CompletionItemKind.File,
          })
        end
      end
    end
  end
  return items
end

-------------------------------------------------
-- Custom env_path source for cmp
-------------------------------------------------

local function register_env_path_source()
  require("cmp").register_source("env_path", {
    keyword_length = 1,
    get_trigger_characters = function()
      return { "/", "~", "$" }
    end,
    complete = function(_, request, callback)
      local line = request.context.cursor_before_line
      local col = request.context.cursor.col
      -- Capture the last sequence of characters allowed in our tokens.
      local partial = line:sub(1, col):match("[%w_./~$-]+$") or ""
      print("env_path triggered! partial = " .. partial) -- DEBUG

      local items = {}
      -- If there is no slash in the typed text, treat it as a variable name candidate.
      if not partial:find("/") then
        items = suggest_env_variables(partial)
      else
        -- When the text includes a slash, split it into a base part and a query.
        -- The base is everything up to the last slash.
        local base = partial:match("^(.*[/])") or ""
        local query = partial:sub(#base + 1)
        local resolved = get_resolved_path(base)
        if vim.fn.isdirectory(resolved) == 1 then
          items = suggest_path_entries(resolved, query, base)
        end
      end

      callback({ items = items, isIncomplete = false })
    end,
  })
end

-------------------------------------------------
-- Setup function for cmp configuration
-------------------------------------------------

M.setup = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  require("luasnip.loaders.from_vscode").lazy_load()
  register_env_path_source()

  local cmp_config = {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = "env_path", priority = 1000 },
      { name = "path", priority = 900 },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
    }),
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },
  }

  cmp.setup(cmp_config)
  cmp.setup.filetype("markdown", cmp_config)

  vim.cmd([[highlight! default link CmpItemKind CmpItemMenuDefault]])
  vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
end

-------------------------------------------------
-- Return plugin spec for package manager
-------------------------------------------------

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    "saadparwaiz1/cmp_luasnip",
  },
  config = M.setup,
}
```
