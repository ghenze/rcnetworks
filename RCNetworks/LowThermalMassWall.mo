within RCNetworks;
model LowThermalMassWall "Low thermal mass wall"
  extends RCNetworks.BaseClasses.PartialWallIcon;

  RCElements.AirResistanceTemperature A0(
    R=0.059)
    annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor A3(
    T(start=T_start), C=4.92)
    annotation (Placement(transformation(extent={{-62,-10},{-42,12}})));
  RCElements.AirResistance B1_1(R=0.16)
    annotation (Placement(transformation(extent={{46,-10},{64,10}})));
  RCElements.Layer B24(
    R={1.584,1.584}/2,
    C={5.33},
    T_start=T_start)
    annotation (Placement(transformation(extent={{-10,-10},{10,12}})));
  RCElements.Layer C2(
    T_start=T_start,
    R={0.266,0.266}/2,
    C={52.06})
    annotation (Placement(transformation(extent={{18,-10},{38,12}})));
  RCElements.Layer E2(
    T_start=T_start,
    R={0.009,0.009}/2,
    C={9.42})  annotation (Placement(transformation(extent={{70,-10},{90,12}})));
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

  Modelica.Blocks.Interfaces.RealInput QRad(final quantity="Power", final
      displayUnit="W") "Solar radiance"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  RCElements.AirResistance B1_2(R=0.16)
    annotation (Placement(transformation(extent={{-36,-10},{-18,10}})));
  Sources.PrescribedHeatFlow heaFlo
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
equation
  connect(TExt, A0.T)
    annotation (Line(points={{-120,0},{-94,0}}, color={0,0,127}));
  connect(TInt, E0.T) annotation (Line(points={{-120,80},{40,80},{40,50},{58,50}},
        color={0,0,127}));
  connect(E0.port_b,E2. port_b)
    annotation (Line(points={{80,50},{94,50},{94,0},{90,0}}, color={191,0,0}));
  connect(B24.port_b,C2. port_a)
    annotation (Line(points={{10,0},{18,0}}, color={191,0,0}));
  connect(B1_2.port_b, B24.port_a)
    annotation (Line(points={{-18,0},{-10,0}}, color={191,0,0}));
  connect(C2.port_b, B1_1.port_a)
    annotation (Line(points={{38,0},{46,0}}, color={191,0,0}));
  connect(B1_1.port_b, E2.port_a)
    annotation (Line(points={{64,0},{70,0}}, color={191,0,0}));
  connect(A0.port_b, A3.port) annotation (Line(points={{-72,0},{-62,0},{-62,-10},
          {-52,-10}}, color={191,0,0}));
  connect(A3.port, B1_2.port_a) annotation (Line(points={{-52,-10},{-40,-10},{-40,
          0},{-36,0}}, color={191,0,0}));
  connect(QRad, heaFlo.Q_flow)
    annotation (Line(points={{-120,-80},{-80,-80}}, color={0,0,127}));
  connect(heaFlo.port, A3.port)
    annotation (Line(points={{-60,-80},{-52,-80},{-52,-10}}, color={191,0,0}));
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
