classdef TransmissionChannel
    properties
        Filename_m = 0;%nazwa pliku z danymi (sygna� binarny)
        OutFilename_m = 0;%nazwa pliku wyj�ciowego
        
        Sr_m = 0;%cz�stotliwo�� pr�bkowania
        noise = 0;
        ModulatedSignal_m = [];
        Time_m = [];
    end
    
    methods
        %funkcja modulatora sygna�u PSK
        function obj = TransmissionChannel(Filename, SampRate, OutFilename, noise)
            
            obj.Filename_m = Filename;
            obj.OutFilename_m = OutFilename;
            obj.Sr_m = SampRate;
            obj.noise = noise;
            DataFileID = fopen(obj.Filename_m, 'r');
            SignalData = fscanf(DataFileID, '%f');
            %p�tla, w kt�rej dochodzi do modulacji sygna�u fali no�nej
            %przez 'sygna� binarny', czyli dane pobrane z pliku, wcze�niej
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
        %Funkcja rysuj�ca sygna� zmodulowany
        function PlotTransmissionChannel(obj, m, n, p) 
            subplot(m,n,p);
            plot(obj.Time_m,obj.ModulatedSignal_m,'LineWidth',2);
            
            xlabel('Czas');
            ylabel('Amplituda');
            title('Sygna� Zniekszta�cony');
            
            axis([0 obj.Time_m(end) -1.5 1.5]);
            grid  on;
            
        end
    end
end

