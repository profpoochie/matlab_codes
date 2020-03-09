clear;      % clear data
clc;        % clear command window
clf;        % clear figure

C0 = 1/2;   % value of C0
t = linspace(0,3*pi,10000);   % definition of t form 0 to 4*pi
nth_harmonic = 10000;           % maximum harmonic of this code

grnth = squarewave(C0,t,nth_harmonic);  % 'nth terms'

% legend for the group
legend('1 term','3 terms','6 terms','20 terms',...
    '50 terms','120 terms', 'nth terms');

% function for Fourier Series computation
function gr = squarewave(C0,t,last)
even = 2:2:last;
odd1 = 1:4:last;
odd2 = 3:4:last;
gr = C0;
    % for 1 term only condition
    if last == 0
       gr = repelem(gr,length(t));
    % for n terms condition
    else
        for i=1:last
            if (sum(even==i)), C=0; end
            if (sum(odd1==i)), C=(2/(i*pi())); end
            if (sum(odd2==i)), C=-(2/(i*pi())); end
            gr = gr+C*cos(i.*t);
        end
    end
plot(t,gr)
hold on;
end
