within RCNetworks.RCElements;
model AirResistanceTemperature
  "Convective air resistance at exterior or interior walls"
  extends RCNetworks.BaseClasses.PartialAirResistanceIcon;

  parameter Modelica.SIunits.ThermalResistance R
    "Constant thermal resistance";

  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res(R=R)
    "Convective resistance"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Sources.PrescribedTemperature                               temReaCon
    "Temperature connector "
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealInput T "Outdoor temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    "Thermal heat port"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(temReaCon.port, res.port_a)
    annotation (Line(points={{-40,0},{0,0}}, color={191,0,0}));
  connect(temReaCon.T, T)
    annotation (Line(points={{-62,0},{-120,0}}, color={0,0,127}));
  connect(res.port_b, port_b)
    annotation (Line(points={{20,0},{100,0}}, color={191,0,0}));
  annotation (
  Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This model can be used to represent convective air resistance at exterior and interior wall surfaces.
</p>
</html>"));
end AirResistanceTemperature;
