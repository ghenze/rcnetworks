within RCNetworks.RCElements;
model Capacitance "Capacitor"
  extends RCNetworks.BaseClasses.PartialCapacitanceIcon;
  parameter Integer n(min = 1) = 1 "Number of C-elements:";
  parameter Modelica.SIunits.HeatCapacity C[n] "Heat capacity of element (= cp*m)";
  parameter Modelica.SIunits.Temperature T_start=273.15 + 20
    "Initial temperature of capacities";
  parameter Boolean use_externalQ = false
    "Use external heat flow if True";
  parameter Boolean use_internalQ = false
    "Use internal heat flow if True";

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap[n](
    final C=C,
    each T(start = T_start)) "Capacitor"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    "Thermal heat port"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a "Heat port"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  Modelica.Blocks.Interfaces.RealInput q_ext(
    final quantity="Power",
    final displayUnit="W") if use_externalQ "Solar radiance"
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput q_int(
    final quantity="Power",
    final displayUnit="W") if use_internalQ "Solar radiance"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Sources.PrescribedHeatFlow heaFlo_ext if use_externalQ
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Sources.PrescribedHeatFlow heaFlo_int if use_internalQ
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
equation
  connect(port_a, cap[1].port) annotation (Line(points={{-100,0},{-20,0},{-20,-20},
          {0,-20},{0,0}}, color={191,0,0}));
  connect(cap[n].port, port_b) annotation (Line(points={{0,0},{0,-20},{20,-20},{20,
          0},{100,0}}, color={191,0,0}));

  for i in 1:n-1 loop
    connect(cap[i].port,cap[i+1].port);

  end for;

  if use_externalQ then

  connect(q_ext, heaFlo_ext.Q_flow)
      annotation (Line(points={{-120,-30},{-80,-30}}, color={0,0,127}));
  connect(heaFlo_ext.port, cap[1].port)
    annotation (Line(points={{-60,-30},{0,-30},{0,0}}, color={191,0,0}));

  end if;
  if use_internalQ then
  connect(heaFlo_int.port, cap[n].port)
    annotation (Line(points={{-60,-80},{0,-80},{0,0}}, color={191,0,0}));
  connect(q_int,heaFlo_int. Q_flow)
      annotation (Line(points={{-120,-80},{-80,-80}}, color={0,0,127}));
  end if;
  annotation (
  Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This is a R model that has no mass that can be used to represent the air gap between layers.
</p>
</html>"));
end Capacitance;
