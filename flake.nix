{
  description = "Iosevka Iaso fonts";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenvNoCC.mkDerivation {
          name = "iosevka-iaso";
          dontUnpack = true;
          buildInputs = with pkgs; [ python311Packages.brotli python311Packages.fonttools ];
          buildPhase = let
            metric-override = {
              cap = 790;
              ascender = 790;
              xHeight = 570;
            };
            iosevka-curly = pkgs.iosevka.override {
              set = "curly";
              privateBuildPlan = {
                family = "Iosevka Curly Iaso";
                spacing = "term";
                serifs = "sans";
                no-ligation = false;
                ligations = { "inherit" = "default-calt"; };
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
                    i = "zshaped";
                    r = "serifed";

                    tilde = "low";
                    number-sign = "slanted-tall";
                    at = "fourfold-solid-inner-tall";
                  };
                  italic = { f = "flat-hook-tailed"; };
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
          in ''
            mkdir -p ttf
            for ttf in ${iosevka-curly}/share/fonts/truetype/*.ttf ${iosevka-aile}/share/fonts/truetype/*.ttf ${iosevka-etoile}/share/fonts/truetype/*.ttf; do
              cp $ttf .

              name=`basename -s .ttf $ttf`
              pyftsubset \
                $ttf \
                --output-file="$name".woff2 \
                --flavor=woff2 \
                --layout-features=* \
                --no-hinting \
                --desubroutinize \
                --unicodes="U+0000-00A0,U+00A2-00A9,U+00AC-00AE,U+00B0-00B7,U+00B9-00BA,U+00BC-00BE,U+00D7,U+00F7,U+2000-206F,U+2074,U+20AC,U+2122,U+2190-21BB,U+2212,U+2215,U+F8FF,U+FEFF,U+FFFD"
              mv *.ttf ttf
            done
          '';
          installPhase = ''
            mkdir -p $out
            cp *.woff2 $out
            cp ttf/*.ttf $out

            cp ${src/family.css} $out/family.css
          '';
        };
      });
}
