function y = myfho(x)
global l costheta1 costheta2 costheta3 costheta4 costheta5 fupper Fwind lamda g h Depth
f = l * (costheta1 + costheta2 + costheta3 + costheta4 + costheta5) + fupper - Fwind / (lamda * g) + h - Depth;
y = double(subs(f,x));
end