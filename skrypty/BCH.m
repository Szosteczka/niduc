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

%dekodowanie zdemodulowanej wiadomoœci
obj3 = BCHCodings(8, 45);
BCHDecode(obj3, 'sygnalZakodowany.txt', 'kod.txt');
%--
%Jedna rzecz mnie zastanawia.
%W³aœciwie wszystko powinno przebiegaæ w sposób nastêpuj¹cy:
%koder->modulator->kana³->demodulator->dekoder
%wiêc modulator powinien czerpaæ sygna³ z kodera, kana³ z modulatora,
%demodulator odbieraæ w kanale i dekoder dekodowaæ zdemodulowany.
%jednak wed³ug tego co dzieje siê w kodzie, demodulator zamiast
%braæ kod z kana³u transmisyjnego (czyli sygnalZnieksztalcony.txt, tudzie¿
%obj.transmittedSignal_m) bierze obj.rxpsk. Nie jestem pewien co do reszty,
%bo ju¿ siê troszkê pogubi³em, jednak efekt jest taki, ¿e sygnal generuje
%siê ok, koduje siê ok, moduluje siê ok, przy transmisji lub demodulacji
%cos siê chrzani, bo sygnalOdebrany.txt zamiast byæ pe³n¹ wiadomoœci¹ razem
%z kodem BCH, jest tylko wiadomoœci¹. W ka¿dym razie koder i dekoder
%dzia³aj¹.
%--
PlotNPSKDemodulator(obj, 4, 1, 4);

PlotNPSKnoise(obj);

showBER(obj);


