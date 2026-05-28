{ config, ... }:
{
  # ---- Graphics Configuration ----
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Nvidia proprietary driver
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Whether to enable dynamic Boost balances power between the CPU and the GPU for improved
    # performance on supported laptops using the nvidia-powerd daemon. For more information,
    # see the NVIDIA docs, on Chapter 23. Dynamic Boost on Linux.
    dynamicBoost.enable = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable; # Same as production
    # package = config.boot.kernelPackages.nvidiaPackages.production; # Latest production driver
    # package = config.boot.kernelPackages.nvidiaPackages.beta; # Latest beta driver
    # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
    # package = config.boot.kernelPackages.nvidiaPackages.legacy_535; # Older versions
    # package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    # package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
    # package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
  };

  # Load Nvidia and AMD driver for Xorg and Wayland
  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];

  # For offloading, `modesetting` is needed additionally,
  # otherwise the X-server will be running permanently on nvidia,
  # thus keeping the GPU always on (see `nvidia-smi`).
  hardware.nvidia.prime = {
    sync.enable = true;
    # offload = {
    #   enable = true;
    #   enableOffloadCmd = true;
    # };

    amdgpuBusId = "PCI:6@0:0:0";
    nvidiaBusId = "PCI:1@0:0:0";
  };

  boot.kernelParams = [
    "acpi_backlight=native" # Backlight to AMD
    "acpi_osi=Linux"
    # "nvidia-drm.modeset=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
  ];

  # systemd.services.systemd-suspend.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";

  # boot.extraModprobeConfig = ''
  #   options nvidia NVreg_UsePageAttributeTable=1
  # '';
}
