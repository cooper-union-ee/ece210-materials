%% Husam Almanakly - HW5 Answer Key 

clc
clear
close all 

%% 1 and 2 import entries from most_backed.csv

%Import all the data into a table 
data = readtable("most_backed.csv", VariableNamingRule="preserve");
N = size(data);
N = N(1);

%Initialize kickstarters cell array 
kickstarters = cell(1, N);

% Loop through and create each instance of a kickstarter
for i = 1:N
    %tmp object
    obj = kickstarter();
    obj.amtpledged = double(table2array(data(i,"amt.pledged")));
    obj.by = char(table2array(data(i, "by")));
    obj.category = char(table2array(data(i,"category")));
    obj.currency = char(table2array(data(i,"currency")));
    obj.goal = double(table2array(data(i,"goal")));
    
    %split location into city and state
    location = char(table2array(data(i, "location")));
    location = split(location, ", ");
    obj.City = location(1);
    obj.State = location(2);
    obj.numbackers = double(table2array(data(i, "num.backers")));
    
    %Store pledgetier (convert pledgeTiers and pledgeBackers to arrays from table char elms)
    pledgeTier = table2array(data(i, "pledge.tier"));
    pledgeTier = str2num(pledgeTier{1});
    pledgeBackers = table2array(data(i, "num.backers.tier"));
    pledgeBackers = str2num(pledgeBackers{1});
    pledgetier = struct("pledgeTier", pledgeTier, "pledgeBackers", pledgeBackers);
    obj.pledgetier = pledgetier;
    
    
    obj.title = char(table2array(data(i, "title")));
    obj.url = char(table2array(data(i, "url")));

    kickstarters{i} = obj;
end


%% Number 3 - plot tiers test

kickstarters{3}.plotTiers;
kickstarters{38}.plotTiers;
kickstarters{40}.plotTiers;
kickstarters{105}.plotTiers;

%% Number 4

%Converts 1 from usd -> eur and eur -> usd
kickstarters{1} = kickstarters{1}.convertCurrency('eur');
kickstarters{1}

kickstarters{1} = kickstarters{1}.convertCurrency('usd');
kickstarters{1}


%converts gbp -> cad and cad -> usd and usd -> gbp
kickstarters{79} = kickstarters{79}.convertCurrency("cad");
kickstarters{79}

kickstarters{79} = kickstarters{79}.convertCurrency("usd");
kickstarters{79}

kickstarters{79} = kickstarters{79}.convertCurrency("gbp");
kickstarters{79}


%% Save kickstarters as a mat file

save("results", "kickstarters")







