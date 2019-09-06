within RCNetworks;
model LowThermalMassWall "Low thermal mass wall"
  extends RCNetworks.BaseClasses.PartialWallIcon;

  parameter Modelica.SIunits.Temperature T_start=273.15 + 20
    "Initial temperature of capacities";


  RCElements.Resistance               A0(
    R=0.059)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  RCElements.Capacitance                                 A3(
    
    C={4.92} * 1000,T_start=T_start,
    use_externalQ=true)
    annotation (Placement(transformation(extent={{-62,-10},{-44,10}})));
  RCElements.Resistance B1_1(R=0.16)
    annotation (Placement(transformation(extent={{46,-10},{64,10}})));
  RCElements.Layer B24(
    C={5.33} * 1000,
    R={1.584,1.584}/2,
    T_start=T_start)
    annotation (Placement(transformation(extent={{-10,-10},{8,12}})));
  RCElements.Layer C2(
    
    C={52.06} * 1000,
    R={0.266,0.266}/2,T_start=T_start)
    annotation (Placement(transformation(extent={{18,-10},{38,12}})));
  RCElements.Layer E2(
    
    C={9.42} * 1000,
    R={0.009,0.009}/2,T_start=T_start,
    use_internalQ=true)
               annotation (Placement(transformation(extent={{70,-10},{90,12}})));
  RCElements.Resistance               E0(R=0.121)
    annotation (Placement(transformation(extent={{80,40},{60,60}})));

  Modelica.Blocks.Interfaces.RealInput T_int(final quantity="ThermodynamicTemperature",
      final displayUnit="degC") "Indoor temperature"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput T_ext(final quantity="ThermodynamicTemperature",
      final displayUnit="degC") "Outdoor temperature"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));

  Modelica.Blocks.Interfaces.RealInput q_ext(final quantity="Power", final
      displayUnit="W") "Solar radiance"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  RCElements.Resistance B1_2(R=0.16)
    annotation (Placement(transformation(extent={{-36,-10},{-18,10}})));
  Sources.PrescribedTemperature temReaCon_ext "Temperature connector "
    annotation (Placement(transformation(extent={{-92,30},{-72,50}})));
  Sources.PrescribedTemperature temReaCon_int "Temperature connector "
    annotation (Placement(transformation(extent={{-92,70},{-72,90}})));
  Modelica.Blocks.Interfaces.RealInput q_int(final quantity="Power", final
      displayUnit="W") "Solar radiance"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senT_int
    "Exterior surface temperature sensor"
    annotation (Placement(transformation(extent={{76,-70},{96,-50}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senT_ext
    "Exterior surface temperature sensor"
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Modelica.Blocks.Interfaces.RealOutput Ts_ext(
    final quantity="ThermodynamicTemperature",
    final displayUnit="degC")
   "Exterior surface temperature"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput Ts_int(
    final quantity="ThermodynamicTemperature",
    final displayUnit="degC")
    "Interior surface temperature"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
equation
  connect(B24.port_b,C2. port_a)
    annotation (Line(points={{8,0},{18,0}},  color={191,0,0}));
  connect(B1_2.port_b, B24.port_a)
    annotation (Line(points={{-18,0},{-10,0}}, color={191,0,0}));
  connect(C2.port_b, B1_1.port_a)
    annotation (Line(points={{38,0},{46,0}}, color={191,0,0}));
  connect(B1_1.port_b, E2.port_a)
    annotation (Line(points={{64,0},{70,0}}, color={191,0,0}));
  connect(T_int, temReaCon_int.T)
    annotation (Line(points={{-120,80},{-94,80}}, color={0,0,127}));
  connect(T_ext, temReaCon_ext.T)
    annotation (Line(points={{-120,40},{-94,40}}, color={0,0,127}));
  connect(temReaCon_ext.port, A0.port_a) annotation (Line(points={{-72,40},{-66,
          40},{-66,20},{-94,20},{-94,0},{-88,0}}, color={191,0,0}));
  connect(A0.port_b, A3.port_a)
    annotation (Line(points={{-68,0},{-62,0}}, color={191,0,0}));
  connect(A3.port_b, B1_2.port_a)
    annotation (Line(points={{-44,0},{-36,0}}, color={191,0,0}));
  connect(q_ext, A3.q_ext) annotation (Line(points={{-120,-40},{-68,-40},{-68,-3},
          {-63.8,-3}}, color={0,0,127}));
  connect(q_int, E2.q_int) annotation (Line(points={{-120,-80},{64,-80},{64,-8},
          {68,-8}}, color={0,0,127}));
  connect(senT_ext.port, A3.port_a) annotation (Line(points={{-50,40},{-64,40},{
          -64,0},{-62,0}}, color={191,0,0}));
  connect(temReaCon_int.port, E0.port_b) annotation (Line(points={{-72,80},{20,80},
          {20,50},{60,50}}, color={191,0,0}));
  connect(E0.port_a, E2.port_b)
    annotation (Line(points={{80,50},{94,50},{94,0},{90,0}}, color={191,0,0}));
  connect(E2.port_b, senT_int.port) annotation (Line(points={{90,0},{94,0},{94,-40},
          {68,-40},{68,-60},{76,-60}}, color={191,0,0}));
  connect(senT_ext.T,Ts_ext)  annotation (Line(points={{-30,40},{30,40},{30,80},
          {110,80}}, color={0,0,127}));
  connect(senT_int.T, Ts_int)
    annotation (Line(points={{96,-60},{110,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This is a RC model for a 7-layer low thermal mass wall. 
Each layer that has mass is modelled as (n+1)RnC.
The parameter <code>n</code> can be set by users. 
The defaulted <code>n</code> is set to 1, which means the defaulted layer is modeled as 2R1C.
</p>
</html>"));
end LowThermalMassWall;