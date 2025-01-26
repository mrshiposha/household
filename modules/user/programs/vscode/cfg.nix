let 
scrollSpeed = 5;
settings = {
  files.insertFinalNewline = true;
  editor.fontLigatures = true;
  editor.renderWhitespace = "all";
  editor.fontSize = 15.5;
  window.zoomLevel = 1.5;
  window.menuBarVisibility = "toggle";

  editor.fontFamily = "monospace";
  editor.cursorBlinking = "solid";
  terminal.integrated.fontFamily = "monospace, MesloLGS NF";

  editor.cursorSmoothCaretAnimation = "on";
  editor.smoothScrolling = true;
  workbench.list.smoothScrolling = true;
  terminal.integrated.smoothScrolling = true;
  editor.fastScrollSensitivity = scrollSpeed;
  scrollFaster.cursorFollowsScroll = true;

  typst-preview.invertColors = "auto";

  RainbowBrackets.depreciation-notice = false;

  nix = {
    enableLanguageServer = true;
    serverPath = "nil";
    serverSettings = {
      nil.formatting.command = [ "nixpkgs-fmt" ];
    };
  };

  lldb.suppressUpdateNotifications = true;
  workbench.colorTheme = "Nord";

  vim =
    let
      bindings = {
        save = {
          before = [ "<C-s>" ];
          commands = [ "workbench.action.files.save" ];
          after = [ "<ESC>" ];
          silent = true;
        };
        showCommands = {
          before = [ ":" ];
          commands = [
            "workbench.action.showCommands"
          ];
          silent = true;
        };
        openSession = {
          before = [ "<Tab>" "s" ];
          commands = [
            "workbench.action.openRecent"
          ];
        };
        scroll = {
          up = {
            before = [ "<C-Up>" ];
            after = [ "<ESC>" scrollSpeed "<C-y>" ];
          };
          down = {
            before = [ "<C-Down>" ];
            after = [ "<ESC>" scrollSpeed "<C-e>" ];
          };
        };
        gotoEol = {
          before = [ "-" ];
          after = [ "$" ];
        };
        gotoBot = {
          before = [ "<leader>" "0" ];
          after = [ "^" ];
        };
        gotoEot = {
          before = [ "<leader>" "-" ];
          after = [ "g" "_" ];
        };
        normalHorMove = {
          left = {
            before = [ "<leader>" "<Left>" ];
            after = [ "<" "<" ];
          };
          right = {
            before = [ "<leader>" "<Right>" ];
            after = [ ">" ">" ];
          };
        };
        visualHorMove = {
          left = {
            before = [ "<leader>" "<Left>" ];
            after = [ "<" "g" "v" ];
          };
          right = {
            before = [ "<leader>" "<Right>" ];
            after = [ ">" "g" "v" ];
          };
        };
      };
    in
    {
      enableNeovim = true;
      useSystemClipboard = true;

      leader = " ";
      normalModeKeyBindingsNonRecursive = with bindings; [
        save
        showCommands
        openSession
        scroll.up
        scroll.down
        gotoEol
        gotoBot
        gotoEot
        normalHorMove.left
        normalHorMove.right
      ];
      visualModeKeyBindingsNonRecursive = with bindings; [
        save
        scroll.up
        scroll.down
        gotoEol
        gotoBot
        gotoEot
        visualHorMove.left
        visualHorMove.right
      ];
      insertModeKeyBindingsNonRecursive = with bindings; [
        save
        scroll.up
        scroll.down

        {
          before = [ "<ESC>" ];
          after = [ "<ESC>" "l" ];
        }
      ];
      useCtrlKeys = true;
      handleKeys = {
        "<C-s>" = true;
        "<C-Up>" = true;
        "<C-Down>" = true;
        "<C-a>" = false;
        "<C-f>" = false;
      };
    };
};
keybindings = [];
in {
  inherit settings keybindings;
}
