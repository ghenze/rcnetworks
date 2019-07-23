within RCNetworks.Examples;
model M2R1C
  import RCNetworks;
  extends Modelica.Icons.Example;

  RCNetworks.M2R1C m2R1C(
    R1=0.3,
    R2=0.15,
    C1=400) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Step Tin(
    height=3,
    offset=273.15 + 22,
    startTime=3600)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.Constant Tout(k=273.15 + 35)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
equation
  connect(Tin.y, m2R1C.Tin) annotation (Line(points={{-59,30},{-36,30},{-36,8},
          {-12,8}}, color={0,0,127}));
  connect(Tout.y, m2R1C.Tou) annotation (Line(points={{-59,-10},{-36,-10},{-36,
          0},{-12,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=7200));
end M2R1C;
