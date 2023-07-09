%u = udpport("datagram");
function u = RsvDataFromController(... %u, ... % UDP connection
    queueTemp, ... % queue for temperature
    queueRly, ... % queue for relay state
    queueMaxMin, ... % queue for max and min value of temperature
    queueRlyCnt) % queue for relay switch count
	%disp("Start");
    u = udpport("LocalPort",8888);
    try
        while true
            if(u.NumBytesAvailable > 0)
                data = read(u,u.NumBytesAvailable,"string");
        
                strArray = split(data,';');
                %disp(data);
                for i = 1:length(strArray)
                    data = strArray(i);
                    [hasStr, val] = checkValue("temp:",data);
                    if hasStr; send(queueTemp, val);end
                    [hasStr, val] = checkValue("rly:", data);
                    if hasStr; send(queueRly, val);end
                    [hasStr, val] = checkValue("maxmin:", data);
                    if hasStr; send(queueMaxMin, val);end
                    [hasStr, val] = checkValue("rcnt:", data);
                    if hasStr; send(queueRlyCnt, val);end
                end
            end
        end
    catch
        clear u;
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