{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_26
    pnpm
    prisma
    prisma-engines
  ];
}
