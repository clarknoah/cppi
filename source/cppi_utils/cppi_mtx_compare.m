function result = cppi_mtx_compare(mtx1,mtx2)
%MTX_COMPARE Function compares two matricies to see if they are equal
%   Output is an array with a value for each dimension comparison, 1 =
%   match, 0 = not the same.
%   output: [];
%   Detailed explanation goes here

%compare size of matrix
mtx1_length = length(size(mtx1));
mtx2_length = length(size(mtx2));
if(mtx1_length==mtx2_length)
    cmp_length = mtx1_length;
    dim_equivalence_result = 1;
    max_size=max(size(mtx1)==size(mtx2));
    min_size=min(size(mtx1)==size(mtx2));
    if(max_size==1 && min_size==1)
        size_equivalence_result=1;
        max_val = max(mtx1==mtx2);
        min_val = min(mtx1==mtx2);       
        for count=1:cmp_length
            max_val = max(max_val);
            min_val = min(min_val); 
        end
        if(max_val==1 && min_val==1)
            mtx_equivalence_result=1;
        else
            mtx_equivalence_result=0;
        end
    else
        size_equivalence_result = 0;
        mtx_equivalence_result = 0;
    end 
else
    dim_equivalence_result = 0;
    size_equivalence_result = 0;
    mtx_equivalence_result = 0;   
end
result = [mtx_equivalence_result, size_equivalence_result, dim_equivalence_result];
disp(result);
end

