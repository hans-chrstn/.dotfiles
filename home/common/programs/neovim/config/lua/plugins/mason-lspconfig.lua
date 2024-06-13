return {
  "williamboman/mason-lspconfig.nvim",
  after = { "mason.nvim", "nvim-lspconfig" },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { 
        "lua_ls",
    	  "rust_analyzer",
        "clangd",
		    "cssls",
		    "html",
		    "tsserver",
		    "jdtls",
		    "marksman",
		    "pyright",
		    "nil_ls",
		    "bashls", 
      }
    })
  end
}
