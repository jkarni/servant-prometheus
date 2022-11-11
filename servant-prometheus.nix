{ mkDerivation, aeson, base, bytestring, hspec, http-client
, http-types, lib, process, prometheus-client, servant
, servant-auth, servant-client, servant-server, text, time
, transformers, unordered-containers, wai, warp
}:
mkDerivation {
  pname = "servant-prometheus";
  version = "0.2.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base bytestring http-types prometheus-client servant servant-auth
    servant-server text time unordered-containers wai
  ];
  executableHaskellDepends = [
    aeson base process prometheus-client servant-server text wai warp
  ];
  testHaskellDepends = [
    aeson base hspec http-client prometheus-client servant
    servant-client servant-server text transformers
    unordered-containers wai warp
  ];
  description = "Helpers for using prometheus with servant";
  license = lib.licenses.bsd3;
}
