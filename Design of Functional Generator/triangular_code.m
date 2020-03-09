clear;      % clear data
clc;        % clear command window
%clf;        % clear figure


% 
t = linspace(0,0.3,10000);  % definition of t form 0 to 4*pi
f = 10;
w = 2*pi*f;
gr = 1/2;
gr100 = triagular(gr,w,t,10000);   %assume with perfect precision
grid on;


% function for Fourier Series computation

function gr = triagular(gr,w,t,last)
    for i=1:last
        C = (2/(i*pi)^2)*(cos(i*pi)-1);
        gr = gr+C*cos(w*i.*t);
    end
    plot(t,gr)
    hold on;
end

