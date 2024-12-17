{
  description = "Clear the fprintd storage the easy way";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux" "riscv64-linux"];
  in {
    apps = forAllSystems (system: rec {
      default = fprint-clear;
      fprint-clear = {
        type = "app";
        program = self.packages.${system}.fprint-clear;
      };
    });
    packages = forAllSystems (system: rec {
      default = fprint-clear;
      fprint-clear = nixpkgs.legacyPackages.${system}.callPackage ./package.nix { };
    });
    devShells = forAllSystems (system: rec {
      default = fprint-clear;
      fprint-clear = nixpkgs.legacyPackages.${system}.mkShell {
        name = "fprint-clear";
        inputsFrom = [self.packages.${system}.fprint-clear];
        packages = [self.packages.${system}.fprint-clear];
        shellHook = ''
          echo -e "[fprint-clear] Clear out your fingerprint scanner\n"
          echo -e 'This development shell contains a Python 3 script to clear your fingerprint scanner'
          echo -e 'along with all its dependencies, which are available in this shell environment.\n'
          echo -e 'Run the script using the command:\n'
          echo -e '  $ sudo fprint-clear'
          echo -e '\n  --or--\n'
          echo -e 'Fiddle around in this shell environment with the necessary deps to work with fprintd'
        '';
      };
    });
  };
}
