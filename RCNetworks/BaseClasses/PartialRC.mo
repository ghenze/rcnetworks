within RCNetworks.BaseClasses;
model PartialRC
  parameter Modelica.SIunits.ThermalResistance R1
    "Constant thermal resistance of material";
  parameter Modelica.SIunits.ThermalResistance R2
    "Constant thermal resistance of material";
  parameter Modelica.SIunits.HeatCapacity C1
    "Heat capacity of element (= cp*m)";

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outTem
    "Outdoor temperature"
    annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));
  Modelica.Blocks.Interfaces.RealInput Tin "Indoor temperature"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput Tou "Outdoor temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature indTem
    "Indoor temperature"
    annotation (Placement(transformation(extent={{90,50},{70,70}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor qSen "Heat flow sensor"
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow
    "Heat flow from port_a to port_b as output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(outTem.T, Tou)
    annotation (Line(points={{-88,0},{-120,0}}, color={0,0,127}));
  connect(indTem.T, Tin) annotation (Line(points={{92,60},{98,60},{98,80},{-120,
          80}}, color={0,0,127}));
  connect(qSen.port_b,indTem. port)
    annotation (Line(points={{60,60},{70,60}}, color={191,0,0}));
  connect(qSen.Q_flow, Q_flow) annotation (Line(points={{50,50},{50,42},{94,42},
          {94,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-56,24},{66,-20}},
          lineColor={0,0,127},
          textString="2R1C")}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialRC;
