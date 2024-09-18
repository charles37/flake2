final: prev: {
  hyprland = prev.hyprland.overrideAttrs (oldAttrs: {
    version = "unstable-2024-09-17"; # Update this date as needed
    src = prev.fetchFromGitHub {
      owner = "hyprwm";
      repo = "hyprland";
      rev = "master"; # This will fetch the latest commit on the master branch
      sha256 = "sha256-0000000000000000000000000000000000000000000="; # Replace with the correct hash
    };

    # Remove the patch that's causing issues
    patches = [];

    # Ensure build system is using C++23
    cmakeFlags =
      (oldAttrs.cmakeFlags or [])
      ++ [
        "-DCMAKE_CXX_STANDARD=23"
      ];
  });
}
