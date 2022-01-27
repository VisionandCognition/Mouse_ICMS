function msg = readMsg(obj)
%readMsg READ MESSAGES FROM INTAN TCP OBJECT
%   obj: variable name of the INTAN TCP object
    tic;
    elapsedTime = 0;
    while obj.BytesAvailable == 0 && elapsedTime < 0.1
        elapsedTime = toc;
        pause(0.01)
    end
    msgArray = read(obj);
    msg = char(msgArray);
end