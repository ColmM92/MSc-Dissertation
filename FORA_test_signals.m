clear all; close all; clc;
t1 = 10; %inst. time - halfway point = f1 (midpoint freq), pulse = 20s
f0 = 1800; % f @ t=0
fmax = 2600;
f1 = (f0+fmax)/2;% f @ t=t1
BW = fmax-f0;
fs = 8000; %10*(fmax*2);
t = 0:1/(fs):20;%time array

CAS = (chirp(t,f0,t1,f1)); 

tP = 0:1/(fs):1;
t1P = 0.5; %inst. time - halfway point = f1 (midpoint freq), pulse = 1s
f0P = 2700;
fPmax = 3500;
f1P = (f0P + fPmax)/2;

PAS = (chirp(tP,f0P,t1P,f1P)); 

plot(t,CAS,'b');hold on; plot(tP,PAS,'r'); %amplitudes different for PAS & CAS
ylim([-1.5 1.5]);
