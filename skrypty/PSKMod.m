classdef PSKMod
    properties
        Filename_m = 0;%nazwa pliku z danymi (sygna³ binarny)
        OutFilename_m = 0;%nazwa pliku wyjœciowego
        Phase1_m = 0;%Faza dla bitu 0
        Phase2_m = pi;%Faza dla bitu 1
        
        Amplitude_m = 0;%Amplituda
        F_m = 0;%Czêstotliwoœæ
        
        Sr_m = 0;%czêstotliwoœæ próbkowania
        
        ModulatedSignal_m = [];
        Time_m = [];
    end
    
    methods
        %funkcja modulatora sygna³u PSK
        function obj = PSKMod(Filename, Amplitude, Freq, SampRate, OutFilename)
            
            obj.Filename_m = Filename;
            obj.OutFilename_m = OutFilename;
            obj.Amplitude_m = Amplitude;
            obj.F_m = Freq;
            obj.Sr_m = SampRate;
            
            DataFileID = fopen(obj.Filename_m, 'r');
            SignalData = fscanf(DataFileID, '%i');
            
            
            t = 0: 1/obj.Sr_m : 1;%Czas dla jednego bitu 
            
            %pêtla, w której dochodzi do modulacji sygna³u fali noœnej
            %przez 'sygna³ binarny', czyli dane pobrane z pliku, wczeœniej
            %wygenerowane przez BinSig.
            for ii = 1: 1: length(SignalData)
                obj.ModulatedSignal_m = [obj.ModulatedSignal_m (SignalData(ii)==0) * obj.Amplitude_m * cos(2*pi*obj.F_m*t + obj.Phase1_m)+ ...
                    (SignalData(ii)==1)*obj.Amplitude_m*cos(2*pi*obj.F_m*t + obj.Phase2_m)];
                obj.Time_m = [obj.Time_m t];
                t =  t + 1;
            end
            
            SaveFileID = fopen(obj.OutFilename_m, 'w');
            fprintf(SaveFileID, '%i\n',obj.ModulatedSignal_m);%zapis do pliku
            fclose(SaveFileID);
            
        end
        %Funkcja rysuj¹ca sygna³ zmodulowany
        function PlotPSKMod(obj, m, n, p) 
            
            subplot(m,n,p);
            plot(obj.Time_m,obj.ModulatedSignal_m,'LineWidth',2);
            
            xlabel('Czas');
            ylabel('Amplituda');
            title('Sygna³ zmodulowany');
            
            axis([0 obj.Time_m(end) -1.5 1.5]);
            grid  on;
            
        end
    end
    
end

