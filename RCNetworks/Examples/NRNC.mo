within RCNetworks.Examples;
model NRNC
  import RCNetworks;
  extends Modelica.Icons.Example;

  RCNetworks.NRNC  m2R1C(
    n=2,
    RExt={0.15,0.3},
    RExtRem=0.2,
    CExt={400,200},
    T_start=293.15)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Step Tin(
    height=3,
    offset=273.15 + 22,
    startTime=3600)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.Constant Tout(k=273.15 + 35)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
equation
  connect(Tin.y, m2R1C.Tin) annotation (Line(points={{-59,30},{-36,30},{-36,
          6.36364},{-12,6.36364}},
                   color={0,0,127}));
  connect(Tout.y, m2R1C.Tou) annotation (Line(points={{-59,-10},{-36,-10},{-36,
          -0.909091},{-12,-0.909091}},
                    color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=7200));
end NRNC;
