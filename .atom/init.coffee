atom.commands.add 'atom-text-editor',
  # Crate function to enable/disable all packages related to vim
  # This will also enable/disable the use of relative numbers
  'user:toggle-vim-mode-plus': (event) ->
    if atom.packages.isPackageDisabled("vim-mode-plus")
      atom.packages.enablePackage("vim-mode-plus")
      atom.packages.enablePackage("atom-keyboard-macros-vim")
      atom.packages.enablePackage("vim-mode-plus-keymaps-for-surround")
      atom.packages.enablePackage("relative-numbers")
    else
      atom.packages.disablePackage("vim-mode-plus")
      atom.packages.disablePackage("atom-keyboard-macros-vim")
      atom.packages.disablePackage("vim-mode-plus-keymaps-for-surround")
      atom.packages.disablePackage("relative-numbers")
