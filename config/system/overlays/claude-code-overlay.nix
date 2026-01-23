{
  lib,
  buildNpmPackage,
  fetchzip,
  nodejs_20,
  makeWrapper,
}:
buildNpmPackage rec {
  pname = "claude-code";
  version = "2.1.19";

  nodejs = nodejs_20; # required for sandboxed Nix builds on Darwin

  src = fetchzip {
    url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
    hash = "sha256-K2fJf1eRAyqmtAvKBzpAtMohQ4B1icwC9yf5zEf52C8=";
  };

  npmDepsHash = "sha256-/kW1hyd9Ptmgd+Vxcdgwa3MmmWwoAnrSTbhRNUp13AE=";
  forceEmptyCache = true;

  postPatch = ''
    cp ${./claude-code-package-lock.json} package-lock.json
  '';

  dontNpmBuild = true;

  AUTHORIZED = "1";

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin $out/lib/claude-code
    cp -r * $out/lib/claude-code/
    
    makeWrapper ${nodejs_20}/bin/node $out/bin/claude \
      --add-flags "$out/lib/claude-code/cli.js"
    
    runHook postInstall
  '';

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
