{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    power-profiles-daemon
  ];
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;

  systemd.services.thermald = {
    unitConfig.ConditionACPower = false;
    serviceConfig.ExecStopPost = pkgs.writeShellScript "reset-rapl" ''
      echo 18000000 > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_power_limit_uw 2>/dev/null || true
    '';
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="ADP1", ATTR{online}=="0", RUN+="${pkgs.systemd}/bin/systemctl start thermald.service"
    SUBSYSTEM=="power_supply", KERNEL=="ADP1", ATTR{online}=="1", RUN+="${pkgs.systemd}/bin/systemctl stop thermald.service"
  '';

  environment.etc."thermald/thermal-conf.xml".text = ''
    <?xml version="1.0"?>
    <ThermalConfiguration>
      <Platform>
        <Name>Gentle Passive Throttle</Name>
        <ProductName>*</ProductName>
        <Preference>QUIET</Preference>
        <ThermalSensors>
          <ThermalSensor>
            <Type>x86_pkg_temp</Type>
            <Path>/sys/class/thermal/thermal_zone5/temp</Path>
          </ThermalSensor>
        </ThermalSensors>
        <ThermalZones>
          <ThermalZone>
            <Type>CPU</Type>
            <TripPoints>

              <!-- Stage 1 -->
              <TripPoint>
                <SensorType>x86_pkg_temp</SensorType>
                <Temperature>65000</Temperature>
                <type>passive</type>
                <ControlType>SEQUENTIAL</ControlType>
                <CoolingDevice>
                  <index>1</index>
                  <type>rapl_controller</type>
                  <influence>40</influence>
                  <SamplingPeriod>4</SamplingPeriod>
                </CoolingDevice>
              </TripPoint>

              <!-- Stage 2 -->
              <TripPoint>
                <SensorType>x86_pkg_temp</SensorType>
                <Temperature>70000</Temperature>
                <type>passive</type>
                <ControlType>SEQUENTIAL</ControlType>
                <CoolingDevice>
                  <index>1</index>
                  <type>rapl_controller</type>
                  <influence>75</influence>
                  <SamplingPeriod>3</SamplingPeriod>
                </CoolingDevice>
              </TripPoint>

            </TripPoints>
          </ThermalZone>
        </ThermalZones>
      </Platform>
    </ThermalConfiguration>
  '';
}
