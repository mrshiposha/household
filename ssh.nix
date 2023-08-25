{
    services = {
        openssh = {
            enable = true;
            settings = {
                PasswordAuthentication = false;
                KbdInteractiveAuthentication = false;
                PermitRootLogin = "no";
                LogLevel = "VERBOSE";
            };
        };

        fail2ban = {
            enable = true;
            maxretry = 5;
            ignoreIP = [ "192.168.0.0/16" ];
            bantime = "24h";
            bantime-increment = {
                enable = true;
                multipliers = "1 2 4 8";
                maxtime = "192h";
                overalljails = true;
            };
        };
    };
}
