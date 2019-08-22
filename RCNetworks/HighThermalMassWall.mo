within RCNetworks;
model HighThermalMassWall
  extends RCNetworks.BaseClasses.PartialWallIcon;

  RCElements.AirResistanceTemperature A0(R=0.059)
    annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  RCElements.Layer A2(
    R={0.076,0.076}/2,
    C={187.22},
    T_start=T_start)
    annotation (Placement(transformation(extent={{-62,-10},{-42,12}})));
  RCElements.AirResistance B1(R=0.16)
    annotation (Placement(transformation(extent={{-30,-10},{-12,10}})));
  RCElements.Layer B24(
    R={1.584,1.584}/2,
    C={5.33},
    T_start=T_start)
    annotation (Placement(transformation(extent={{-2,-10},{18,12}})));
  RCElements.Layer C3(
    C={83.21},
    T_start=T_start,
    R={0.125,0.125}/2)
    annotation (Placement(transformation(extent={{28,-10},{48,12}})));
  RCElements.Layer E1(
    T_start=T_start,
    R={0.013,0.013},
    C={25.82}) annotation (Placement(transformation(extent={{56,-10},{76,12}})));
  RCElements.AirResistanceTemperature E0(R=0.121)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));

  Modelica.Blocks.Interfaces.RealInput TInt(
    final quantity="ThermodynamicTemperature",
    final displayUnit="degC")
    "Indoor temperature"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput TExt(
    final quantity="ThermodynamicTemperature",
    final displayUnit="degC") "Outdoor temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  parameter Modelica.SIunits.Temperature T_start=273.15 + 20
    "Initial temperature of capacities";
equation
  connect(TExt, A0.T)
    annotation (Line(points={{-120,0},{-94,0}}, color={0,0,127}));
  connect(TInt, E0.T) annotation (Line(points={{-120,80},{40,80},{40,50},{58,50}},
        color={0,0,127}));
  connect(E0.port_b, E1.port_b)
    annotation (Line(points={{80,50},{88,50},{88,0},{76,0}}, color={191,0,0}));
  connect(A0.port_b, A2.port_a)
    annotation (Line(points={{-72,0},{-62,0}}, color={191,0,0}));
  connect(A2.port_b, B1.port_a)
    annotation (Line(points={{-42,0},{-30,0}}, color={191,0,0}));
  connect(B1.port_b, B24.port_a)
    annotation (Line(points={{-12,0},{-2,0}}, color={191,0,0}));
  connect(B24.port_b, C3.port_a)
    annotation (Line(points={{18,0},{28,0}}, color={191,0,0}));
  connect(C3.port_b, E1.port_a)
    annotation (Line(points={{48,0},{56,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HighThermalMassWall;