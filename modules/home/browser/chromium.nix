{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {id = "bkkmolkhemgaeaeggcmfbghljjjoofoh";} # Catppuccin Mocha
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # uBlock Origin
      {id = "nngceckbapebfimnlniiiahkandclblb";} # Bitwarden Password Manager
      {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # SponsorBlock
      {id = "mefgmmbdailogpfhfblcnnjfmnpnmdfa";} # FeedBro
      {id = "edibdbjcniadpccecjdfdjjppcpchdlm";} # I Still Don't Care About Cookies
      {id = "aefkmifgmaafnojlojpnekbpbmjiiogg";} # Popup Blocker Strict
      {id = "hjdoplcnndgiblooccencgcggcoihigg";} # Terms of Service; Didn't Read
      {id = "bkdgflcldnnnapblkhphbgpggdiikppg";} # DuckDuckGo
    ];
  };
}
