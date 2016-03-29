function [ result ] = statics( array )
    
    len=length(array);
    u=unique(array);
    u=sort(u,'descend');
    size=length(u);
    result=zeros(2,size);
    result(1,:)=u;
    for i=1:len
        val=array(i);
        [x,index]=ismember(val,u);
        result(2,index)=result(2,index)+1;
    end


end

