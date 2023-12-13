{ config, pkgs, lib, inputs, ... }: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
    };

    options = {
      number = true;
      relativenumber = true;
      smartindent = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
    };
  };
}
