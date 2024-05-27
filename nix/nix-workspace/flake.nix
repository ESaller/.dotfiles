# flake.nix skeleton:

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
  outputs = { self, nixpkgs }: {
    # Here we are defining a package set for the 'aarch64-darwin' system, which is 
    # the architecture for Apple Silicon (M1, M1 Pro, etc.).
    packages."aarch64-darwin".default = let
      # 'pkgs' is a shorthand for the package set available for 'aarch64-darwin'
      # within 'nixpkgs'. We use the 'legacyPackages' attribute to access the packages.
      pkgs = nixpkgs.legacyPackages."aarch64-darwin";
    in
      # 'buildEnv' is a function that allows us to create an environment which includes
      # multiple packages. We use it here to define a custom environment named 'home-packages'.
      pkgs.buildEnv {
        # The name of the environment, which can be anything you choose.
        name = "workspace";
        # 'paths' defines the list of packages that will be included in this environment.
        # We use the 'with' keyword to bring 'pkgs' into scope, allowing us to list packages
        # without prefixing them with 'pkgs.' each time.
        paths = with pkgs; [
          # Here we list the packages we want to include. We start with 'git', which is
          # a widely-used version control system.
          # You can add additional packages to this list as needed.
          # Just list their names here, and Nix will handle the installation.
          

          #handbrake
          #nodePackages."@nrwl/cli"
          #packer
          #terraform
          #vagrant
          #vlc
          ansible
          awscli
          cargo
          curl
          fasd
          ffmpeg
          fzf
          git
          graphviz
          htop
          imagemagick
          inetutils
          jq
          kitty
          less
          lua
          mosh
          neovim
          nmap
          nodePackages."@angular/cli"
          nodejs
          nodejs
          go
          pandoc
          pgcli
          pipx
          podman
          poetry
          python3
          rclone
          ripgrep
          rsync
          rustc
          stow
          tmux
          wget
          wireshark
          yarn
          zoxide
          zsh
        ];
      };
  };
}
