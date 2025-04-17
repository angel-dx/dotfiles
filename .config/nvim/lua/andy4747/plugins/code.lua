return {
   -- markdown preview
   {
      "iamcco/markdown-preview.nvim",
      cmd = {"MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"},
      ft = {"markdown"},
      build = ":call mkdp#util#install()",
      keys = {
         {"<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview"}
      }
   },
   {
      "MeanderingProgrammer/render-markdown.nvim",
      dependencies = {"nvim-treesitter/nvim-treesitter"},
      opts = {}
   }
}