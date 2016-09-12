function y = myf(x)
global Vwind Vsea Length lamda g l rgg rsb;
global alpha beta1 beta3 beta4 beta5 beta6 beta7;

theta1 = x(1);
theta2 = x(2);
theta3 = x(3);
theta4 = x(4);
theta5 = x(5);
h = x(6);

gamma1 = 374 * 2 * Vsea ^ 2 * l * h;
gamma2 = 374 * l * 2 * rgg * Vsea ^ 2 * l;
gamma3 = 374 * l * 2 * rsb * Vsea ^ 2 * l;

Fwind = 0.625 * 2 * (2 - h) * (Vwind * Vwind);
Fsea = gamma3 * cos(theta1) + gamma2 * (cos(theta2) + cos(theta3) + cos(theta4) + cos(theta5));
fupper = sqrt( ((alpha * h + beta1) ^ 2) / ((lamda * g) ^ 2) + ((Fwind + Fsea) ^ 2) / ((lamda * g) ^ 2));
flower = sqrt( ((alpha * h + beta1) / (lamda * g) - Length) ^ 2 + ((Fwind + Fsea) ^ 2) / ((lamda * g) ^ 2));

U1 = gamma1 * cos(theta1) + gamma2 * (cos(theta2) + cos(theta3) + cos(theta4) + cos(theta5)) * cos(theta1) + 0.5 * gamma3 * cos(2 * theta1);
U2 = gamma1 * cos(theta2) + gamma2 * (cos(theta3) + cos(theta4) + cos(theta5)) * cos(theta2) + 0.5 * gamma2 * cos(2 * theta2) - gamma2 * sin(theta1) * sin(theta2);
U3 = gamma1 * cos(theta3) + gamma2 * (cos(theta4) + cos(theta5)) * cos(theta3) + 0.5 * gamma2 * cos(2 * theta3) - gamma2 * (sin(theta1) + sin(theta2)) * sin(theta3);
U4 = gamma1 * cos(theta4) + gamma2 * cos(theta5) * cos(theta4) + 0.5 * gamma2 * cos(2 * theta4) - gamma2 * (sin(theta1) + sin(theta2) + sin(theta3)) * sin(theta4);
U5 = gamma1 * cos(theta5) + 0.5 * gamma2 * cos(2 * theta4) - gamma2 * (sin(theta1) + sin(theta2) + sin(theta3)) * sin(theta4);

y(1) = U1 + Fwind * cos(theta1) - (alpha * h + beta3) * sin(theta1);
y(2) = U2 + Fwind * cos(theta2) - (alpha * h + beta4) * sin(theta2);
y(3) = U3 + Fwind * cos(theta3) - (alpha * h + beta5) * sin(theta3);
y(4) = U4 + Fwind * cos(theta4) - (alpha * h + beta6) * sin(theta4);
y(5) = U5 + Fwind * cos(theta5) - (alpha * h + beta7) * sin(theta5);
y(6) = h + l * (cos(theta1) + cos(theta2) + cos(theta3) + cos(theta4) + cos(theta5)) + fupper - flower;

end