final: prev: {
  hyprland = prev.hyprland.overrideAttrs (oldAttrs: {
    version = "unstable-2024-09-18"; # Update this date as needed
    src = prev.fetchFromGitHub {
      owner = "hyprwm";
      repo = "hyprland";
      rev = "master"; # This will fetch the latest commit on the master branch
      sha256 = "sha256-5Hfc/S+npWeApMrqczhy+ky1Py8VsfMQmtmgjFXdUWo=";
    };

    # Remove the patch that's causing issues
    patches = [];

    # Ensure build system is using C++23

    # Ensure build system is using C++23
    cmakeFlags =
      (oldAttrs.cmakeFlags or [])
      ++ [
        "-DCMAKE_CXX_STANDARD=23"
      ];

    # Use a more recent version of CMake
    nativeBuildInputs =
      (oldAttrs.nativeBuildInputs or [])
      ++ [
        final.cmake_3_30 # Use CMake 3.30 or newer
      ];

    # Ensure the newer CMake is used
    preConfigure = ''
      export PATH="${final.cmake_3_30}/bin:$PATH"
    '';
  });

  # Ensure we have CMake 3.30 available
  cmake_3_30 = prev.cmake.overrideAttrs (oldAttrs: {
    version = "3.30.0";
    src = prev.fetchurl {
      url = "https://github.com/Kitware/CMake/releases/download/v3.30.0/cmake-3.30.0.tar.gz";
      sha256 = "sha256-FX5b5gVcFUw09YB5X+WDLyYCRlBtMpVKlxMA7XiZ9Xk=";
    };
  });
}
