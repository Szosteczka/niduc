clc;
clear all;

Variant = 16;
Amplitude = 1;
SampleRate = 50;
N = 1000;
ampNoise = .04;
phNoise = .01;


obj = NPSK(Variant,Amplitude,SampleRate);

obj = Generate(obj,N,'sygnal.txt');

PlotBitSignal(obj,4,1,1);

obj = Modulate(obj, 'sygnal.txt', 'sygnalZmodulowany.txt');

PlotNPSKModulator(obj, 4, 1, 2);

obj = TransmissionChannel(obj, 'SygnalZnieksztalcony.txt', ampNoise, phNoise);


PlotTransmissionChannel(obj, 4, 1, 3);


obj = Demodulate(obj, 'sygnalOdebrany.txt');

PlotNPSKDemodulator(obj, 4, 1, 4);

PlotNPSKnoise(obj);

showBER(obj);


