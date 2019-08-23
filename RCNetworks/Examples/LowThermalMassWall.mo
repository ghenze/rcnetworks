within RCNetworks.Examples;
model LowThermalMassWall
  extends Modelica.Icons.Example;

  RCNetworks.LowThermalMassWall  wal
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Step TInt(
    height=5,
    offset=273.15 + 21,
    startTime=600)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Constant TExt(
    k=273.15 + 30)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant QHea(k=100)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
equation
  connect(TInt.y, wal.TInt) annotation (Line(points={{-59,50},{-20,50},{-20,8},{
          -12,8}}, color={0,0,127}));
  connect(TExt.y, wal.TExt) annotation (Line(points={{-59,0},{-12,0}},
                    color={0,0,127}));
  connect(QHea.y, wal.QRad) annotation (Line(points={{-59,-50},{-20,-50},{-20,-8},
          {-12,-8}}, color={0,0,127}));
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
