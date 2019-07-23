within RCNetworks;
model M2R1C
  parameter Modelica.SIunits.ThermalResistance R1
    "Constant thermal resistance of material";
  parameter Modelica.SIunits.ThermalResistance R2
    "Constant thermal resistance of material";
  parameter Modelica.SIunits.HeatCapacity C1
    "Heat capacity of element (= cp*m)";

  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res1(R=R1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap1(C=C1)
    annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res2(R=R2)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));


  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outTem
    "Outdoor temperature"
    annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature indTem
    "Indoor temperature"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Interfaces.RealInput Tin "Indoor temperature"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput Tou "Outdoor temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor qSen "Heat flow sensor"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow
    "Heat flow from port_a to port_b as output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(res1.port_b, cap1.port) annotation (Line(points={{-40,0},{-20,0}},
                    color={191,0,0}));
  connect(cap1.port, res2.port_a) annotation (Line(points={{-20,0},{0,0}},
                  color={191,0,0}));
  connect(indTem.T, Tin) annotation (Line(points={{82,0},{90,0},{90,80},{-120,
          80}}, color={0,0,127}));
  connect(outTem.port, res1.port_a)
    annotation (Line(points={{-66,0},{-60,0}}, color={191,0,0}));
  connect(outTem.T, Tou)
    annotation (Line(points={{-88,0},{-120,0}}, color={0,0,127}));
  connect(res2.port_b, qSen.port_a)
    annotation (Line(points={{20,0},{30,0}}, color={191,0,0}));
  connect(qSen.port_b, indTem.port)
    annotation (Line(points={{50,0},{60,0}}, color={191,0,0}));
  connect(qSen.Q_flow, Q_flow) annotation (Line(points={{40,-10},{40,-30},{96,
          -30},{96,0},{110,0}}, color={0,0,127}));
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
end M2R1C;
