function [sem] = cppi_sem(matrix)
%CPPI_SEM Generates the Standard Error of the Mean for a given matrix.

    sem=std(data)/sqrt(length(data));

end

