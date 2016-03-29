function [dataSet]=UpdateDataSet(dataSet,errorHubs,hubs)
    len=length(errorHubs)-1;
    for i=1:len
        index=errorHubs(2,i);
        dataSet(index,:)=hubs(i,:);
    end
end

