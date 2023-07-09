%u = udpport("datagram");
clear u;
u = udpport("LocalPort",8888);
x = 1:1000;
y = nan(1,1000);
p = plot(x,y);
ylim([-10,50]);
xlim([0,1000]);
grid on;
drawnow;
i = 1;
while true
    if(u.NumBytesAvailable > 0)
        data = read(u,u.NumBytesAvailable,"string");

        strArray = split(data,';');
        %disp(data);
        for i = 1:length(strArray)
            data = strArray(i);
            [hasStr, val] = checkValue("temp:",data);
            if hasStr; p.YData = [p.YData(2:end) val];pause(0.1);end
            [hasStr, val] = checkValue("rly:", data);
            if hasStr; if (val == 1); disp("RELAY ON"); else; disp("RELAY OFF");end;end
            [hasStr, val] = checkValue("maxmin:", data);
            if hasStr
                maxVal = bitsra(val,8);
                disp(maxVal);
                minVal = bitand(val,int16(0xff),'int16');
                disp(minVal);
            end
        end
    end
    
end

function [isContain, val] = checkValue(strhead, data)
    isContain = contains(data, strhead);
    if isContain
        newdata = erase(data, strhead);
        newdata = erase(newdata,";");
        val = str2double(newdata);
    else
        val = 0;
    end
end