%N jest liczb¹ generowanych bitów
N = input('Podaj liczbê bitów do wygenerowania\n');

Syg = BinSig(N, 'sygnal.txt');
PlotBinSig(Syg, 2,1,1);

ModSyg = PSKMod('sygnal.txt',1,3,100,'SygnalZmodulowany.txt');
PlotPSKMod(ModSyg, 2,1,2);