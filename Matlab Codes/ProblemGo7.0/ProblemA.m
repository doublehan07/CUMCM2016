function ProblemA(vwind, vsea, mball, depth)
global Fsb Fgg...
        Length l Depth Vwind Vsea Lamda g Rousea... 
        Gsb Ggg Gfb Gball...
        Rfb Rsb Rgg Hfb;
global HorizonFlag SinkFlag;
global Theta1 Theta2 Theta3 Theta4 Theta5 H;
global Ca ThetaCa ThetaMao xHorizon A;

g = 9.8;
Rfb = 1;
Hfb = 2;
Mfb = 1000;
Mmao = 600;
l = 1;
Rgg = 25e-3;
Mgg = 10;
Rsb = 15e-2;
Msb = 100;

Length = 22.05;
Lamda = 7;
Mball = mball;
Depth = depth;
Rousea = 1.025e3;

Vwind = vwind;
Vsea = vsea;

Fgg = Rousea * g * pi * Rgg ^ 2 * l;
Fsb = Rousea * g * pi * Rsb ^ 2 * l;
Gfb = Mfb * g;
Ggg = Mgg * g;
Gsb = Msb * g;
Gball = Mball * g;

ansMat = fsolve('model1', [1,1,1,1,1,1.9]);
Theta1 = rad2deg(ansMat(1));
Theta2 = rad2deg(ansMat(2));
Theta3 = rad2deg(ansMat(3));
Theta4 = rad2deg(ansMat(4));
Theta5 = rad2deg(ansMat(5));
H = ansMat(6);

Ffb = Rousea * g * pi * Rfb ^ 2 * H;
Fwind = 0.625 * 2 * Rfb * (Hfb - H) * Vwind ^ 2;
Fy1 = (Ffb + 4 * Fgg + Fsb) - (Gfb + 4 * Ggg + Gsb + Gball);
A = Fwind / (Lamda * g);
xupper = A * asinh(Fy1 / Fwind);
xlower = -A * asinh((Length - (A * Fy1) / Fwind) / A);
HorizonFlag = 0;
SinkFlag = 0;

if (xlower < 0)
    ansMat = fsolve('model2', [0,0,0,0,0,2.0]);
    Theta1 = rad2deg(ansMat(1));
    Theta2 = rad2deg(ansMat(2));
    Theta3 = rad2deg(ansMat(3));
    Theta4 = rad2deg(ansMat(4));
    Theta5 = rad2deg(ansMat(5));
    H = ansMat(6);

    Ffb = Rousea * g * pi * Rfb ^ 2 * H;
    Fwind = 0.625 * 2 * Rfb * (Hfb - H) * Vwind ^ 2;
    Fy1 = (Ffb + 4 * Fgg + Fsb) - (Gfb + 4 * Ggg + Gsb + Gball);
    A = Fwind / (Lamda * g);
    xupper = A * asinh(Fy1 / Fwind);
    xlower = -A * asinh((Length - (A * Fy1) / Fwind) / A);
    
    s1 = A * sinh(xupper / A);
    xHorizon = Length - s1;
    Ca = [xupper,A * cosh(xupper / A) - A];
    ThetaMao = 0;
    HorizonFlag = 1;
end

ThetaCa = rad2deg(atan(Fy1 / Fwind));
if (HorizonFlag == 0)
    ThetaMao = rad2deg(atan((Fy1 - Lamda * g * Length) / Fwind));
end
Ca = [xupper - xlower,A * (cosh(xupper / A) - cosh(xlower / A))];

if (H >= 2.0000000000)
    SinkFlag = 1;
    xHorizon = BinarySearchX(Mball);
    Ca(1) = xHorizon;
    Ca(2) = ((Ffb + 4 *  Fgg + Fsb) - (Gfb + 4 * Ggg + Gsb + Gball)) / (Lamda * g);
end

end