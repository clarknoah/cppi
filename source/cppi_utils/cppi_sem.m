function [sem] = cppi_sem(data)
%CPPI_SEM Generates the Standard Error of the Mean for a given matrix.

    sem=std(data)/sqrt(length(data));

end

