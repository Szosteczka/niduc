classdef PSKDeMod
    properties
        Filename_m = 0;%nazwa pliku z danymi (sygna³ binarny)
        OutFilename_m = 0;%nazwa pliku wyjœciowego
        N=0;
        q=[];
        k=[];
        ModulatedSignal_m = [];
        Time_m = [];
    end
    
    methods
        %funkcja modulatora sygna³u PSK
        function obj = PSKDeMod(Filename, sampl_freq, OutFilename)
            obj.Filename_m = Filename;
            obj.OutFilename_m = OutFilename;
            
            DataFileID = fopen(obj.Filename_m, 'r');
            SignalData = fscanf(DataFileID, '%f');
            
            obj.N=(length(SignalData)/sampl_freq);
            
            for j=1:obj.N
                obj.q(j)=SignalData(sampl_freq*j);
                obj.ModulatedSignal_m = [obj.ModulatedSignal_m obj.q(j)];
                if (obj.q(j)<0)
                    obj.k(j)=1;
                else
                    obj.k(j)=0;
                end
            end
            
            SaveFileID = fopen(obj.OutFilename_m, 'w');
            fprintf(SaveFileID, '%i\n',obj.k);%zapis do pliku
            fclose(SaveFileID);
            
        end
            
     
        %Funkcja rysuj¹ca sygna³ zmodulowany
        function PlotPSKDeMod(obj, m, n, p) 
            subplot(m,n,p);
            stem(obj.k);
            xlabel('Czas');
            ylabel('Amplituda');
            title('Sygna³ odkodowany')
            
            %axis([0 obj.Time_m(end) -1.5 1.5]);
            grid  on;
        end
        
        function PlotPSKDeMod1(obj)
            scatterplot(obj.ModulatedSignal_m);
            xlabel('Czas');
            ylabel('Amplituda');
            title('wykres BPSK');
            
            %axis([0 obj.Time_m(end) -1.5 1.5]);
            grid  on;
        end
    end
end

