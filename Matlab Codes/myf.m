function y = myf(x)
global l costheta1 costheta2 costheta3 costheta4 costheta5 fupper flower h Depth
f = l * (costheta1 + costheta2 + costheta3 + costheta4 + costheta5) + fupper - flower + h - Depth;
y = double(subs(f,x));
end