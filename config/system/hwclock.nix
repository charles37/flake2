{ config, lib, ... }:

lib.mkIf config.mySystem.localHWClock {
  time.hardwareClockInLocalTime = true;
}
