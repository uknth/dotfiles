return {
  {
    "williamboman/mason.nvim",
    opts = {
      -- language servers that are needed
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "gopls",
        "google-java-format",
        "java-language-server",
      },
    },
  },
}
