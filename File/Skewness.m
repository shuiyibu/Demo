function [ SNK ] = Skewness( k_ocurrence,type,dataSetName )
    len=length(k_ocurrence);
%     fprintf('len=%d\n',len);
    mean=sum(k_ocurrence)/len;
%     fprintf('mean=%d\n',mean);
    var=sqrt(sum((k_ocurrence-mean).^2)/len+eps);
%     fprintf('var=%d\n',var);
    
    SNK=sum(((k_ocurrence-mean)/var).^3)/len;   
    fprintf('SNK=%d\n',SNK);
    savePath=strcat('result/',dataSetName,'/');
    if type==2
        savePath=strcat('result/',dataSetName,'/2/');
    end
    save(strcat(savePath,'SNK.mat'),'SNK');
end

