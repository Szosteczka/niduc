classdef NPSK
    
    properties
        N_m = 0;
        variant_m = 2;
        signal_m = 0;
        amplitude_m = 1;
        sampleRate_m = 10;
        ampNoise_m = 0;
        phNoise_m = 0;
        filename_m = 0;
        modulatedSignal_m = 0;
        transmittedSignal_m = 0;
        demodulatedSignal_m = 0;
        Time_m = 0;
        fileID_m = 0;
        txpsk = 0;
        rxpsk = 0;
        recovpsk = 0;
        BER = 0;
    end
    
    methods
        function obj = NPSK(variant, amplitude, sampleRate)
            obj.variant_m = variant;
            obj.amplitude_m = amplitude;
            obj.sampleRate_m = sampleRate;
        end
        
        function obj =  Generate(obj, elements, filename)
            obj.N_m = elements; %liczba elementów ustawiana przez argument
            if ~strcmp(filename,'')
                obj.filename_m = filename;
                obj.fileID_m = fopen(obj.filename_m, 'w');
            end
            obj.signal_m = randi([0 obj.variant_m-1],obj.N_m,1);
            %powy¿sza funkcja randi generuje losowy int z przedzia³u
            %tu przedzia³ [1,2], i wype³nia nimi odpowiedni¹ macierz.
            %Poniewa¿ chcê sygna³ binarny, od wygenerowanych cyfr 1 i 2
            %odejmujê ostatecznie 1.
            if ~strcmp(filename,'')
                fprintf(obj.fileID_m, '%i\n',obj.signal_m);%zapis do pliku
                fclose(obj.fileID_m);
            end
        end
        
        function PlotBitSignal(obj,m,n,p)
            
            y=obj.signal_m;
            figure;
            subplot(m,n,p);
            stem(y);
            title('Bity wys³ane');
        end
        
        
        
        function obj = Modulate(obj, filename, out_filename)
            if ~strcmp(filename,'')
                obj.filename_m = filename;
                fid = fopen( filename, 'r');
                data = fscanf(fid, '%i');
            end
            data = obj.signal_m;
            
            t = 1/obj.sampleRate_m: 1/obj.sampleRate_m : 1;
            
            obj.txpsk = pskmod(data,obj.variant_m);
            for ii = 1: 1: length(obj.txpsk)
                t =  t + 1;
                obj.modulatedSignal_m = [obj.modulatedSignal_m obj.amplitude_m * cos(2*pi * t + angle(obj.txpsk(ii)))];
                obj.Time_m = [obj.Time_m t];
            end
            
            if ~strcmp(out_filename,'')
                SaveFileID = fopen(out_filename, 'w');
                fprintf(SaveFileID, '%i\n',obj.modulatedSignal_m);%zapis do pliku
                fclose(SaveFileID);
            end
            
        end
        
        
        function PlotNPSKModulator(obj, m, n, p) 
            
            subplot(m,n,p);
            plot(obj.Time_m,obj.modulatedSignal_m,'LineWidth',2);
            
            xlabel('Czas');
            ylabel('Amplituda');
            title('Sygna³ zmodulowany');
            
            axis([1 obj.Time_m(end)-1 -1.5 1.5]);
            grid  on;
        end
        
        
         function obj = TransmissionChannel(obj, filename, ampNoise, phNoise)
            obj.ampNoise_m = ampNoise;
            obj.phNoise_m = phNoise;
             
             
            phasenoise = randn(length(obj.signal_m),1) * obj.phNoise_m;
            amplitudenoise =  randn(length(obj.signal_m),1) * obj.ampNoise_m;
            obj.rxpsk = obj.txpsk .* exp(2i*pi*phasenoise);
            obj.rxpsk = obj.rxpsk + amplitudenoise;

            t = 1/obj.sampleRate_m: 1/obj.sampleRate_m : 1;
            for ii = 1: 1: length(obj.rxpsk)
                t =  t + 1;
                obj.transmittedSignal_m = [obj.transmittedSignal_m cos(2*pi * t + angle(obj.rxpsk(ii))) .* exp(2i*pi*phasenoise(ii)) + amplitudenoise(ii)];
            end
            
            if ~strcmp(filename,'')
                SaveFileID = fopen(filename, 'w');
                fprintf(SaveFileID, '%i\n',obj.transmittedSignal_m);%zapis do pliku
                fclose(SaveFileID);
            end
        end
        %Funkcja rysuj¹ca sygna³ zmodulowany
        function PlotTransmissionChannel(obj, m, n, p) 
            subplot(m,n,p);
            plot(obj.Time_m,obj.transmittedSignal_m,'LineWidth',2);
            
            xlabel('Czas');
            ylabel('Amplituda');
            title('Sygna³ Zniekszta³cony');
            
            axis([1 obj.Time_m(end)-1 -1.5 1.5]);
            grid  on;
            
        end
        
        
        function obj = Demodulate(obj, filename)
            obj.recovpsk = pskdemod(obj.rxpsk,obj.variant_m);
            
            numerrs_psk = symerr(obj.signal_m,obj.recovpsk);
            obj.BER = numerrs_psk/length(obj.signal_m);
            if ~strcmp(filename,'')
                SaveFileID = fopen(filename, 'w');
                fprintf(SaveFileID, '%i\n',obj.transmittedSignal_m);%zapis do pliku
                fclose(SaveFileID);
            end
            
        end
        
        function PlotNPSKDemodulator(obj, m, n, p) 
            
            y=obj.recovpsk;
            subplot(m,n,p);
            stem(y);
            title('Bity odebrane');
        end
       
        function PlotNPSKnoise(obj) 
            scatterplot(obj.rxpsk);
            title('Sygna³ binarny odebrany');
        end
        
        function showBER(obj) 
            
            BER = obj.BER
        end
        
    end
    
end

