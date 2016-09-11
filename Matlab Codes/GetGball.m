function GetGball(mball)

global Depth;
global rouwater;
global rfb;
global g;
global Length;
global lamda;
global G2;
global F2;
global G1;
global F1;
global Gfb;
global Gball;
global alpha;
global beta1;
global beta3;
global beta4;
global beta5;
global beta6;
global beta7;
global h;
global Fwind;
global fupper;
global flower;
global H;
global FWIND;
global A;
global Fy3;
global theta1;
global theta2;
global theta3;
global theta4;
global theta5;
global thetaCa;
global thetaMao;
global x0 xupper;
global x1 yupper;

global s1;
global s2;
global xHorizon;

global HorizonFlag SinkFlag;

% persistent SaveXHorizon;

Gball = mball * g;
beta1 = 4 * F2 + F1 - 4 * G2 - G1 - Gfb - mball * g;
fupper = sqrt( ((alpha * h + beta1) ^ 2) / ((lamda * g) ^ 2) + (Fwind ^ 2) / ((lamda * g) ^ 2));
flower = sqrt( ((alpha * h + beta1) / (lamda * g) - Length) ^ 2 + (Fwind ^ 2) / ((lamda * g) ^ 2));

% f = l * (costheta1 + costheta2 + costheta3 + costheta4 + costheta5) + fupper - flower + h - Depth;
% H = double(solve(f));
H = fsolve(@(h) myf(h),0.72,optimoptions('fsolve'));

FWIND = double(subs(Fwind,H));
A = FWIND / lamda / g;
x0 = A * asinh( (alpha * H + beta1) / FWIND - Length / A);
x1 = A * asinh((alpha * H + beta1) / FWIND);
xupper = x1 - x0;
HorizonFlag = 0;
SinkFlag = 0;

if (x0 < 0)
    H = fsolve(@(h) myfho(h),10,optimoptions('fsolve'));
    FWIND = double(subs(Fwind,H));   
    A = FWIND / lamda / g;
    x1 = A * asinh((alpha * H + beta1) / FWIND);
    xupper = x1;
    
    syms x;
    s = sqrt(1 + (sinh(x / A)) ^ 2);
    s1 = double(int(s, 0, x1));
    s2 = ((rouwater * H * pi * rfb ^ 2 * g + 4 * F2 + F1) - (Gfb + 4 * G2 + G1 + mball * g)) / (lamda * g);
    xHorizon = Length - s1;
    HorizonFlag = 1;
end

Fy3 = alpha * H + beta1 - lamda * Length * g;

theta1 = atan(FWIND / (alpha * H + beta3)) * 180 / pi;
theta2 = atan(FWIND / (alpha * H + beta4)) * 180 / pi;
theta3 = atan(FWIND / (alpha * H + beta5)) * 180 / pi;
theta4 = atan(FWIND / (alpha * H + beta6)) * 180 / pi;
theta5 = atan(FWIND / (alpha * H + beta7)) * 180 / pi;
thetaCa = atan ((alpha * H + beta1) / FWIND) * 180 / pi;
thetaMao = atan(Fy3 / FWIND) * 180 / pi;

yupper = Depth - (cos(theta1 * pi / 180) + cos(theta2 * pi / 180) + cos(theta3 * pi / 180) + cos(theta4 * pi / 180) + cos(theta5 * pi / 180) + H);

% if(H == 2.0000000) 
%     if isempty(SaveXHorizon)
%         SaveXHorizon = xHorizon;
%     end
% end

if (H >= 2.0000000)
    SinkFlag = 1;
%     xHorizon = SaveXHorizon;
    yupper = ((rouwater * g * 2 * pi * rfb ^ 2 + 4 * F2 + F1) - (Gfb + 4 * G2 + G1 + mball * g)) / (lamda * g);
end

end
