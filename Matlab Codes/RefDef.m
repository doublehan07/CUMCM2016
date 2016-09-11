function RefDef(x)

global Vwind;
global Depth;
global rouwater;
global mfb;
global mgg;
global msb;
global rfb;
global rgg;
global rsb;
global l;
global g;
global Length;
global lamda;
global G2;
global F2;
global G1;
global F1;
global Gfb;
global alpha;
global beta2;
global beta3;
global beta4;
global beta5;
global beta6;
global beta7;
global h;
global Fwind;
global costheta1;
global costheta2;
global costheta3;
global costheta4;
global costheta5;

% Vwind = 12;
Vwind = x;
Depth = 18;
rouwater = 1.025e3;
mfb = 1e3;
mgg = 10;
msb = 1e2;
%mball = 1.2e3;
rfb = 1;
rgg = 25e-3;
rsb = 15e-2;
l = 1;
g = 9.8;
Length = 22.05;
lamda = 7;

G2 = mgg * g;
F2 = rouwater * g * pi * l * rgg ^ 2;
G1 = msb * g;
F1 = rouwater * g * pi * l * rsb ^ 2;
Gfb = mfb * g;

alpha = rouwater * g * pi * rfb ^ 2;
%beta1 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb - mball * g;
beta2 = -Gfb;

beta3 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb + 0.5 * (G1 - F1);
beta4 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb + (G1 - F1) + 0.5 * (G2 - F2);
beta5 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb + (G1 - F1) + 1.5 * (G2 - F2);
beta6 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb + (G1 - F1) + 2.5 * (G2 - F2);
beta7 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb + (G1 - F1) + 3.5 * (G2 - F2);

syms h;
Fwind = 0.625 * 2 * (2 - h) * (Vwind ^ 2);
costheta1 = (alpha * h + beta3) / sqrt(Fwind ^ 2 + (alpha * h + beta3) ^ 2);
costheta2 = (alpha * h + beta4) / sqrt(Fwind ^ 2 + (alpha * h + beta4) ^ 2);
costheta3 = (alpha * h + beta5) / sqrt(Fwind ^ 2 + (alpha * h + beta5) ^ 2);
costheta4 = (alpha * h + beta6) / sqrt(Fwind ^ 2 + (alpha * h + beta6) ^ 2);
costheta5 = (alpha * h + beta7) / sqrt(Fwind ^ 2 + (alpha * h + beta7) ^ 2);

end