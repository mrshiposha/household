# This file contains fleet state and shouldn't be edited by hand

{
  version = "0.1.0";
  gcRootPrefix = "fleet-gc-eT5oBjPe";
  hosts = {
    hearthstone.encryptionKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDXcYM8CidFpAdgqor2t0xYHvbOFdKeS0xBYGo3lJX3d root@nixos";
    satellite.encryptionKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWAjQXamZbDHbf0qDtjrUEljUJLMWL1AZQxEUy9wUIp root@satellite";
    sentinel.encryptionKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAvG/Y3msJtoZiTZGNKZ+/hINXmO6saD606+DRpYGJK5 root@nixos";
  };
  hostSecrets = {
    hearthstone.valheim = {
      createdAt = "2025-04-23T18:59:59.769878024Z";
      secret.raw = ''
        <ENCRYPTED><BASE64-ENCODED>
        YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNzaC1lZDI1NTE5IGp6VW1OQSAydzFE
        bHhVbjRqZFd6Q2hLTy9xR2QvUFNuejhkSDc5SzdCK2tNRUpEVWpzCnp1ZDg5czUz
        eU5mRDY4NnVQakp0c1hXc1kzV2x2SnlOL3VoemkyQW5hN0EKLT4gbicrNXJeNy1n
        cmVhc2UgeiBZMDw/ZHhzOiB9YCEzJyJvIEV5SUAwCmtqdThZWGJGNFZVaDEvbVk4
        NDh2WU8vK2pMd0gzN2M5dGI4Ci0tLSBxWHIyTElQRG9nMnpJWFZhc0p5SmEwUGdB
        ZUx2WHZaR1Z3djAreVh6VlJRCiK/9ZnQOxNrAOjyeoWH//WD6nKfoId7Vr/1SW8+
        +5BirxU+xT0SyD9Jtpk
      '';
    };
    satellite.dev-email = {
      createdAt = "2025-01-11T03:06:56.861673199Z";
      secret.raw = ''
        <ENCRYPTED><BASE64-ENCODED>
        YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNzaC1lZDI1NTE5IFlIeGt1ZyBUVE9i
        ZW1VenNaRGlkTE1TZ2l5eVJ5MitIdi9WcU1UTGdWMHgrTjJJalVJClVWRzE1SHRr
        NWdDZ1lNNzhPcjJ2YjBWVklWcFVTZ1VvSGlpbEVNYUhBTXMKLT4gZS1ncmVhc2UK
        THVRTDhTaGVwRGFTSTRJdk0vUkpRbGZ3VElEZnBJdVNaa1NQWHBPSkVBUWE2SXBJ
        eHlwbG45ZHl3bEtlMnJBMgpsbTFqbUc3dUl5clYvL0tIVktkRHVTRWQwUlVLaHhP
        M3NPTXZKTW8KLS0tIEZjY2VPc1BkUjlPbUtFNU1Hbm5uRnIyV3cydFV5SjgwVG1s
        TjVOS0NubE0Kj+T0g1MeCIHOme2VljB/0qdFhrqWeLCsIjX9OagTiUwExedF8m4v
        UfjwIgLe7Purag
      '';
    };
    sentinel = {
      coturn = {
        createdAt = "2025-01-07T17:27:59.638479879Z";
        secret.raw = ''
          <ENCRYPTED><BASE64-ENCODED>
          YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNzaC1lZDI1NTE5IGswbklHQSByMHFI
          akRCb3ZaNElwRENPaHFRb2FyVm83R1VNSFpqbTkxQjFEZDdKa0VRCkU5MndMRGdF
          MllSYVd3NzVaY3M4ZmhpTVp5UlRoK29FTVpqSytWMFJGZ3MKLT4gM1VdTDd9TS1n
          cmVhc2UgLWosekZmWmYKOGhLS0diVXpCS0FDeHZ3U084TityV1VYNGFKMW1DR0dY
          SWlsNm5VdkJpSE5HUjhubGdCU3hsdERwZTFwYUxzWgpUdmtkbmgyV1JORC82bCt0
          QnNyQWx4Y1J3L3ZCN2xpYytsakptYlIvcHI4QVFJdkgKLS0tIHBLUWlYUGU3R1lN
          d3JWK1lKRlJKaTBnK3N0NzdHSExyc21tTHg0RDBxOEkK9y1rD0Y2TtGRnlDfO84Q
          Kwnpa0vEqLKSrqpUGhiMVgbRKbxz1iJ/5R6z0ZWeHLA4W2N2GFS6+wrJJCW4DROH
          rQ
        '';
      };
      netbird-client = {
        createdAt = "2025-01-06T02:58:37.479370880Z";
        secret.raw = ''
          <ENCRYPTED><BASE64-ENCODED>
          YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNzaC1lZDI1NTE5IGswbklHQSAzVTBY
          ZVR0MktyTEQ2UGhVTC82M1hUZndPQi9BYXlhTjRkajZDU29ERGw0CmNUSVR2M1Na
          TEtJblp2ZlJHcUN1YWw5WGNYM0V3N3NEckpMSTVYMDk5NGMKLT4gOkkuJD0tZ3Jl
          YXNlIC1aYSBUZmg2LwplaVR2UWRURkJLMWhjSVJRdUFVRGhkcVhPb01BRFhpQlNL
          ejZrTzl1L1hLT3ZkRW80ZEh3cVlydmdBVmlKMXB6CkFPempyU1hCY3FYUFloTzhv
          bmZNM3BzRmlKbG0vbnNxeE9IZ3Z1SWVlUQotLS0gckM0WmxQdEthSnJkMXdlTEJx
          dFQralZtYVFyOFpRd1FSYXdpWHFjVTM4RQr0c8pLs5lNKkpPQ4nJxGj4yEka/f44
          Hqm9IFH6g0u0wf4OGYf8IJSwMBuepecxYlgSm/VMW4IBAu/+/Z+YXQbPTm/1r1cX
          mjTxEKNEuPt/KLggAii8vh4+22oKbpwI5gJG
        '';
      };
      netbird-key = {
        createdAt = "2025-01-05T23:45:07.852480138Z";
        secret.raw = ''
          <ENCRYPTED><BASE64-ENCODED>
          YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNzaC1lZDI1NTE5IGswbklHQSBRVWdz
          SENIbkxKSVJpeDVTWExzaURzQk9lb3QrME1teDBVUlJTYlIwUkRNClhQQ2xBTE5W
          TFE5RkRMbjFVZnRNb1ZLNUpnYUsvQXJadDlwaHVhRURUTG8KLT4gcnZuLWdyZWFz
          ZSBCUCQoIDg+VFpVfiBPV3o2bD4gaVh3TGBTfApkYTY0bUdVWklYVGlGdlJsZ0d0
          bzlMYjZaWExRS1A5czZLQ0RzWkNnMWMwRTduQzc1Nm5LLzhjanRHQkhuTVBICnVX
          NlJrUVB2WU56QXEvTXc3MmtEd1lNVmE0ZURDWFpoZVZlRFRMdFk1R0ZML0NsV1l3
          VXdiRGFaCi0tLSBUYUJOa1MvTEQzOW80dFBybzVoRHpEODZDekFXS1dVRWpVclVW
          UzYvdGF3Cl2E7JTRa94M3kTFwDSWHz6UbwQXfwCYeF9+Q90u4KDClz0cwXic1H+g
          d26E3nOO9KICiUTVjT8gQIOLXQTDe6p/JJ2m6eLUW+nXqwqB
        '';
      };
      netbird-turn = {
        createdAt = "2025-01-05T21:33:59.474646406Z";
        secret.raw = ''
          <ENCRYPTED><BASE64-ENCODED>
          YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNzaC1lZDI1NTE5IGswbklHQSBta05x
          M2x0NWhyalJNVmdmK1duY0tQZkQ1cnBMdXBLVTllUEtnUk1OWDB3CnVWc2p0M1NM
          VWxqRWhlbHJwblVsa1BQTjF4WjZERGdRc1Q0UDdObURPZzAKLT4gXXsxcS1ncmVh
          c2UgciEpNzxvCi83eVMvZ0x6ZERmejZsUTR3VGpTSFZJMlFJMk5FckdRUGNDUjNC
          N1NZZGVCQmV2VGVldGxmK1VRcU5CdlZNYWgKYWVRNnFZd1c0K1BZLzA3aAotLS0g
          Zy96TU42U2pLOVMyeXVPZXdESFBDYkRFNjFjY1lZWENTRWxEdVJuQlFTWQqAeGoG
          m0ruTqbRJVbXd+yK2ze3JUyyxPm/vLfQS0+j5aCKaXhmuTp2hAcPRO+b15O9ZqRJ
          KsJOs++N2mmrZFh+gG0GTGmwYuiUvL1utN+8hbmEonznMRpHiPJYowrxigzp
        '';
      };
      zitadel = {
        createdAt = "2025-01-04T17:09:30.956697722Z";
        secret.raw = ''
          <ENCRYPTED><BASE64-ENCODED>
          YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNzaC1lZDI1NTE5IGswbklHQSBNVXg4
          Q0xtZ1FGVDRkdG5YRXlCYjRNQTZCdHo1bE1mT0lNOGViOHNnN2k4Ckd6ZzlXZlkx
          SVVsVmwyb3ZTbXU4dDBJWUNPd3IycmJHTHFwaGRQVlNnclUKLT4gdi1ncmVhc2Ug
          diRhc2QgJDIiWFVmJQpORXJJYkVvNTE1akVYakVTNjRZQk9FNmJ2ZVhtUGxMTAot
          LS0gQmpFMmpmekxzZjVKOG5zbHFyVjhvUjhoQ0UxTFFma1oxWDU0Qm9nbk5pUQoT
          GqcJcjumCDzlh2QTuGuS97SXHRVdSE3XxnR3sDcj2O0EWw6odXSag2v+Bid4rIl7
          4q2tluJWZz4YPjleXrXm
        '';
      };
    };
  };
}


# vim: ts=2 et nowrap
