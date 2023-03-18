{
  description = "Iosevka Iaso fonts";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
      let pkgs = import nixpkgs {
          inherit system;
          };
      in {
          packages.default = pkgs.stdenvNoCC.mkDerivation {
            name = "iosevka-iaso";
            dontUnpack = true;
            buildPhase =
              let
                metric-override = {
                  cap = 790;
                  ascender = 790;
                  xHeight = 570;
                };
                iosevka-term = pkgs.iosevka.override {
                  set = "curly";
                  privateBuildPlan = {
                    family = "Iosevka Term Iaso";
                    spacing = "term";
                    serifs = "sans";
                    no-ligation = false;
                    ligations = {
                      "inherit" = "default-calt";
                    };
                    no-cv-ss = true;
                    variants = {
                      inherits = "ss01";
                      design = {
                        tilde = "low";
                        number-sign = "slanted-tall";
                        at = "fourfold-solid-inner-tall";
                      };
                    };
                    slopes.upright = {
                      angle = 0;
                      shape = "upright";
                      menu = "upright";
                      css = "normal";
                    };
                    weights.regular = {
                      shape = 400;
                      menu = 400;
                      css = 400;
                    };
                    widths.normal = {
                      shape = 600;
                      menu = 7;
                      css = "expanded";
                    };
                    inherit metric-override;
                  };
                };
                iosevka-aile = pkgs.iosevka.override {
                  set = "aile";
                  privateBuildPlan = {
                    family = "Iosevka Aile Iaso";
                    spacing = "quasi-proportional-extension-only";
                    no-ligation = true;
                    no-cv-ss = true;
                    variants = {
                      inherits = "ss01";
                      design = {
                        tilde = "low";
                        number-sign = "slanted-tall";
                        at = "fourfold-solid-inner-tall";
                      };
                    };
                    slopes = {
                      upright = {
                        angle = 0;
                        shape = "upright";
                        menu = "upright";
                        css = "normal";
                      };
                      italic = {
                        angle = 9.4;
                        shape = "italic";
                        menu = "italic";
                        css = "italic";
                      };
                    };
                    weights.regular = {
                      shape = 400;
                      menu = 400;
                      css = 400;
                    };
                    widths.normal = {
                      shape = 550;
                      menu = 7;
                      css = "expanded";
                    };
                    inherit metric-override;
                  };
                };
                iosevka-etoile = pkgs.iosevka.override {
                  set = "etoile";
                  privateBuildPlan = {
                    family = "Iosevka Etoile Iaso";
                    spacing = "quasi-proportional";
                    serifs = "slab";
                    no-ligation = true;
                    no-cv-ss = true;
                    variants = {
                      inherits = "ss01";
                      design = {
                        capital-w = "straight-flat-top";
                        f = "flat-hook-serifed";
                        j = "flat-hook-serifed";
                        t = "flat-hook";
                        capital-t = "serifed"; # not part of original Iosevka Aile
                        w = "straight-flat-top";
                        #capital-g = "toothless-rounded-serifless-hooked";
                        r = "corner-hooked";

                        tilde = "low";
                        number-sign = "slanted-tall";
                        at = "fourfold-solid-inner-tall";
                      };
                      italic = {
                        f = "flat-hook-tailed";
                      };
                    };
                    slopes = {
                      upright = {
                        angle = 0;
                        shape = "upright";
                        menu = "upright";
                        css = "normal";
                      };
                      italic = {
                        angle = 9.4;
                        shape = "italic";
                        menu = "italic";
                        css = "italic";
                      };
                    };
                    weights.regular = {
                      shape = 400;
                      menu = 400;
                      css = 400;
                    };
                    widths.normal = {
                      shape = 600;
                      menu = 7;
                      css = "expanded";
                    };
                    inherit metric-override;
                  };
                };
              in
              ''
                mkdir -p ttf
                for ttf in ${iosevka-term}/share/fonts/truetype/*.ttf ${iosevka-aile}/share/fonts/truetype/*.ttf ${iosevka-etoile}/share/fonts/truetype/*.ttf; do
                  cp $ttf .
                  ${pkgs.woff2}/bin/woff2_compress *.ttf
                  mv *.ttf ttf
                done
              '';
            installPhase = ''
              mkdir -p $out
              cp *.woff2 $out
              cp ttf/*.ttf $out
            '';
          };       
      });
}
