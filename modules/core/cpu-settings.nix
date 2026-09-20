{ pkgs, ... }:

{
  services.power-profiles-daemon.enable = true;
  services.thermald = {
    enable = true;
    configFile = "/etc/thermald/thermal-conf.xml";
  };

  environment.etc."thermald/thermal-conf.xml".text = ''
    <?xml version="1.0"?>
    <ThermalConfiguration>
      <Platform>
        <Name>N100 15W PL1 / 80C Cap</Name>
        <ProductName>*</ProductName>
        <Preference>QUIET</Preference>
        <PPCC>
          <PowerLimitIndex>0</PowerLimitIndex>
          <PowerLimitMaximum>15000</PowerLimitMaximum>
          <PowerLimitMinimum>5000</PowerLimitMinimum>
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

              <!-- Throttle: 15W - 3W = 12W when temp hits 70C -->
              <TripPoint>
                <SensorType>x86_pkg_temp</SensorType>
                <Temperature>70000</Temperature>
                <type>passive</type>
                <ControlType>SEQUENTIAL</ControlType>
                <CoolingDevice>
                  <index>1</index>
                  <type>rapl_controller</type>
                  <SamplingPeriod>3</SamplingPeriod>
                  <TargetState>12000000</TargetState>
                </CoolingDevice>
              </TripPoint>

              <!-- Safety cap: keep 12W at 80C -->
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
  '';
}
