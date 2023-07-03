function [tbl,index]=branch_index(thres,LocalMinIndex,Cost,E)
        k1=1:length(LocalMinIndex);
        for k=k1
            branch_length(k)=min(Cost(k,k1)-E(LocalMinIndex(k)));
        end
        [minValue, minIndex] = min(branch_length(k1));
        while minValue<thres
            k1(minIndex)=[];
            for k=k1
            branch_length(k)=min(Cost(k,k1)-E(LocalMinIndex(k)));
            end
            [minValue, minIndex] = min(branch_length(k1));
        end
        tbl=sum(branch_length(k1));  %total branch length of the significant local minima
        index=LocalMinIndex(k1);       %significant local minima index
end