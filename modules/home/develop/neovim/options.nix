{ config, pkgs, lib, inputs, ... }: {
  programs.nixvim.globals = {
    mapleader = " ";
  };

  programs.nixvim.options = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
  };
}
