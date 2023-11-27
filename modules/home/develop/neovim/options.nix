{ config, pkgs, lib, inputs, ... }: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
    };

    options = {
      number = true;
      relativenumber = true;
      smartindent = true;
      shiftwidth = 2;
    };
  };
}
