{ gobject-introspection
, gusb
, lib
, libfprint
, python3
, wrapGAppsHook4
, ...
}:
python3.pkgs.buildPythonApplication {
  pname = "fprint-clear";
  version = "1.0.1";
  format = "other";
  src = lib.sources.sourceFilesBySuffices ./. [".py"];
  pythonPath = [ python3.pkgs.pygobject3 ];

  nativeBuildInputs = [
    gobject-introspection
    wrapGAppsHook4
  ];
  
  buildInputs = [
    libfprint
    gusb
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp fprint-clear.py $out/bin/fprint-clear
  '';

  # Arguments to be passed to `makeWrapper`, only used by buildPython*
  dontWrapGApps = true;
  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  meta = {
    description = "Clear your fingerprint reader";
    homepage = "https://github.com/nixvital/fprint-clear";
    license = lib.licenses.mit;
    mainProgram = "fprint-clear";
    platforms = lib.platforms.linux;
  };
}

