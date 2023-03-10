{
  description = "Scripts for personal use";

  inputs =  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    tmux-sessionizer = pkgs.writeShellApplication {
      name = "tmux-sessionizer";
      runtimeInputs = with pkgs; [ tmux fd fzf ];
      text = builtins.readFile ./tmux-sessionizer.sh;
    };
  in {
    packages.${system}.tmux-sessionizer = tmux-sessionizer;
    overlays.tmux-sessionizer = _: _: { inherit tmux-sessionizer; };
  };
}
