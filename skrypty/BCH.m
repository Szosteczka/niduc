clc;
clear all;

Variant = 2;
Amplitude = 1;
SampleRate = 50;
N = 45;
ampNoise = .05;
phNoise = .01;


obj = NPSK(Variant,Amplitude,SampleRate);

obj = Generate(obj,N,'sygnal.txt');

%kodowanie BCH do pliku 'sygnalZakodowany.txt'
obj2 = BCHCodings(8, 45);
BCHEncode(obj2, 'sygnal.txt');
%--

PlotBitSignal(obj,4,1,1);

obj = Modulate(obj, 'sygnalZakodowany.txt', 'sygnalZmodulowany.txt');

PlotNPSKModulator(obj, 4, 1, 2);

obj = TransmissionChannel(obj, 'SygnalZnieksztalcony.txt', ampNoise, phNoise);

PlotTransmissionChannel(obj, 4, 1, 3);


obj = Demodulate(obj, 'sygnalOdebrany.txt');

%dekodowanie zdemodulowanej wiadomo�ci
obj3 = BCHCodings(8, 45);
BCHDecode(obj3, 'sygnalZakodowany.txt', 'kod.txt');
%--
%Jedna rzecz mnie zastanawia.
%W�a�ciwie wszystko powinno przebiega� w spos�b nast�puj�cy:
%koder->modulator->kana�->demodulator->dekoder
%wi�c modulator powinien czerpa� sygna� z kodera, kana� z modulatora,
%demodulator odbiera� w kanale i dekoder dekodowa� zdemodulowany.
%jednak wed�ug tego co dzieje si� w kodzie, demodulator zamiast
%bra� kod z kana�u transmisyjnego (czyli sygnalZnieksztalcony.txt, tudzie�
%obj.transmittedSignal_m) bierze obj.rxpsk. Nie jestem pewien co do reszty,
%bo ju� si� troszk� pogubi�em, jednak efekt jest taki, �e sygnal generuje
%si� ok, koduje si� ok, moduluje si� ok, przy transmisji lub demodulacji
%cos si� chrzani, bo sygnalOdebrany.txt zamiast by� pe�n� wiadomo�ci� razem
%z kodem BCH, jest tylko wiadomo�ci�. W ka�dym razie koder i dekoder
%dzia�aj�.
%--
PlotNPSKDemodulator(obj, 4, 1, 4);

PlotNPSKnoise(obj);

showBER(obj);


