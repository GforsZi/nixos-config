{ config, pkgs, ... }:

{
  services.power-profiles-daemon.enable = true;
  services.thermald = {
    enable = true;
    configFile = "/etc/thermald/thermal-conf.xml";
  };

  systemd.services.thermald = {
    serviceConfig.ExecStartPre = pkgs.writeShellScript "set-rapl-10w" ''
      echo 18000000 > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_power_limit_uw 2>/dev/null || true
      '';
    serviceConfig.ExecStopPost = pkgs.writeShellScript "reset-rapl-10w" ''
      echo 18000000 > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_power_limit_uw 2>/dev/null || true
      '';
  };

environment.etc."thermald/thermal-conf.xml".text = ''
  <?xml version="1.0"?>
  <ThermalConfiguration>
    <Platform>
      <Name>N100 10W PL1 / 80C Cap</Name>
      <ProductName>*</ProductName>
      <Preference>QUIET</Preference>
      <PPCC>
        <PowerLimitIndex>0</PowerLimitIndex>
        <PowerLimitMaximum>10000</PowerLimitMaximum>
        <PowerLimitMinimum>2000</PowerLimitMinimum>
        <TimeWindowMinimum>20</TimeWindowMinimum>
        <TimeWindowMaximum>30</TimeWindowMaximum>
        <StepSize>1000</StepSize>
      </PPCC>
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

            <!-- Stage 1: 15W, throttle starts at 70C -->
            <TripPoint>
              <SensorType>x86_pkg_temp</SensorType>
              <Temperature>70000</Temperature>
              <type>passive</type>
              <ControlType>SEQUENTIAL</ControlType>
              <CoolingDevice>
                <index>1</index>
                <type>rapl_controller</type>
                <SamplingPeriod>3</SamplingPeriod>
                <TargetState>15000000</TargetState>
              </CoolingDevice>
            </TripPoint>

            <!-- Stage 2: 10W, safety cap to avoid exceeding 80C -->
            <TripPoint>
              <SensorType>x86_pkg_temp</SensorType>
              <Temperature>80000</Temperature>
              <type>passive</type>
              <ControlType>SEQUENTIAL</ControlType>
              <CoolingDevice>
                <index>1</index>
                <type>rapl_controller</type>
                <SamplingPeriod>3</SamplingPeriod>
                <TargetState>10000000</TargetState>
              </CoolingDevice>
            </TripPoint>

          </TripPoints>
        </ThermalZone>
      </ThermalZones>
    </Platform>
  </ThermalConfiguration>
'';}
