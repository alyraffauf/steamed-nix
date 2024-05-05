{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    alyraffauf.apps.vsCodium.enable = lib.mkEnableOption "Enables VSCodium.";
  };

  config = lib.mkIf config.alyraffauf.apps.vsCodium.enable {
    alyraffauf.apps.alacritty.enable = lib.mkDefault true;

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      userSettings = {
        "diffEditor.ignoreTrimWhitespace" = false;
        "editor.fontFamily" = "'${config.alyraffauf.desktop.theme.terminalFont.name}', 'monospace', monospace";
        "explorer.confirmDelete" = false;
        "files.autoSave" = "afterDelay";
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
        "terminal.external.linuxExec" = "${pkgs.alacritty}/bin/alacritty";
        "update.mode" = "none";
        "window.menuBarVisibility" = "hidden";
        "window.zoomPerWindow" = false;
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "workbench.iconTheme" = "catppuccin-macchiato";
        "workbench.preferredDarkColorTheme" = "Catppuccin Macchiato";
        "workbench.preferredLightColorTheme" = "Catppuccin Latte";
      };

      extensions = with pkgs; [
        vscode-extensions.catppuccin.catppuccin-vsc
        vscode-extensions.catppuccin.catppuccin-vsc-icons
        vscode-extensions.github.vscode-github-actions
        vscode-extensions.github.vscode-pull-request-github
        vscode-extensions.jnoortheen.nix-ide
        vscode-extensions.justusadam.language-haskell
        vscode-extensions.ms-python.python
        vscode-extensions.ms-vscode.cpptools-extension-pack
        vscode-extensions.rubymaniac.vscode-paste-and-indent
        vscode-extensions.rust-lang.rust-analyzer
        vscode-extensions.tomoki1207.pdf
      ];
    };
  };
}
