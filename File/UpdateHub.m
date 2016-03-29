function [hubs]=UpdateHub( dataSet,dataSetName,NNN ,errorHubs)
    fprintf('Detection Start...\n');
    len=length(errorHubs);
    %Last Column is Statics
    len=len-1;
    [N,dim]=size(dataSet);
    savePath=strcat('result/',dataSetName,'/');
    
    %Test
    %len=1;
    hubs=zeros(len,dim);
    for i=1:len        
        index=errorHubs(2,i);
        
        hub=dataSet(index,:);
        antiNN=NNN(index,:);
       
       antiNNSet=zeros(N,dim);
       for j=1:N
           antinn=antiNN(j);
           if antinn==0
               break;           
           end
           antiNNSet(j,:)=dataSet(antinn,:);           
       end
       
       antiNNSet=antiNNSet(1:(j-1),:);
       error=zeros(j-1,dim);
       wt=zeros(j-1,dim);
       %Statics Result
       err=zeros(4,dim);
       %improvement
%        hub
%        disp('-------');
%        antiNNSet(:,1)
       for k=1:dim
           %fprintf('K=%d\n',k);
           
           error(:,k)=abs(antiNNSet(:,k)-hub(k));
           
           X=error(:,k);           
           mean=sum(X)/(j-1);
           var=sum((X-mean).^2)/(j-1)+eps;
           err(1,k)=mean;
           err(2,k)=var;
           wt(:,k)=exp(-(X-mean)/var);
           
           
           val=wt(:,k)'*antiNNSet(:,k)/sum(wt(:,k));
           %disp(val);
           hubs(i,k)=val;
       end  
       
       save(strcat(savePath,'wt.mat'),'wt');
       save(strcat(savePath,'antiNNSet.mat'),'antiNNSet');
       
    end  
    save(strcat(savePath,'hubs.mat'),'hubs');
    
    fprintf('Detection End...\n');
end

