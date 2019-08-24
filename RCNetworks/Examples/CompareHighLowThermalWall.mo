within RCNetworks.Examples;
model CompareHighLowThermalWall
  "Compre the performance of high and low thermal mass wall"
  extends Modelica.Icons.Example;

  RCNetworks.HighThermalMassWall walHig "High thermal mass wall"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Sources.Step T_int(
    height=5,
    offset=273.15 + 21,
    startTime=600)
    annotation (Placement(transformation(extent={{-80,38},{-60,58}})));
  Modelica.Blocks.Sources.Constant T_ext(k=273.15 + 30)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant q_ext(k=0)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  RCNetworks.LowThermalMassWall walLow
    annotation (Placement(transformation(extent={{0,-52},{20,-32}})));
  Modelica.Blocks.Sources.Constant q_int(k=100)
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
equation
  connect(T_int.y, walHig.T_int)
    annotation (Line(points={{-59,48},{-2,48}}, color={0,0,127}));
  connect(T_ext.y, walHig.T_ext) annotation (Line(points={{-59,0},{-34,0},{-34,
          43},{-2,43}}, color={0,0,127}));
  connect(q_ext.y, walHig.q_ext) annotation (Line(points={{-59,-40},{-20,-40},{
          -20,37},{-2,37}}, color={0,0,127}));
  connect(T_int.y, walLow.T_int) annotation (Line(points={{-59,48},{-14,48},{-14,
          -34},{-2,-34}}, color={0,0,127}));
  connect(T_ext.y, walLow.T_ext) annotation (Line(points={{-59,0},{-34,0},{-34,
          -38},{-2,-38}}, color={0,0,127}));
  connect(q_ext.y, walLow.q_ext) annotation (Line(points={{-59,-40},{-20,-40},{
          -20,-46},{-2,-46}}, color={0,0,127}));
  connect(q_int.y, walLow.q_int) annotation (Line(points={{-59,-80},{-12,-80},{
          -12,-50},{-2,-50}}, color={0,0,127}));
  connect(q_int.y, walHig.q_int) annotation (Line(points={{-59,-80},{-12,-80},{
          -12,32},{-2,32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1200),
    __Dymola_Commands(file="modelica://RCNetworks/Resources/Scripts/CompareHighLowThermalWall.mos"
        "Simulate and Plot"),
    Documentation(info="<html>
<p>
This example compares the model <a href=\"modelica://RCNetworks.HighThermalMassWall\">RCNetworks.HighThermalMassWall</a> and <a href=\"modelica://RCNetworks.LowThermalMassWall\">RCNetworks.LowThermalMassWall</a>.
</p>
</html>"));
end CompareHighLowThermalWall;
