classdef TransmissionChannel
    properties
        Filename_m = 0;%nazwa pliku z danymi (sygna³ binarny)
        OutFilename_m = 0;%nazwa pliku wyjœciowego
        
        Sr_m = 0;%czêstotliwoœæ próbkowania
        noise = 0;
        ModulatedSignal_m = [];
        Time_m = [];
    end
    
    methods
        %funkcja modulatora sygna³u PSK
        function obj = TransmissionChannel(Filename, SampRate, OutFilename, noise)
            
            obj.Filename_m = Filename;
            obj.OutFilename_m = OutFilename;
            obj.Sr_m = SampRate;
            obj.noise = noise;
            DataFileID = fopen(obj.Filename_m, 'r');
            SignalData = fscanf(DataFileID, '%f');
            %pêtla, w której dochodzi do modulacji sygna³u fali noœnej
            %przez 'sygna³ binarny', czyli dane pobrane z pliku, wczeœniej
            %wygenerowane przez BinSig.
            t = 0: 1/obj.Sr_m : length(SignalData)/obj.Sr_m;%Czas dla jednego bitu 
            for ii = 1: 1: length(SignalData)
                obj.ModulatedSignal_m = [obj.ModulatedSignal_m SignalData(ii)+((rand-0.5)*(noise/10))];
                obj.Time_m = [obj.Time_m t(ii)];
            end
            SaveFileID = fopen(obj.OutFilename_m, 'w');
            fprintf(SaveFileID, '%i\n',obj.ModulatedSignal_m);%zapis do pliku
            fclose(SaveFileID);
        end
        %Funkcja rysuj¹ca sygna³ zmodulowany
        function PlotTransmissionChannel(obj, m, n, p) 
            subplot(m,n,p);
            plot(obj.Time_m,obj.ModulatedSignal_m,'LineWidth',2);
            
            xlabel('Czas');
            ylabel('Amplituda');
            title('Sygna³ Zniekszta³cony');
            
            axis([0 obj.Time_m(end) -1.5 1.5]);
            grid  on;
            
        end
    end
end

