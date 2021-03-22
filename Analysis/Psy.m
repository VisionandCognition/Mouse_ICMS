levels = unique(data_table.Amp);
psy = zeros(size(levels,1),4);

for i = 1:size(levels,1)
    psy(i,1) = levels(i);
    psy(i,2) = sum(data_table.Amp == psy(i,1));
    psy(i,3) = sum(data_table.Outcome(data_table.Amp ==psy(i,1)) == 1);
    psy(i,4) = psy(i,3)/psy(i,2);
end

