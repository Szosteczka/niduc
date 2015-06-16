SampleRate = 1;
Amplitude = 1;
Variant = 2;
N = 100;

for amp = 1:50
    for ph = 1:50
        clear obj1;
        obj1 = NPSK(Variant,Amplitude,SampleRate);
        obj1 = Generate(obj1,N,'');
        obj1 = Modulate(obj1, '', '');
        obj1 = TransmissionChannel(obj1, '', amp/200, ph/50);
        obj1 = Demodulate(obj1, '');
        BER(amp,ph) = obj1.BER;
    end
end
surf(BER);
%xlim([x(1) x(end)]);
xlabel('Phase noise')
ylabel('Amplitude noise')
title('Wykres BER - 3d');