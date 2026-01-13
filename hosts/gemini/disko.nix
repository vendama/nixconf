{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/ata-MTFDDAK256TBN_163513EA2393"; # TODO
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512MiB";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            boot = {
              size = "2G";
              type = "filesystem";
              format = "ext4";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                extraOpenArgs = [ ];
                settings = {
                  # By not using keyFile you enter password on disko format
                  #keyFile = "/tmp/secret.key";
                  allowDiscards = true;
                };
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                  mountOptions = [
                    "defaults"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}
