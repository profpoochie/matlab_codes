clear;      % clear data
clc;        % clear command window

disp('##################################################');
disp('Functional Generator Program');

% section for amplitude selection
R_amplitude = input('Please input the resistance for the required amplitude (1-100 Ohms): ');
while R_amplitude < 1 || R_amplitude > 100
    R_amplitude = input('Your Amplitude resistance is incorrect. Please input resistance between 1-100 ohms: ');
end
amp = R_amplitude;
fprintf('The computed wave amplitude is %.0f volts', amp);

% section for frequency selection
R_frequency = input('\nPlease input the resistance for the required frequency (1-1000 Ohms): ');
while R_frequency < 1 || R_frequency > 1000
    R_frequency = input('Your Frequency resistance is incorrect. Please input resistance between 1-1000 ohms: ');
end
f = R_frequency;
fprintf('The computed wave frequency is %.0f hertz.', f);

% section for endtime selection
t_endtime = input('\nPlease enter endtime value (t_endtime>0): ');
while t_endtime <= 0
    t_endtime = input('Input Error. Please enter endtime value (t_endtime>0): ');
end

% computation for t vector
t = linspace(0,t_endtime,1000);
% computation of angular velocity
w = 2*pi*f;
% this is number of fourier iteration. Please adjust for higher resolution
% the higher the value, the longer time for computation
last = 10000;

disp('##################################################');
disp('Please choose the type of waveform: Sine Wave, Rectangular, Sawtooth, Triangular')
disp('Enter the correct value of w0 and w1 based on the table below')
disp('             w0          w1');
disp('Sine         0           1');
disp('Rectangular  0           1');
disp('Sawtooth     1           0');
disp('Triangular   0           1');
w0 = input('Please enter the value of w0 (0 or 1): ');
while ~(w0==0 || w0==1)
    w0 = input('Error input. Please enter the value of w0 (0 or 1): ');
end
fprintf('You enter w0 = %.0f', w0);
w1 = input('\nPlease enter the value of w1 (0 or 1): ');
while ~(w1==0 || w1==1)
    w1 = input('Error input. Please enter the value of w0 (0 or 1): ');
end
fprintf('You enter w1 = %.0f', w1);
disp(' ');

selection = [char(w0) char(w1)];    % selection vector

% selection for code for waveforms
switch selection
    case [0 0]
        disp('You select Sine wave')
        sinewave(amp,w,t);
        title('Function Generator waveform: Sine wave');
    case [0 1]
        disp('You select Rectangular wave')
        C0 = 1/2;
        rectangular(C0,amp,w,t,last);
        title('Function Generator waveform: Rectangular wave');
    case [1 0]
        disp('You select Sawtooth wave')
        C0 = 0;
        sawtooth(C0,amp,w,t,last);
        title('Function Generator waveform: Sawtooth wave');
    case [1 1]
        disp('You select Triangular wave')
        C0 = 1/2;
        triagular(C0,amp,w,t,last);
        title('Function Generator waveform: Triangular wave');
end

% Plotting decorations
grid on;
xlabel('Time in seconds(s)');
ylabel('Voltage in volts(V)');


% Functions area

% function Rectangular waveform generator
function gr = sinewave(amp,w,t)
    gr = amp*sin(w*t);
    plot(t,gr);
end

% function Rectangular waveform generator
function gr = rectangular(C0,amp,w,t,last)
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
            gr = gr+C*cos(w*i.*t);
        end
    end
    gr = amp*gr;
    gr = medfilt1(gr,3);
    plot(t,gr);
end
% function Sawtooth waveform generator
function gr = sawtooth(C0,amp,w,t,last)
    gr=C0;
    for i=1:last
        % odd condition
        if (rem(i,2)==1), C=-2/(i*pi); end
        % even condition
        if (rem(i,2)==0), C=2/(i*pi); end
        gr = gr+C*sin(w*i.*t);
    end
    gr = amp*gr;
    gr = medfilt1(gr,3);
    plot(t,gr);
end
% function Triangular waveform generator
function gr = triagular(C0,amp,w,t,last)
    gr=C0;
    for i=1:last
        C = (2/(i*pi)^2)*(cos(i*pi)-1);
        gr = gr+C*cos(w*i.*t);
    end
    gr = amp*gr;
    gr = medfilt1(gr,3);
    plot(t,gr);
end

