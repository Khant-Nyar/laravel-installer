{ pkgs, version ? "latest", ... }: {
	
    packages = [
        pkgs.php83
        pkgs.php83Packages.composer
        pkgs.nodejs_20
        pkgs.mariadb
    ];
    services = {
        docker.enable = true;
        mysql.enable = true;
    };

    bootstrap = ''
        mkdir composer-home
        export COMPOSER_HOME=./composer-home
			mkdir "$out"
        composer global require laravel/installer
        export PATH=~/.config/composer/vendor/bin:$PATH
        
        laravel new "$out" ${if unit_test == "pest" then "--pest" else "--phpunit"}
        # composer create-project laravel/laravel "$out"
		# 	mkdir -p "$out"/.idx
  		cp ${./dev.nix} "$out"/.idx/dev.nix
    '';
}