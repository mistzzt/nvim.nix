{
  description = "Standalone nixvim configuration, shared between machines";

  inputs = {
    systems.url = "github:nix-systems/default";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = {
    self,
    systems,
    nixvim,
  }: let
    # no own nixpkgs input: build against the pin nixvim is CI-tested with
    inherit (nixvim.inputs) nixpkgs;

    forAllSystems = nixpkgs.lib.genAttrs (import systems);

    evalFor = system:
      nixvim.lib.evalNixvim {
        inherit system;
        modules = [self.nixvimModules.default];
      };
  in {
    # prefix-free modules: import standalone or under programs.nixvim
    nixvimModules.default = ./modules;

    packages = forAllSystems (system: {
      default = (evalFor system).config.build.package;
    });

    # nixvim's headless smoke test
    checks = forAllSystems (system: {
      default = (evalFor system).config.build.test;
    });
  };
}
