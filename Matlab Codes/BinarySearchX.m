function y = BinarySearchX(mball)
    global Gball g;
    global Rfb Hfb Vwind Lamda Rousea Length...
        Fgg Fsb ...
        Gfb Ggg Gsb;
    
    m0 = 0;
    m2 = mball;
    H = 3;
    ntimes = 0;
    
    while((H - 2.0000000) * 1e6 > 1 || H < 2)
        ntimes = ntimes + 1;
        if(ntimes > 1e6)
            break;
        end
        if(m0 == m2)
            break;
        end
        m1 = (m0 + m2) / 2; 
        Gball = m1 * g;
        ansMat = fsolve('model1', [1,1,1,1,1,2]);
        H = ansMat(6);

        Ffb = Rousea * g * pi * Rfb ^ 2 * H;
        Fwind = 0.625 * 2 * Rfb * (Hfb - H) * Vwind ^ 2;
        Fy1 = (Ffb + 4 * Fgg + Fsb) - (Gfb + 4 * Ggg + Gsb + Gball);
        A = Fwind / (Lamda * g);
        xlower = -A * asinh((Length - (A * Fy1) / Fwind) / A);
        
        if (xlower < 0)
            ansMat = fsolve('model2', [0,0,0,0,0,2.0]);
            H = ansMat(6);

            Ffb = Rousea * g * pi * Rfb ^ 2 * H;
            Fwind = 0.625 * 2 * Rfb * (Hfb - H) * Vwind ^ 2;
            Fy1 = (Ffb + 4 * Fgg + Fsb) - (Gfb + 4 * Ggg + Gsb + Gball);
            A = Fwind / (Lamda * g);
            xlower = -A * asinh((Length - (A * Fy1) / Fwind) / A);
        end

        if ((H - 2.0000000) * 1e6 > 1 && xlower < 0)
            m2 = m1;
        else
            m0 = m1;
        end
    end
    
    xupper = A * asinh(Fy1 / Fwind);
    s1 = A * sinh(xupper / A);
    xHorizon = Length - s1;
    y = xHorizon;
end