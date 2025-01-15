return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    if vim.fn.exists(":MarkdownPreviewToggle") == 2 then
      vim.fn["mkdp#util#install"]()
    end
  end,
}
