classdef kickstarter
   properties
      amtpledged
      by
      category
      currency
      goal
      City
      State
      numbackers
      pledgetier
      title
      url
   end
   methods
       function obj = kickstarter(val)
       end
       function r = plotTiers(obj, tier)
           x = obj.pledgetier.pledgeTier;
           y = obj.pledgetier.pledgeBackers;
           [v, w] = unique( x, 'stable' );
           duplicate_indices = setdiff( 1:numel(x), w );
            
           x(duplicate_indices) = [];
           y(duplicate_indices) = [];
           
           figure         
           bar(x, y)
           title("Backers per Pledge of " + string(obj.title), 'interpreter','none')
           xlabel("Pledge Tier")
           ylabel("Number of Backers")
           
           %Limit x axis to $500 pledges just for visualization and testing
           %purposes
%            if max(x)>500
%                xlim([0, 500])
%            end
           r = 0; 
       end
       function r = convertCurrency(obj, newCurrency)
           keys = {'usd', 'gbp', 'eur', 'cad'};
           values = {1, 0.80, 0.95, 1.31};
           currencyMap = containers.Map(keys, values);
           
           conversion = currencyMap(obj.currency)/(currencyMap(newCurrency));
           obj.amtpledged = obj.amtpledged * conversion; 
           obj.goal = obj.goal * conversion; 
           obj.pledgetier.pledgeTier * conversion; 
        
           obj.currency = newCurrency;
           r = obj;
       end
   end
end