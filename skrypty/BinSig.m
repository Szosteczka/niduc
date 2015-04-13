classdef  BinSig
    %klasa sygna³u binarnego generowana losowo
    %takie rozwi¹zanie wydaje mi siê najwygodniejsze
    properties
        matX_m = 1; %liczba kolumn macierzy (1, poniewa¿ tworzymy wektor) 
        elements_m = 0; %liczba elementów, jeszcze nie wiemy ile ich bêdzie
        fileID_m = 'signal.txt'; %domyœlny identyfikator pliku z flag¹ 'w'
        signal_m = 0;
    end
    methods
        %konstruktor sygna³u
        function obj = BinSig(elements, filename)
            obj.elements_m = elements; %liczba elementów ustawiana przez argument
            obj.fileID_m = fopen(filename, 'w');
            obj.signal_m = randi(2,obj.elements_m,obj.matX_m)-1;
            %powy¿sza funkcja randi generuje losowy int z przedzia³u
            %tu przedzia³ [1,2], i wype³nia nimi odpowiedni¹ macierz.
            %Poniewa¿ chcê sygna³ binarny, od wygenerowanych cyfr 1 i 2
            %odejmujê ostatecznie 1.
            
            fprintf(obj.fileID_m, '%i\n',obj.signal_m);%zapis do pliku
            fclose(obj.fileID_m);
        end
    end
end