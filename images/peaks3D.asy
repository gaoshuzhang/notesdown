settings.outformat = "pdf";
import graph3;
import grid3;
import palette;

currentprojection=orthographic(0.8,1,1);

size(400,300,IgnoreAspect);

defaultrender.merge=true;

real f(pair z) {return 3*(1-z.x)*exp(-z.x^2-(z.y+1)^2)-10*(z.x/5-z.x^3-z.y^5)*exp(-z.x^2-z.y^2)-1/3*exp(-(z.x+1)^2-z.y^2);}

surface s=surface(f,(-3,-3),(3,3),50,Spline);

draw(s,mean(palette(s.map(zpart),Rainbow())),black); 

grid3(XYZgrid);
