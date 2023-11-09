{ config, inputs, pkgs, ... }:

{
    # Video support
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;

   services.xserver.screenSection = ''
     Option       "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
     Option       "AllowIndirectGLXProtocol" "off"
     Option       "TripleBuffer" "on"
   '';

    services.xserver = {
        layout = "es";
        xkbOptions = "grp:alt_shift_toggle";
        videoDrivers = [ "nvidia" ];
    };

  environment.systemPackages = with pkgs; [

    clinfo
    virtualglLib
    vulkan-loader
    vulkan-tools

  ];

}
