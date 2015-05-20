classdef NPSK
    properties
        variant_m = 2;
        signal_m = 0;
        ampNoise_m = 0;
        phNoise_m = 0;
        filename_m = 0;
        modulatedSignal_m = 0;
    end
    methods
        function obj = NPSK(filename, variant, ampNoise, phNoise)
            
            obj.filename_m = filename;
            obj.variant_m = variant;
            obj.ampNoise_m = ampNoise;
            obj.phNoise_m = phNoise;
            
            fid = fopen(filename, 'r');
            obj.signal_m = fscanf(fid, '%i');

            
            data = obj.signal_m;
            hModulator = comm.PSKModulator(obj.variant_m, 'BitInput',true);
            hModulator.PhaseOffset = pi/4;
            modData = step(hModulator, data);
            
            hAWGN = comm.AWGNChannel('EbNo',ampNoise,'BitsPerSymbol',3);
            
            channelOutput = step(hAWGN,modData);
            scatterplot(channelOutput)

        end
    end
end