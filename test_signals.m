clear all; close all; clc;
fc = 10; 
fs =100; %fs > 2BW
BW = 16;
endt=10;
t = 0:1/(fs):endt;
speed = 1500;

t2 = 0:1/fs:(endt+1);
t3 = 0:1/fs:(endt+2);

%TX signal parameters.
A0=1;
t0=1;
tchirp = 0:1/(fs):t0;
s0(2,:) = 0:1/fs:t0; % s0 (2,:) = t
 s0(1,:) = A0*(sin(2*pi*fc*s0(2,:))); %exp not sin  % standard signal
% % % % s0(1, [(t0*fs)+1:1+(endt*fs)]) = 0; % zero-padding s0 signal

% s0(1,:) = A0*(sin(2*pi*((fc - (BW/2))*s0(2,:) + (BW/(2*t0))*(s0(2,:).^2)))); % analytical formula chirp

 s0(1,:) = chirp(tchirp, 2, 0.5, 10); % chirp function

plot (s0(2,:), s0(1,:), 'b');
energy = norm(s0(1,:))^2;
 

%Echo Impulse Response
A1=0.5; A2 = 0.3;
t01 = 3; t02 = 5;
dist01 = (t01/2)*speed;
dist02 = (t02/2)*speed;
ft = A1*imp_resp(t01,t0,fs,endt,0) + A2*imp_resp(t02,t0,fs,endt,0); %impulse response as opposed to simply delta function
ft = ft';
fr = conv(s0(1,:),ft);
% % % % echo1 = impulsive(s0,t01,A1,endt,fs,t0); echo2 = impulsive(s0, t02, A2,endt,fs,t0);
% % % % ft(1,:) = echo1(1,:) + echo2(1,:);
% % % % ft(2,:) = echo1(2,:);
fr = fr((0.5*fs):((endt*fs)+(0.5*fs)));
hold on; %figure of Tx & impulse response
plot(t,ft,'r');
legend('Transmitted signal','Impulse Response');

figure; %figure of tx & rx
plot (s0(2,:), s0(1,:), 'b');
hold on;
plot(t, fr,'r');
title('Plot of transmitted & received signals');
legend('Transmitted signal','Received signal');

matching = match(s0(1,:),fr) ./(energy*2);
matching = matching((0.5*fs):((endt*fs)+(0.5*fs)));
figure;
plot(t,matching);
title('Matched filtered response');
ylim([-1.5 1.5]);
xlim([0 7]);
