classdef  BinSig
    %klasa sygna�u binarnego generowana losowo
    %takie rozwi�zanie wydaje mi si� najwygodniejsze
    properties
        matX_m = 1; %liczba kolumn macierzy (1, poniewa� tworzymy wektor) 
        elements_m = 0; %liczba element�w, jeszcze nie wiemy ile ich b�dzie
        fileID_m = 'signal.txt'; %domy�lny identyfikator pliku z flag� 'w'
        signal_m = 0;
    end
    methods
        %konstruktor sygna�u
        function obj = BinSig(elements, filename)
            obj.elements_m = elements; %liczba element�w ustawiana przez argument
            obj.fileID_m = fopen(filename, 'w');
            obj.signal_m = randi(2,obj.elements_m,obj.matX_m)-1;
            %powy�sza funkcja randi generuje losowy int z przedzia�u
            %tu przedzia� [1,2], i wype�nia nimi odpowiedni� macierz.
            %Poniewa� chc� sygna� binarny, od wygenerowanych cyfr 1 i 2
            %odejmuj� ostatecznie 1.
            
            fprintf(obj.fileID_m, '%i\n',obj.signal_m);%zapis do pliku
            fclose(obj.fileID_m);
        end
        %funkcja rysuj�ca wykres sygna�u binarnego, pobiera obiekt
        %niniejszej klasy jako parametr
        function PlotBinSig(obj,m,n,p)
            y=obj.signal_m;
            y=y(:);
            figure;
            y=[y';y'];
            y=y(:);
            x=1:numel(y)/2;
            x=[x;x];
            x=x(:);
            x(1)=[];
            y(end)=[];
            subplot(m,n,p);
            plot(x,y);
            xlim([x(1) x(end)]);
            title('Sygna� binarny');
        end
    end
end