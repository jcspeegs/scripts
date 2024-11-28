{
  description = "Scripts for personal use";

  inputs =  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils } @ inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        tmux-sessionizer = pkgs.writeShellApplication {
          name = "tmux-sessionizer";
          runtimeInputs = with pkgs; [ tmux fd fzf ];
          text = builtins.readFile ./tmux-sessionizer.sh;
        };
      in {
        packages."tmux-sessionizer" = tmux-sessionizer;
        overlays."tmux-sessionizer" = _: _: { inherit tmux-sessionizer; };
      }
  );
}
