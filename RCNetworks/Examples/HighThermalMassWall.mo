within RCNetworks.Examples;
model HighThermalMassWall
  extends Modelica.Icons.Example;

  RCNetworks.HighThermalMassWall wal
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Step TInt(
    height=5,
    offset=273.15 + 21,
    startTime=3600)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.Constant TExt(
    k=273.15 + 30)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
equation
  connect(TInt.y, wal.TInt) annotation (Line(points={{-59,30},{-20,30},{-20,8},{
          -12,8}}, color={0,0,127}));
  connect(TExt.y, wal.TExt) annotation (Line(points={{-59,-20},{-20,-20},{-20,0},
          {-12,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=7200));
end HighThermalMassWall;
