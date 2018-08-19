{ callPackage }:

(callPackage ./3.x.nix {}).overrideAttrs (oldAttrs: {
  patches = oldAttrs.patches ++ [ ./typeahead.patch ];
})
