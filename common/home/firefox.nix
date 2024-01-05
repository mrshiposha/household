{ pkgs, ... }: 
let extensionUrl = name: version: "https://addons.mozilla.org/firefox/downloads/latest/${name}/${version}.xpi";
in with pkgs; {
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;

      Preferences = {
        xpinstall.signatures.required = false;
      };

      Extensions = {
        Install = [
          (extensionUrl "grammarly-1" "latest")
          (extensionUrl "polkadot-js-extension" "latest")
          (extensionUrl "ether-metamask" "latest")
          (extensionUrl "easy-youtube-video-download" "latest")
        ];
      };
    };
  };
}
