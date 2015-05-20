%N jest liczb¹ generowanych bitów
N = input('Podaj liczbê bitów do wygenerowania\n');

Syg = BinSig(N, 'sygnal.txt');
PlotBinSig(Syg, 4,1,1);
clear classes;

ModSyg = PSKMod('sygnal.txt',1,3,100,'SygnalZmodulowany.txt');
PlotPSKMod(ModSyg, 4,1,2);
clear classes;

NoiseSyg = TransmissionChannel('SygnalZmodulowany.txt',100,'SygnalZniekszatalcony.txt',30);
PlotTransmissionChannel(NoiseSyg, 4,1,3);


DeModSyg = PSKDeMod('SygnalZniekszatalcony.txt',100,'SygnalOdkodowany.txt');
PlotPSKDeMod(DeModSyg, 4,1,4)
PlotPSKDeMod1(DeModSyg);


DataFileID1 = fopen('sygnal.txt', 'r');
SignalData1 = fscanf(DataFileID1, '%i');
DataFileID2 = fopen('SygnalOdkodowany.txt', 'r');
SignalData2 = fscanf(DataFileID2, '%i');
Errors = 0;

for j=1:length(SignalData1)
    if(SignalData1(j) ~= SignalData2(j))
        Errors = Errors + 1;
    end  
end

BER = Errors/length(SignalData1);

display(BER);

QPSKSignal = NPSK('sygnal.txt', 4, 30, 30);

QPSKSignalNoisy = NPSK('sygnal.txt', 4, 15, 15);

OPSKSignal = NPSK('sygnal.txt', 8, 30, 30);