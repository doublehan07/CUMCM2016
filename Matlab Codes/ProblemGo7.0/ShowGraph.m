function ShowGraph
    global HorizonFlag SinkFlag;
    global xHorizon Ca A;
    
    if(HorizonFlag + SinkFlag == 0)
        x = (0:Ca(1)/100:Ca(1));
        y = A * cosh (x / A) - A;
        plot(x,y);
    elseif(HorizonFlag == 1 && SinkFlag == 0)
    elseif(HorizonFlag == 0 && SinkFlag == 1)
    else
        x = (0:xHorizon / 100:xHorizon);
        y = 0;
        plot(x,y);
        hold on;
        
        x = 0;
        y = (0:Ca(2) / 100:Ca(2));
        plot(x,y);
        hold on;
        
        y = (Ca(2):0.01:Ca(2)+1);
        plot(x,y);
        hold on;
        
        y = (Ca(2)+1:0.01:Ca(2)+2);
        plot(x,y);
        hold on;
        
        y = (Ca(2)+2:0.01:Ca(2)+3);
        plot(x,y);
        hold on;
        
        y = (Ca(2)+3:0.01:Ca(2)+4);
        plot(x,y);
        hold on;
        
        y = (Ca(2)+4:0.01:Ca(2)+5);
        plot(x,y);
        hold on;
    end
end