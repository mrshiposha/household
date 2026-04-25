{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.emacs.enable = mkEnableOption "emacs";

  config.programs.emacs = {
    enable = config.emacs.enable;
    package = pkgs.emacs-pgtk;
    extraPackages =
      epkgs: with epkgs; [
        nord-theme
        agda2-mode
        direnv
      ];
    extraConfig = ''
      (custom-set-variables
       '(custom-enabled-themes '(nord))
        '(custom-safe-themes
           '("7addbdeb9a444444c3114f228808c398eff733b0bd6e3050469b46f4d88c55d6"
             default)))

      (set-frame-parameter nil 'alpha-background 70)
      (add-to-list 'default-frame-alist '(alpha-background . 70))

      (defun on-after-init ()
        (unless (display-graphic-p (selected-frame))
          (set-face-background 'default "unspecified-bg" (selected-frame))))

      (add-hook 'window-setup-hook 'on-after-init)

      (global-display-line-numbers-mode 1)
      (direnv-mode)
    '';
  };
}
