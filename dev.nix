# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
    # Which nixpkgs channel to use.
    channel = "stable-24.05"; # or "unstable"
    # Use https://search.nixos.org/packages to find packages
    packages = [
        pkgs.php83
        pkgs.php83Packages.composer
        pkgs.nodejs_20
        pkgs.mariadb
        pkgs.laravel
    ];
    
    # Enable services like PostgreSQL and Docker
    services = {
        docker.enable = true;
        mysql.enable = true;
    };

    # Sets environment variables in the workspace
    env = {

    };

    idx = {
        # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
        extensions = [
        # "vscodevim.vim"
        ];
        # Enable previews
        previews = {
            enable = true;
            previews = {
                web = {
                    # command = [ "composer" "run" "dev" ];
                    command = ["php" "artisan" "serve" "--port" "$PORT" "--host" "0.0.0.0"];
                    manager = "web";
                };
            };
        };
        # Workspace lifecycle hooks
        workspace = {
        # Runs when a workspace is first created
            onCreate = {
                # Example: install JS dependencies from NPM
                # npm-install = "npm install";
                default.openFiles = [ ".idx/dev.nix" "README.md" ];
            };
            # Runs when the workspace is (re)started
            onStart = {
                # Example: start a background task to watch and re-build backend code
                # watch-backend = "npm run watch-backend";
            };
        };
    };
}
