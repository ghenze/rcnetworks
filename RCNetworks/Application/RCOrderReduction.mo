within RCNetworks.Application;
model RCOrderReduction

  parameter Integer n(min = 1) = 2 "Number of C-elements:";
  parameter Modelica.SIunits.ThermalResistance RTot
    "Total thermal resistance without convective air resistors on extorior and interior sides"
    annotation(Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.HeatCapacity CTot
    "Total thermal resistance without convective air resistors on extorior and interior sides"
    annotation(Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.ThermalResistance RA0 = 0.059
    "Convective air resistors on exterior side"
    annotation(Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.ThermalResistance RE0 = 0.121
    "Convective air resistors on interior side"
    annotation(Dialog(group="Thermal mass"));

  parameter Real r[n+1] = fill(1/(n+1),n+1);
  parameter Real c[n] = fill(1/n,n);

  // Initial temperatures
  parameter Modelica.SIunits.Temperature T_start=273.15 + 20
    "Initial temperature of capacities";


 // Inputs
  Modelica.Blocks.Interfaces.RealInput T_int(final quantity="ThermodynamicTemperature",
      final displayUnit="degC") "Indoor temperature"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput T_ext(final quantity="ThermodynamicTemperature",
      final displayUnit="degC") "Outdoor temperature"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealInput q_ext(final quantity="Power", final
      displayUnit="W") "Solar radiance"
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput q_int(final quantity="Power", final
      displayUnit="W") "Solar radiance"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));

 // Outputs
   Modelica.Blocks.Interfaces.RealOutput Ts_int(
    final quantity="ThermodynamicTemperature",
    final displayUnit="degC")
    "Interior surface temperature"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

  Modelica.Blocks.Interfaces.RealOutput Ts_ext(
    final quantity="ThermodynamicTemperature",
    final displayUnit="degC")
   "Exterior surface temperature"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
 // intermediate models
  Sources.PrescribedTemperature temReaCon_int "Temperature connector "
    annotation (Placement(transformation(extent={{-92,70},{-72,90}})));
  Sources.PrescribedTemperature temReaCon_ext "Temperature connector "
    annotation (Placement(transformation(extent={{-94,20},{-74,40}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senT_ext
    "Exterior surface temperature sensor"
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));

  RCElements.Layer rcNet(
    use_externalQ=true,
    use_internalQ=true,
    T_start=T_start,
    R=(RTot-RA0-RE0)*r,
    C=CTot*c,
    n=n)
    "RC network"
    annotation (Placement(transformation(extent={{-10,-10},{10,12}})));


  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senT_int
    "Exterior surface temperature sensor"
    annotation (Placement(transformation(extent={{76,-70},{96,-50}})));
  RCElements.Resistance  A0(
    R=RA0)
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
  RCElements.Resistance E0(R=RE0)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
equation
  connect(T_int, temReaCon_int.T)
    annotation (Line(points={{-120,80},{-94,80}}, color={0,0,127}));
  connect(T_ext, temReaCon_ext.T)
    annotation (Line(points={{-120,30},{-96,30}}, color={0,0,127}));
  connect(senT_ext.T, Ts_ext) annotation (Line(points={{-30,40},{30,40},{30,80},
          {110,80}}, color={0,0,127}));
  connect(senT_int.T,Ts_int)
    annotation (Line(points={{96,-60},{110,-60}}, color={0,0,127}));
  connect(q_ext, rcNet.q_ext) annotation (Line(points={{-120,-30},{-24,-30},{-24,
          -3},{-12,-3}}, color={0,0,127}));
  connect(q_int, rcNet.q_int) annotation (Line(points={{-120,-80},{-20,-80},{-20,
          -8},{-12,-8}}, color={0,0,127}));
  connect(A0.port_b, rcNet.port_a)
    annotation (Line(points={{-42,0},{-10,0}}, color={191,0,0}));
  connect(temReaCon_ext.port, A0.port_a) annotation (Line(points={{-74,30},{-70,
          30},{-70,0},{-62,0}}, color={191,0,0}));
  connect(rcNet.port_b, E0.port_a)
    annotation (Line(points={{10,0},{30,0}}, color={191,0,0}));
  connect(E0.port_b, temReaCon_int.port) annotation (Line(points={{50,0},{60,0},
          {60,20},{20,20},{20,80},{-72,80}}, color={191,0,0}));
  connect(senT_ext.port, rcNet.port_a) annotation (Line(points={{-50,40},{-56,40},
          {-56,20},{-20,20},{-20,0},{-10,0}}, color={191,0,0}));
  connect(rcNet.port_b, senT_int.port) annotation (Line(points={{10,0},{20,0},{20,
          -60},{76,-60}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RCOrderReduction;
