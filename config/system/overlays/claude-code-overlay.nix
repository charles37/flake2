{
  lib,
  buildNpmPackage,
  fetchzip,
  nodejs_20,
}:
buildNpmPackage rec {
  pname = "claude-code";
  version = "1.0.53";

  nodejs = nodejs_20; # required for sandboxed Nix builds on Darwin

  src = fetchzip {
    url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
    hash = "";
  };

  npmDepsHash = "sha256-1/WzTOG6JY59nfb0Gp40E9z1G9VwUgqKLgM6zoyllxo=";

  postPatch = ''
    cp ${./claude-code-package-lock.json} package-lock.json
  '';

  dontNpmBuild = true;

  AUTHORIZED = "1";

  # `claude-code` tries to auto-update by default, this disables that functionality.
  # https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview#environment-variables
  postInstall = ''
    wrapProgram $out/bin/claude \
      --set DISABLE_AUTOUPDATER 1
  '';

  meta = {
    description = "An agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster";
    homepage = "https://github.com/anthropics/claude-code";
    downloadPage = "https://www.npmjs.com/package/@anthropic-ai/claude-code";
    license = lib.licenses.unfree;
    maintainers = [lib.maintainers.malo];
    mainProgram = "claude";
  };
}
