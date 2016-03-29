function  [K,k_ocurrence,k_ocurrenceSort, k_ocurrenceIndexSort,NNN,W ]=NN( dataSet,dataSetName,type )
    
    fprintf('Nearest Neighbor Begin...\n');

    [N, dim]=size(dataSet);
        
    %Compute Rejoint Matrix
    tic;
    dist = squareform(pdist(dataSet));
    toc
    
    %
    [sdist,index]=sort(dist,2);
    

    %???????
    r=1;
    flag=0;         
    nb=zeros(1,N);  %?????? 
    NNN=zeros(N,N); %????????
    W=zeros(N,N);
    count=0;        %???????????????????
    count1=0;       %???????????????
    count2=0;       %??????????????

    %????????
    while flag==0
        for i=1:N
            k=index(i,r+1);
            nb(k)=nb(k)+1;
            NNN(k,nb(k))=i;
            W(k,i)=dist(i,k);
            W(i,k)=W(k,i);
        end
        r=r+1;
        count2=0;
        for i=1:N
            if nb(i)==0
                count2=count2+1;
            end
        end
        %??nb(i)=0?????????????
        if count1==count2
            count=count+1;
        else
            count=1;
        end
        if count2==0 || (r>2 && count>=2)   %????????
            flag=1;
        end
        count1=count2;
    end

    %?????????????
    SUPk=r-1;               %??K??????????????
    K=SUPk;
    %disp(K);
    fprintf('K=%d\n',K);
    savePath=strcat('Result/',dataSetName,'/');
    if type==2
         savePath=strcat('Result/',dataSetName,'/2/')        
    end
    
    
    if ~exist(savePath,'dir') 
        mkdir(savePath);
    end
    
    k_ocurrence=nb;
    save(strcat(savePath,'k_ocurrence.mat'),'k_ocurrence');
    save(strcat(savePath,'K.mat'),'K');
    [k_ocurrenceSort,k_ocurrenceIndexSort]=sort(k_ocurrence,'descend');
    save(strcat(savePath,'k_ocurrenceSort.mat'),'k_ocurrenceSort');
    save(strcat(savePath,'k_ocurrenceIndexSort.mat'),'k_ocurrenceIndexSort');
    save(strcat(savePath,'NNN.mat'),'NNN');
    save(strcat(savePath,'W.mat'),'W');
    


    %     AdjointMatrixGraph(NN,0);   
    disp('-------Nearest Neighbor End---------');

end

