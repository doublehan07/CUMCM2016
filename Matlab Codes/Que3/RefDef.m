global Vwind Vsea;
global Depth;
global rouwater;
global mfb mgg msb;
global mball;
global rfb rgg rsb;
global l g;
global Length;
global lamda;
global G2 F2 G1 F1 Gfb;
global alpha;
global beta1 beta2 beta3 beta4 beta5 beta6 beta7;
global h theta1 theta2 theta3 theta4 theta5;

Vwind = 12;
Vsea = 0;
Depth = 18;
rouwater = 1.025e3;
mfb = 1e3;
mgg = 10;
msb = 1e2;
mball = 1.2e3;
rfb = 1;
rgg = 25e-3;
rsb = 15e-2;
l = 1;
g = 9.8;
Length = 22.05;
lamda = 7;

syms h theta1 theta2 theta3 theta4 theta5;

G2 = mgg * g;
F2 = rouwater * g * pi * l * rgg ^ 2;
G1 = msb * g;
F1 = rouwater * g * pi * l * rsb ^ 2;
Gfb = mfb * g;

alpha = rouwater * g * pi * rfb ^ 2;
beta1 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb - mball * g;
beta2 = -Gfb;

beta3 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb + 0.5 * (G1 - F1);
beta4 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb + (G1 - F1) + 0.5 * (G2 - F2);
beta5 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb + (G1 - F1) + 1.5 * (G2 - F2);
beta6 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb + (G1 - F1) + 2.5 * (G2 - F2);
beta7 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb + (G1 - F1) + 3.5 * (G2 - F2);

gamma1 = 374 * 2 * Vsea ^ 2 * l * h;
gamma2 = 374 * l * 2 * rgg * Vsea ^ 2 * l;
gamma3 = 374 * l * 2 * rsb * Vsea ^ 2 * l;

Fwind = 0.625 * 2 * (2 - h) * (Vwind ^ 2);
Fsea = gamma3 * cos(theta1) + gamma2 * (cos(theta2) + cos(theta3) + cos(theta4) + cos(theta5));

ansMat = fsolve('myf',[1,1,1,1,1,10]',optimset('Display','off'));
THETA1 = double(ansMat(1,1));
THETA2 = double(ansMat(2,1));
THETA3 = double(ansMat(3,1));
THETA4 = double(ansMat(4,1));
THETA5 = double(ansMat(5,1));
H = double(ansMat(6,1));

FWIND = double(subs(Fwind, H));
FSEA = double(subs(Fsea, [h,theta1,theta2,theta3,theta4,theta5], [H,THETA1,THETA2,THETA3,THETA4,THETA5]));
A = (FWIND + FSEA) / (lamda * g);

x0 = A * asinh( (alpha * H + beta1) / (FWIND + FSEA) - Length / A);
x1 = A * asinh((alpha * H + beta1) / (FWIND + FSEA));
xupper = x1 - x0;

HorizonFlag = 0;
SinkFlag = 0;

if (x0 < 0)
    ansMat=fsolve('myfho',[1,1,1,1,1,10]',optimset('Display','off'));
    THETA1 = double(ansMat(1,1));
    THETA2 = double(ansMat(2,1));
    THETA3 = double(ansMat(3,1));
    THETA4 = double(ansMat(4,1));
    THETA5 = double(ansMat(5,1));
    H = double(ansMat(6,1));

    FWIND = double(subs(Fwind, H));
    FSEA = double(subs(Fsea, [h,theta1,theta2,theta3,theta4,theta5], [H,THETA1,THETA2,THETA3,THETA4,THETA5]));
    A = (FWIND + FSEA) / (lamda * g);

    x1 = A * asinh((alpha * H + beta1) / (FWIND + FSEA));
    
    xupper = x1;
    syms x;
    s = sqrt(1 + (sinh(x / A)) ^ 2);
    s1 = double(int(s, 0, x1));
    s2 = ((rouwater * H * pi * rfb ^ 2 * g + 4 * F2 + F1) - (Gfb + 4 * G2 + G1 + mball * g)) / (lamda * g);
    xHorizon = Length - s1;
    HorizonFlag = 1;
end

Fy3 = alpha * H + beta1 - lamda * Length * g;

THETA1 = THETA1 * 180 / pi;
THETA2 = THETA2 * 180 / pi;
THETA3 = THETA3 * 180 / pi;
THETA4 = THETA4 * 180 / pi;
THETA5 = THETA5 * 180 / pi;

thetaCa = atan ((alpha * H + beta1) / (FWIND + FSEA)) * 180 / pi;
thetaMao = atan(Fy3 / (FWIND + FSEA)) * 180 / pi;

yupper = Depth - (cos(THETA1 * pi / 180) + cos(THETA2 * pi / 180) + cos(THETA3 * pi / 180) + cos(THETA4 * pi / 180) + cos(THETA5 * pi / 180) + H);

if (H >= 2.0000000)
    SinkFlag = 1;
    yupper = ((rouwater * g * 2 * pi * rfb ^ 2 + 4 * F2 + F1) - (Gfb + 4 * G2 + G1 + mball * g)) / (lamda * g);
end