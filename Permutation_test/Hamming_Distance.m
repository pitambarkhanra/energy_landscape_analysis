function h_d=Hamming_Distance(nodeNum,index1,index2)
    node = 2^nodeNum;
    tmp = dec2bin((0:node-1)');
    vectorList = zeros(node, nodeNum, 'double');
    vectorList(tmp == '0') = 0;
    vectorList(tmp == '1') = 1;
    
    if length(index1)>length(index2)
        temp=index2;
        index2=index1;
        index1=temp;
    end
    V1=1:length(index1);
    V2=1:length(index2);
    C=nchoosek(V2, length(index1));
    P=C(:, perms(1:length(index1)));
    V2=reshape(P,[],length(index1));
    avg_h_d=zeros(1,length(V2));
    for i=1:length(V2)
        for j=1:length(V1)
            d=xor(vectorList(index1(j),:),vectorList(index2(V2(i,j)),:));
            Hamming_dist=sum(d);
            avg_h_d(i)=avg_h_d(i)+Hamming_dist/length(index1);
        end
    end
    h_d=min(avg_h_d);
end

