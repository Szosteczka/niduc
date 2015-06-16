classdef BCHCodings
    properties
        mNumber_m = 0;
        wordLength_m = 0;
        signal_m = 0;
        newSignal_m = 0;
    end
    
    methods
        function obj = BCHCodings(mNumber, wordLength)
            obj.mNumber_m = mNumber;
            obj.wordLength_m = wordLength;
        end
        
%         function BCHsplit(obj, signal)
%             obj.signal_m = signal;
%             sections = length(obj.signal_m)/obj.wordLength_m;
%             obj.newSignal_m = reshape(obj.signal_m, sections, obj.wordLength_m);
%         end
        
        function BCHEncode(obj, fileName) 
            m = obj.mNumber_m;
            n = 2^m-1;
            k = obj.wordLength_m;
            
            DataFileID = fopen(fileName, 'r');
            obj.signal_m = fscanf(DataFileID, '%i');
            
            msg = gf(transpose(obj.signal_m));
            [genpoly,t] = bchgenpoly(n,k);
            code = bchenc(msg,n,k);
            
            code_new = double(code.x);
            fileID = fopen('SygnalZakodowany.txt', 'w');
            fprintf(fileID, '%i\n',code_new);%zapis do pliku
            fclose(fileID);
        end
        
        function BCHDecode(obj, openFileID, saveFileID)
            m = obj.mNumber_m;
            n = 2^m-1;
            k = obj.wordLength_m;
            
            ofid = fopen(openFileID, 'r');
            signal = gf(transpose(fscanf(ofid, '%i')));
            
            
            [newmsg,err,ccode] = bchdec(signal,n,k);
            
            sfid = fopen(saveFileID, 'w');
            sfid2 = fopen('wiadomoscOdczytana.txt', 'w');
            ccode_new = double(ccode.x);
            newmsg_new = double(newmsg.x);
            fprintf(sfid, '%i\n', ccode_new);
            fprintf(sfid2, '%i\n', newmsg_new);
        end
    end
end
