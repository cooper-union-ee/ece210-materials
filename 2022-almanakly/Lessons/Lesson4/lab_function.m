function x = gaussPlotTest(x, mu, sigma)

    [xs,mus,sigs] = ndgrid(x, mu, sigma);

    Gaussians = 1/sqrt(2*pi*sigs.^2).*exp(-(xs-mus).^2./(2*sigs.^2));
    length(Gaussians)
    N = length(mu);
    M = length(sigma);
    
    figure
    hold on
    for i = 1:N
        for j = 1:M
            legendString = ['\mu = ',num2str(i),' \sigma = ',num2str(j)];
            plot(x,Gaussians(:,i,j),'DisplayName',legendString) 
        end
    end
    legend
    title("Gaussians")
    xlabel("x")
    ylabel("F(x)")

end