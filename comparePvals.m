function [oldVSnew,mySoloPvals] = comparePvals(ATLASid,SNPloc,results)
%COMPAREPVALS Summary of this function goes here
%   Detailed explanation goes here

% soloPvals = readmatrix(['Data_Raw/GWAS-ATLAS/ATLAS-',ATLASid,'_pvals.txt']);
soloPvals = struct2array(load(['Data_Raw/GWAS-ATLAS/Pvals_ATLAS-',ATLASid,'.mat']));
mySoloPvals = soloPvals(SNPloc,:);

pairedSNP_sumPvals = cell(length(results)-1,1);

for p = 2:length(results)
    rsids = str2double(split(results{p,1},','));
    [in loc] = ismember(rsids,mySoloPvals(:,1));
    pairedSNP_sumPvals{p-1} = sum(-log10(mySoloPvals(loc,2)));
end

oldVSnew = [results(:,1),[{'-log10(p-val_expected)'};pairedSNP_sumPvals],results(1:end,2)];

end