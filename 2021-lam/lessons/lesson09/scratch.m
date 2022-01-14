clear;clc;close all;

%% TODO: move the SOS stuff to a different lecture?

%% Second Order Sections
filterDesigner

%%
[b,a] = sos2tf(SOS,G)

%% Second Order Systems
wn = 100;
zeta = [0.5 1 2];   % damping factor
titles = ["Underdamped", "Critically Damped", "Overdamped"];
figure
for i = 1:3
    subplot(3,1,i);
    b = wn^2;
    a = [1 2*zeta(i)*wn wn^2];
    sys = tf(b,a);
    step(sys)
    title(titles(i));
end