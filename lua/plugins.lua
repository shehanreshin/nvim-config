return {
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
     dependencies = { 'nvim-lua/plenary.nvim' }
  }
}
