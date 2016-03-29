function [errorHubs]= GenerateHub( dataSet,dataSetName,K,k_ocurrenceSort, k_ocurrenceIndexSort,NNN,type )
    fprintf('Error Begin...\n');
%     struct=load(strcat('Result/',dataSetName,'/NNN.mat'));
%     names=fieldnames(struct);
%     NNN=struct.(names{1});
    [N, dim]=size(NNN);

    err=zeros(1,N);
    err_avg=zeros(1,N);
    %Load Labeled DataSet
    struct=load(strcat('DataSet/',dataSetName,'/',dataSetName,'_labeled.mat'));
    names=fieldnames(struct);
    dataLabel=struct.(names{1});
   
    % Compute Avg Error Rate
    for i=1:N
        label=dataLabel(i,1);
        for j=1:N
            if(NNN(i,j)==0)
                break;
            end
            label2=dataLabel(NNN(i,j),1);
            if(label~=label2)
                err(i)=err(i)+1;
            end        
        end
        if(j~=1)
            err_avg(i)=err(i)/(j-1);
        end    
    end
    
    savePath=strcat('result/',dataSetName,'/');
    if type==2
        savePath=strcat('result/',dataSetName,'/2/');
    end
    if ~exist(savePath,'dir') 
        mkdir(savePath);
    end

    save(strcat(savePath,'err.mat'),'err');
    save(strcat(savePath,'err_avg.mat'),'err_avg');
    [errSort,errorIndexSort]=sort(err,2,'descend');
    save(strcat(savePath,'errorIndexSort.mat'),'errorIndexSort');
    save(strcat(savePath,'errSort.mat'),'errSort');
    [err_avgSort,errorIndex_avgSort]=sort(err_avg,2,'descend');
    save(strcat(savePath,'errorIndex_avgSort.mat'),'errorIndex_avgSort');
    save(strcat(savePath,'err_avgSort.mat'),'err_avgSort');
    
    %Compute Error Rate with k_occurence >2k
    errorHubs=zeros(4,N);
    
    th=2*K;
    sum=0;
    for i=1:N
        k_ocurrence=k_ocurrenceSort(1,i);
        if k_ocurrence<th
            break;
        end
        errorHubs(1,i)=k_ocurrence;
        errorHubs(2,i)=k_ocurrenceIndexSort(1,i);
        
        errorHubs(3,i)=err(1,errorHubs(2,i));
        [a,b]=ismember(errorHubs(2,i),errorIndexSort);
        errorHubs(4,i)=b;    
        if(b>th)
            sum=sum+1;
        end
    end
    errorHubs=errorHubs(1:4,1:i);
    errorHubs(4,i)=sum/(i-1);
    save(strcat(savePath,'errorHubs.mat'),'errorHubs');
   
    fprintf('Error End...\n');
%     Detection( dataSet,dataSetName,NNN ,errorHubs);



end

