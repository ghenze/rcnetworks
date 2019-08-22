within RCNetworks.Examples;
model CompareHighLowThermalWall
  "Compre the performance of high and low thermal mass wall"
  extends Modelica.Icons.Example;

  RCNetworks.HighThermalMassWall walHig "High thermal mass wall"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Sources.Step TInt(
    height=5,
    offset=273.15 + 21,
    startTime=600)
    annotation (Placement(transformation(extent={{-80,38},{-60,58}})));
  Modelica.Blocks.Sources.Constant TExt(
    k=273.15 + 30)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant QHea(k=100)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  RCNetworks.LowThermalMassWall walLow
    annotation (Placement(transformation(extent={{0,-52},{20,-32}})));
equation
  connect(TInt.y, walHig.TInt)
    annotation (Line(points={{-59,48},{-2,48}}, color={0,0,127}));
  connect(TExt.y, walHig.TExt) annotation (Line(points={{-59,0},{-34,0},{-34,40},
          {-2,40}}, color={0,0,127}));
  connect(QHea.y, walHig.QRad) annotation (Line(points={{-59,-50},{-20,-50},{-20,
          32},{-2,32}}, color={0,0,127}));
  connect(TInt.y, walLow.TInt) annotation (Line(points={{-59,48},{-14,48},{-14,-34},
          {-2,-34}}, color={0,0,127}));
  connect(TExt.y, walLow.TExt) annotation (Line(points={{-59,0},{-34,0},{-34,-42},
          {-2,-42}}, color={0,0,127}));
  connect(QHea.y, walLow.QRad)
    annotation (Line(points={{-59,-50},{-2,-50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1200),
    __Dymola_Commands(file="modelica://RCNetworks/Resources/Scripts/CompareHighLowThermalWall.mos"
        "Simulate and Plot"));
end CompareHighLowThermalWall;
