within RCNetworks;
model HighThermalMassWall
  extends RCNetworks.BaseClasses.PartialWallIcon;

  parameter Modelica.SIunits.Temperature T_start=273.15 + 20
    "Initial temperature of capacities";

  RCElements.Resistance               A0(
    R=0.059)
    annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
  RCElements.Layer A2(
    
    C={187.22} * 1000,R={0.076,0.076}/2,
    T_start=T_start,
    use_externalQ=true)
    annotation (Placement(transformation(extent={{-54,-10},{-34,12}})));
  RCElements.Resistance B1(R=0.16)
    annotation (Placement(transformation(extent={{-22,-10},{-4,10}})));
  RCElements.Layer B24(
    C={5.33} * 1000,
    R={1.584,1.584}/2,
    T_start=T_start)
    annotation (Placement(transformation(extent={{6,-10},{26,12}})));
  RCElements.Layer C3(
    C={83.21} * 1000,
    R={0.125,0.125}/2,
    T_start=T_start)
    annotation (Placement(transformation(extent={{36,-10},{56,12}})));
  RCElements.Layer E1(
    
    C={25.82} * 1000,
    R={0.013,0.013},T_start=T_start,
    use_internalQ=true) annotation (Placement(transformation(extent={{64,-10},{84,12}})));
  RCElements.Resistance E0(R=0.121)
    annotation (Placement(transformation(extent={{80,40},{60,60}})));

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
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senT_ext
    "Exterior surface temperature sensor"
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Modelica.Blocks.Interfaces.RealOutput Ts_ext(
    final quantity="ThermodynamicTemperature",
    final displayUnit="degC")
   "Exterior surface temperature"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senT_int
    "Exterior surface temperature sensor"
    annotation (Placement(transformation(extent={{76,-70},{96,-50}})));
  Modelica.Blocks.Interfaces.RealOutput Ts_int(
    final quantity="ThermodynamicTemperature",
    final displayUnit="degC")
    "Interior surface temperature"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Sources.PrescribedTemperature temReaCon_ext "Temperature connector "
    annotation (Placement(transformation(extent={{-94,20},{-74,40}})));
  Sources.PrescribedTemperature temReaCon_int "Temperature connector "
    annotation (Placement(transformation(extent={{-92,70},{-72,90}})));
equation
  connect(A0.port_b, A2.port_a)
    annotation (Line(points={{-64,0},{-54,0}}, color={191,0,0}));
  connect(A2.port_b, B1.port_a)
    annotation (Line(points={{-34,0},{-22,0}}, color={191,0,0}));
  connect(B1.port_b, B24.port_a)
    annotation (Line(points={{-4,0},{6,0}},   color={191,0,0}));
  connect(B24.port_b, C3.port_a)
    annotation (Line(points={{26,0},{36,0}}, color={191,0,0}));
  connect(C3.port_b, E1.port_a)
    annotation (Line(points={{56,0},{64,0}}, color={191,0,0}));
  connect(q_ext, A2.q_ext) annotation (Line(points={{-120,-30},{-62,-30},{-62,-3},
          {-56,-3}}, color={0,0,127}));
  connect(q_int, E1.q_int) annotation (Line(points={{-120,-80},{56,-80},{56,-8},
          {62,-8}}, color={0,0,127}));
  connect(senT_ext.port, A2.port_a) annotation (Line(points={{-50,40},{-58,40},{
          -58,0},{-54,0}}, color={191,0,0}));
  connect(senT_ext.T, Ts_ext) annotation (Line(points={{-30,40},{30,40},{30,80},
          {110,80}}, color={0,0,127}));
  connect(E1.port_b, senT_int.port) annotation (Line(points={{84,0},{94,0},{94,
          -40},{74,-40},{74,-60},{76,-60}}, color={191,0,0}));
  connect(senT_int.T, Ts_int)
    annotation (Line(points={{96,-60},{110,-60}}, color={0,0,127}));
  connect(T_ext, temReaCon_ext.T)
    annotation (Line(points={{-120,30},{-96,30}}, color={0,0,127}));
  connect(temReaCon_ext.port, A0.port_a) annotation (Line(points={{-74,30},{-68,
          30},{-68,16},{-92,16},{-92,0},{-84,0}}, color={191,0,0}));
  connect(T_int, temReaCon_int.T)
    annotation (Line(points={{-120,80},{-94,80}}, color={0,0,127}));
  connect(E1.port_b, E0.port_a)
    annotation (Line(points={{84,0},{94,0},{94,50},{80,50}}, color={191,0,0}));
  connect(temReaCon_int.port, E0.port_b) annotation (Line(points={{-72,80},{0,80},
          {0,50},{60,50}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This is a RC model for a 7-layer high thermal mass wall. 
Each layer that has mass is modelled as (n+1)RnC.
The parameter <code>n</code> can be set by users. 
The defaulted <code>n</code> is set to 1, which means the defaulted layer is modeled as 2R1C.
</p>
</html>"));
end HighThermalMassWall;