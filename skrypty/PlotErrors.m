SampleRate = 1;
Amplitude = 1;
Variant = 16;
N = 500;

for amp = 1:100
    for ph = 1:100
        clear obj1;
        obj1 = NPSK(Variant,Amplitude,SampleRate);
        obj1 = Generate(obj1,N,'');
        obj1 = Modulate(obj1, '', '');
        obj1 = TransmissionChannel(obj1, '', amp/200, ph/800);
        obj1 = Demodulate(obj1, '');
        BER(amp,ph) = obj1.BER;
    end
end
surf(BER);
xlabel('Phase noise')
ylabel('Amplitude noise')
title('Wykres BER - 3d');