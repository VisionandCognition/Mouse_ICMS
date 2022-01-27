function [time_paused] = uploadBreak(obj)
%writeBreak 
%   Give INTAN TCP server a break after a upload command by pausing MATLAB 
%   It returns the time MATLAB paused for user's reference
%   obj: variable name of the INTAN TCP object
    uploadInProgress = "True";
    m1 = tic;
    while ~strcmp(uploadInProgress, "False")
        uploadInProgress = getUploadInProgress(obj);
        pause(0.01);
    end
    time_paused = ['Time paused ' num2str(toc(m1)) ' s'];

end

