function NearestNeighbor(dataSet,dataSetName)
    fprintf('Nearest Neighbor Begin...\n');

    [N, dim]=size(dataSet);
        
    %Compute Rejoint Matrix
    tic;
    dist = squareform(pdist(dataSet));
    toc
    
    %
    [sdist,index]=sort(dist,2);
    
    %Natural Nearest Neighbor 
    flag=0;
    r=1;
    %Anti Nearest Neighbout Times
    nb=zeros(1, N);
    %Anti Nearest Neighbout Sets
    NNN=zeros(N, N);
    %Adjacency matrix
    W=zeros(N, N);
    while flag==0
        temp=nb;
        
        %Check Each Node Whether Being Considered As Anti-NN
        if ismember(0,nb)~=1
            flag=1;
        else
            %Compute i's rth Nearest Neighbor
            %From 2nd column, 1st is self
            mdist=index(:,(r+1));

            for i=1:N
                nb(mdist(i))=nb(mdist(i))+1;
                NNN(mdist(i),nb(mdist(i)))=i;
                W(mdist(i),i)=dist(i,mdist(i));
                W(i,mdist(i))=W(mdist(i),i);
            end
        end
        
        %Compare the Differences
        diff=(temp==nb);
        if ismember(0,diff)==0
            flag=1;
        end
        r=r+1;
    end
    K=r-1;
    fprintf('k==%d\n',K);
    % NN=index(:,1:K);
%     NN=zeros(N); disp(index);
   

    % Construct Adjoint Matrix
%     for i=1:N
%         for j=1:K
%             NN(i,index(i,j))=1;
%         end
%     end
%     
    savePath=strcat('Result/',dataSetName,'/');
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
    


    %     AdjointMatrixGraph(NN,0);
    fprintf('Nearest Neighbor End...\n');
    disp('----------------');
    Error( dataSet,dataSetName );

    
    

   
    
end