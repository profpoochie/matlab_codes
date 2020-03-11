clear;      % clear data
clc;        % clear command window
%clf;        % clear figure


% 
t = linspace(0,0.3,10000);  % definition of t form 0 to 4*pi
f = 10;
w = 2*pi*f;
C0 = 0;
gr100 = sawtooth(C0,w,t,10000);   %assume with perfect precision
grid on;


% function for Fourier Series computation

function gr = sawtooth(C0,w,t,last)
    gr=C0;
    for i=1:last
        % odd condition
        if (rem(i,2)==1), C=-2/(i*pi); end
        % even condition
        if (rem(i,2)==0), C=2/(i*pi); end
        gr = gr+C*sin(w*i.*t);
    end
    plot(t,gr)
    hold on;
end

