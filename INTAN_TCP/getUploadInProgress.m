function status = getUploadInProgress(obj)
%uploadInProgress CHECK UPLOAD PROGRESS IN INTAN TCP OBJ
%   obj: variable name of the INTAN TCP object
    
% first check if there're any residual messages in soket
    msg = readMsg(obj);
    disp(['Residual messages in socket:' msg]);

    
% then do the query
    write(obj, uint8(' get uploadinprogress;'));
    pause(0.001);
    msgString = readMsg(obj);
    expectedReturnString = 'Return: UploadInProgress ';
    if ~contains(msgString, expectedReturnString)
        disp('Unable to get upload progress from server');
    else
        status = msgString(length(expectedReturnString)+1:end);
    end
    
end
