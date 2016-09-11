global amin amax theta1 thetaMao;
amin = 10000;
amax = 0;
for v = 1200:100:3000
   GetGball(v);
   if (theta1 <= 5 && thetaMao <= 16)
       if v < amin amin = v; end
       if v > amax amax = v; end
   end
end