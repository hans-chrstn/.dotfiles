_final: prev: {
  pythonPackagesExtensions =
    prev.pythonPackagesExtensions
    ++ [
      (_python-final: python-prev: {
        python-unrar = python-prev.python-unrar.overrideAttrs (_oldAttrs: {
          pythonMetadataCheckPhase = "true";
        });
      })
    ];
}
