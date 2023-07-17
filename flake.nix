{
  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      system = system;
    };
    mkShell = nixpkgs.mkShell.override {
      stdenv = nixpkgs.stdenvAdapters.useMoldLinker nixpkgs.stdenv;
    };
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.mold
        pkgs.pkgconfig
        pkgs.openssl.dev
        pkgs.sqlite.dev
        pkgs.cargo
        pkgs.rustc
        pkgs.rustfmt
        pkgs.rust-analyzer
      ];
    };
  };
}
