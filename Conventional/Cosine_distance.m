function Cs=Cosine_distance(nodeNum,BasinGraph1,BasinGraph2,index1,index2)
    node = 2^nodeNum;
    tmp = dec2bin((0:node-1)');
    vectorList = zeros(node, nodeNum, 'double');
    vectorList(tmp == '0') = 0;
    vectorList(tmp == '1') = 1;
    if length(index1)>length(index2)
        temp=index2;
        index2=index1;
        index1=temp;
        temp=BasinGraph2;
        BasinGraph2=BasinGraph1;
        BasinGraph1=temp;
    end
    V1=1:length(index1);
    V2=1:length(index2);
    C=nchoosek(V2, length(index1));
    P=C(:, perms(1:length(index1)));
    V2=reshape(P,[],length(index1));
    avg_Cs=zeros(1,length(V2));
    for i=1:length(V2)
        for j=1:length(V1)
            ind = BasinGraph1(:,3) == index1(V1(j));
            Basin1=BasinGraph1(ind)';
            ind = BasinGraph2(:,3) == index2(V2(i,j));
            Basin2=BasinGraph2(ind)';
            mean_activity1=mean(vectorList(Basin1,:),1);
            mean_activity2=mean(vectorList(Basin2,:),1);

            xy=dot(mean_activity1,mean_activity2);
            nx=norm(mean_activity1);
            ny=norm(mean_activity2);
            Cs=xy/(nx*ny);
            avg_Cs(i)=avg_Cs(i)+Cs/length(index1);
        end
    end
    Cs=min(1-avg_Cs);
end

