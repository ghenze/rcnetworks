within RCNetworks.Examples;
model LowThermalMassWall
  extends Modelica.Icons.Example;

  RCNetworks.LowThermalMassWall  wal
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Step T_int(
    height=5,
    offset=273.15 + 21,
    startTime=600)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Constant T_ext(k=273.15 + 30)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Sources.Constant q_ext(k=0)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Sources.Constant q_int(k=100)
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
equation
  connect(T_int.y, wal.T_int) annotation (Line(points={{-59,50},{-20,50},{-20,8},
          {-12,8}}, color={0,0,127}));
  connect(T_ext.y, wal.T_ext) annotation (Line(points={{-59,10},{-30,10},{-30,4},
          {-12,4}}, color={0,0,127}));
  connect(q_ext.y, wal.q_ext) annotation (Line(points={{-59,-30},{-30,-30},{-30,
          -4},{-12,-4}}, color={0,0,127}));
  connect(q_int.y, wal.q_int) annotation (Line(points={{-59,-80},{-20,-80},{-20,
          -8},{-12,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1200),
    __Dymola_Commands(file="modelica://RCNetworks/Resources/Scripts/LowThermalMassWall.mos"
        "Simulate and Plot"),
    Documentation(info="<html>
<p>
This example test the model <a href=\"modelica://RCNetworks.LowThermalMassWall\">RCNetworks.LowThermalMassWall</a>.
</p>
</html>"));
end LowThermalMassWall;
