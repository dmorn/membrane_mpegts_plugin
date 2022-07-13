{
  description = "Membrane Multimedia Framework (MPEG-TS Plugin)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        beam = pkgs.beamPackages;
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            elixir

	    pkg-config
	    openssl
          ];
          shellHook = ''
            mkdir -p .nix-mix
            mkdir -p .nix-hex
            export MIX_HOME=$PWD/.nix-mix
            export HEX_HOME=$PWD/.nix-hex
            export PATH=$MIX_HOME/bin:$PATH
            export PATH=$HEX_HOME/bin:$PATH
            export PATH=$MIX_HOME/escripts:$PATH
	    export ERL_AFLAGS="-kernel shell_history enabled"
          '';
        };
      });
}
