{ stdenv, callPackage, fetchpatch
# Darwin frameworks
, Cocoa, CoreMedia
, ...
}@args:

callPackage ./generic.nix (args // rec {
  version = "${branch}";
  branch = "3.2.13";
  sha256 = "0h10zvi6q9lqdbk3gb4zhlxggcgqa04s0w2gwaxcz0cnchfbddg5";
  darwinFrameworks = [ Cocoa CoreMedia ];
})
