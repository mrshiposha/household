{ pkgs, ... }: with pkgs; {
  programs.firefox = {
    enable = true;
    package = wrapFirefox firefox-esr-unwrapped {
      nixExtensions = [
        (fetchFirefoxAddon {
          name = "grammarly";
          url = "https://addons.mozilla.org/firefox/downloads/file/4002770/grammarly_1-8.904.0.xpi";
          hash = "sha256-RT4NFf3JEO7dyQE0WBC9/Z86cz15pFECqvubgyy4BeQ=";
        })

        (fetchFirefoxAddon {
          name = "polkadot-js";
          url = "https://addons.mozilla.org/firefox/downloads/file/3865101/polkadot_js_extension-0.41.1.xpi";
          hash = "sha256-jdvmVtu8EYBrcP31ufqkRBUk3fX7WluWDNvzd77PIlY=";
        })

        (fetchFirefoxAddon {
          name = "metamask";
          url = "https://addons.mozilla.org/firefox/downloads/file/4073640/ether_metamask-10.25.0.xpi";
          hash = "sha256-lTs4QdtoVe+CffsB5abf4q4BbWJmM7SGl2e1fgPwUqA=";
        })
      ];

      extraPolicies = {
        DisableTelemetry = true;
      };
    };
  };
}
