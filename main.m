function  main( )
    fprintf('Spectral Clustering: Adding directories to current path...\n');
    
    addpath(genpath(pwd));
   
    disp('Hello');
    dataSetName='Ionosphere';
    dataPath=strcat('DataSet/',dataSetName,'/',dataSetName,'.mat');
    struct=load(dataPath);
    name=fieldnames(struct);
    dataSet=struct.(name{1});

    %Compute Natural Nearest Neighbor
    [K,k_ocurrenceSort, k_ocurrenceIndexSort,NNN,W ]=NN(dataSet,dataSetName,0);
    [errorHubs]=GenerateHub(dataSet,dataSetName,K,k_ocurrenceSort, k_ocurrenceIndexSort,NNN,0);
    [hubs]=UpdateHub( dataSet,dataSetName,NNN ,errorHubs);
    [dataSet]=UpdateDataSet(dataSet,errorHubs,hubs);
    [K,k_ocurrenceSort, k_ocurrenceIndexSort,NNN,W ]=NN(dataSet,dataSetName,2);
    GenerateHub(dataSet,dataSetName,K,k_ocurrenceSort, k_ocurrenceIndexSort,NNN,2);
    Type=3;
    [C, L, U] = SpectralClustering(W, 2, Type);


end

