atom.commands.add 'atom-text-editor',
  # Crate function to enable/disable all packages related to vim
  'user:toggle-vim-mode-plus': (event) ->
    if atom.packages.isPackageDisabled("vim-mode-plus")
      atom.packages.enablePackage("vim-mode-plus")
      atom.packages.enablePackage("atom-keyboard-macros-vim")
      atom.packages.enablePackage("vim-mode-plus-keymaps-for-surround")
    else
      atom.packages.disablePackage("vim-mode-plus")
      atom.packages.disablePackage("atom-keyboard-macros-vim")
      atom.packages.disablePackage("vim-mode-plus-keymaps-for-surround")
