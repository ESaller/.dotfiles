{
  # The 'inputs' section of a flake.nix file specifies external dependencies or resources
  # that our flake will rely on. Here we define a single input.
  inputs = {
    # 'nixpkgs' is a reference to the Nix packages collection, which provides a large
    # catalog of software packaged for use with Nix. We specify that we want to use
    # the 'nixpkgs' collection from the 'NixOS' organization on GitHub.
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  # The 'outputs' function is where the bulk of a flake's functionality is defined.
  # It takes the inputs defined above and produces a set of derivations.
  outputs = { self, nixpkgs }:
    let
      # Here, we list all the systems we want to support.
      # 'aarch64-darwin' is for Apple Silicon Macs.
      # 'x86_64-linux' and 'aarch64-linux' are for Linux platforms.
      systems = [ "aarch64-darwin" "x86_64-linux" "aarch64-linux" ];

      # A helper function that produces an attribute set mapping each system
      # to its corresponding packages.
      forAllSystems = f: builtins.listToAttrs (map (system: {
        name = system;
        value = f system;
      }) systems);
    in
    {
      packages = forAllSystems (system:
        let
          # Import the package set for the current system, and allow unfree packages.
          pkgs = import nixpkgs {
            inherit system;
            config = {
              # Set 'allowUnfree' to true to allow installation of unfree packages.
              allowUnfree = true;
            };
          };
        in
        {
          # Define the 'default' package environment for each system.
          default = pkgs.buildEnv {
            # The name of the environment, which can be anything you choose.
            name = "workspace";

            # 'paths' defines the list of packages to include in this environment.
            # This block selects a package list depending on the platform.
            # For Mac (aarch64-darwin), we use your detailed list and comments.
            # For Linux, you can fill in or modify your packages as needed.
            paths = with pkgs; (
              if system == "aarch64-darwin" then [
                # ----- Mac Packages -----
                #handbrake
                #nodePackages."@nrwl/cli"
                #packer
                #terraform
                #vagrant
                #vlc
                _1password-cli
                #ansible
                #autotrace
                #awscli
                #cargo
                curl
                fasd
                ffmpeg
                #fuse
                fzf
                git
                gimp
                graphviz
                htop
                #inkscape
                imagemagick
                inetutils
                jq
                #kitty
                less
                lua
                neovim
                #nerdfonts
                #nixfmt-rfc-style
                nmap
                #nodePackages."@angular/cli"
                #nodejs
                ollama
                #go
                pandoc
                pgcli
                pipx
                podman
                podman-compose
                potrace
                colima
                docker
                docker-compose
                poetry
                pv
                #python3
                python310
                protobuf
                rclone
                ripgrep
                rsync
                rustc
                screenfetch
                stow
                tmux
                tree
                wget
                #wireshark
                #yarn
                zoxide
                zsh
                terraform
                # Mac only
                #hexfiend
                #osmctools
                #osmium-tool
                #aria2
                #toybox
              ] else [
                # ----- Linux Packages -----
                fasd
                ffmpeg
                fzf
                git
                htop
                jq
                lua
                neovim
                rclone
                rsync
                screenfetch
                stow
                tmux
                tree
                wget
                zsh
              ]
            );
          };
        }
      );
    };
}
