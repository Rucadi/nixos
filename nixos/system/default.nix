{ ... }: {

  imports = [
    #./hdd/hdd.nix
    ./ssd/ssd.nix
    ./mem/64GB.nix
    ./mem/zram-64GB-SYSTEM.nix
    ./diskdetection
    #./kernel/xanmod/xanmod.nix
  ];
}
