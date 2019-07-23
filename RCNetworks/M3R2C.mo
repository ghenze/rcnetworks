within RCNetworks;
model M3R2C
  parameter Modelica.SIunits.ThermalResistance R1
    "Constant thermal resistance of material";
  parameter Modelica.SIunits.ThermalResistance R2
    "Constant thermal resistance of material";
  parameter Modelica.SIunits.ThermalResistance R3
    "Constant thermal resistance of material";
  parameter Modelica.SIunits.HeatCapacity C1
    "Heat capacity of element (= cp*m)";
  parameter Modelica.SIunits.HeatCapacity C2
    "Heat capacity of element (= cp*m)";

  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res1(R=R1)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap1(C=C1)
    annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res2(R=R2)
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outTem
    "Outdoor temperature"
    annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature indTem
    "Indoor temperature"
    annotation (Placement(transformation(extent={{90,50},{70,70}})));
  Modelica.Blocks.Interfaces.RealInput Tin "Indoor temperature"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput Tou "Outdoor temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor qSen "Heat flow sensor"
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow
    "Heat flow from port_a to port_b as output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap2(C=C2)
    annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res3(R=R3)
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));

equation
  connect(res1.port_b, cap1.port) annotation (Line(points={{-40,-40},{-30,-40},{
          -30,0},{-20,0}},
                    color={191,0,0}));
  connect(cap1.port, res2.port_a) annotation (Line(points={{-20,0},{-10,0},{-10,
          -40},{0,-40}},
                  color={191,0,0}));
  connect(indTem.T, Tin) annotation (Line(points={{92,60},{98,60},{98,80},{-120,
          80}}, color={0,0,127}));
  connect(outTem.port, res1.port_a) annotation (Line(points={{-72,0},{-64,0},{-64,
          -40},{-60,-40}}, color={191,0,0}));
  connect(outTem.T, Tou)
    annotation (Line(points={{-94,0},{-120,0}}, color={0,0,127}));
  connect(qSen.port_b, indTem.port)
    annotation (Line(points={{60,60},{70,60}}, color={191,0,0}));
  connect(qSen.Q_flow, Q_flow) annotation (Line(points={{50,50},{50,42},{94,42},
          {94,0},{110,0}}, color={0,0,127}));
  connect(res2.port_b, cap2.port) annotation (Line(points={{20,-40},{32,-40},{32,
          0},{40,0},{40,0}}, color={191,0,0}));
  connect(cap2.port, res3.port_a) annotation (Line(points={{40,0},{50,0},{50,-40},
          {60,-40}}, color={191,0,0}));
  connect(qSen.port_a, res3.port_b) annotation (Line(points={{40,60},{32,60},{32,
          36},{88,36},{88,-40},{80,-40}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-56,24},{66,-20}},
          lineColor={0,0,127},
          textString="3R2C")}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end M3R2C;
