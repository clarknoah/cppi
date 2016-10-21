classdef ppiAnalyzer
    %PPIANALYZER is a class that accepts several values (including SPM)
    %   in order to do basic correlation analysis of the seed vs roi
    properties
        SPM
        roi_data
        peak_voxel
        norm
        corr
        
    end
    
    methods
        function r = autoParse(obj,modifier)
            seqPeak = [];
            seqRoi = [];
            ranPeak = [];
            ranRoi = [];
        for type = 1:2
            for x = 1:length(obj.SPM.Sess.U(type).ons)
                 onset = obj.SPM.Sess.U(type).ons(x);
                 duration = obj.SPM.Sess.U(type).dur(x)+onset-1+modifier;
                 if (duration)>241
                     duration = 241;
                 end
                disp(['Onset: ' num2str(onset)]);
                disp(['Duration: ' num2str(duration)]);
                for active = onset:duration
                    if strcmp(obj.SPM.Sess.U(type).name,'Random')
                        ranPeak = [ranPeak;obj.peak_voxel(active,:)];
                        ranRoi = [ranRoi;obj.roi_data(active,:)];
                    elseif strcmp(obj.SPM.Sess.U(type).name, 'Sequence')
                        seqPeak = [seqPeak;obj.peak_voxel(active,:)];
                        seqRoi = [seqRoi;obj.roi_data(active,:)];
                    else
                    end
                end
            end
        end 
          r = struct('seqPeak', seqPeak, ...
                     'ranPeak',ranPeak, ...
                     'seqRoi',seqRoi, ...
                     'ranRoi',ranRoi);
        end
        function r = standardParse(obj,up,down, start)
        %
        %
        % 
          mode1peak = [];
          mode2roi = [];
          mode2peak = [];
          mode1roi = [];
          n = (start);
          while n < length(obj.SPM.xX.X(:,1))
               if (n+(up-1)) > length(obj.SPM.xX.X(:,1))
                loopEnd = length(obj.SPM.xX.X(:,1));
               else
                    loopEnd = (n+(up-1));
                end
            for active = n:loopEnd
                if obj.SPM.xX.X((n+floor((up/2))),1) > obj.SPM.xX.X((n+floor((up/2))),2)
                    mode1peak = [mode1peak;obj.peak_voxel(active,:)];
                    mode1roi =  [mode1roi;obj.roi_data(active,:)];
                elseif obj.SPM.xX.X((n+floor((up/2))),1) < obj.SPM.xX.X((n+floor((up/2))),2)
                    mode2peak = [mode2peak; obj.peak_voxel(active,:)];
                    mode2roi = [mode2roi; obj.roi_data(active,:)];
                else
                end
            end
         
          n = n + (up+down);
          disp('This is n');
          disp(n);
          
          end
          r = struct('mode1peak',mode1peak,'mode2peak',mode2peak, 'mode1roi',mode1roi,'mode2roi',mode2roi);
      end
      
   
      function r = generateDifferences(obj, peak, voi)
            %Peak Voxel Correlation Function
            %   This function accepts the time series for the peak voxel
            %   and a voxel of interest, and determines how different
            %   there activity is. 

            r = [];
            for n = 1:(size(peak,1)-1)
                r(n,1) = peak(n+1) - peak(n);  
                r(n,2) = voi(n+1) - voi(n);
            end  
      end
      
      function r = generatePosNegDiff (obj, peak, voi)
            %Peak Voxel Correlation Function
            %   This function accepts the time series for the peak voxel
            %   and a voxel of interest, and determines how different
            %   there activity is, only accounting for positive, negative
            % and no changes.

            r = [];
            for n = 1:(size(peak,1)-1)
                disp(n);
                peakDif = peak(n+1) - peak(n); 
                if peakDif > 0
                    peakDif = 1;
                elseif peakDif == 0
                    peakDif = 0;
                elseif peakDif < 0
                    peakDif = -1;
                else
                end
                r(n,1) = peakDif;
                
                voiDif = voi(n+1) - voi(n);
                if voiDif > 0
                    voiDif = 1;
                elseif voiDif == 0
                    voiDif = 0;
                elseif voiDif < 0
                    voiDif = -1;
                else
                end
                 r(n,2) = voiDif;
            end     
      end
      
      function r = generateCorrelation(obj,diffArray)
          r = corrcoef(diffArray);
          r = r(2,1);
      end
      
      function r = correlationArray(obj,cor,ranRoi,seqRoi,ranPeak,seqPeak)
       %Assume that the data has pause times removed
       %This functions task is to take the set of random
       %and sequence data for the peak and roi voxels
       %and output an x, y array with x being the correlation
       %coefficient for mode 1, and y being a correlation
       %coefficient for mode 2.
       r = [];
       %tarting out pauses remove, so I have 4 arrays
       
       %create a difference array for each peak and roi
       random = struct();
       sequence = struct();
       %generateDifferences(peak, voi)
       voxelLength = size(ranRoi);
       for x = 1:voxelLength(2)
           if cor == 1
            random(x).diff = obj.generatePosNegDiff(ranRoi(:,x),ranPeak);
           else
            random(x).diff = obj.generateDifferences(ranRoi(:,x),ranPeak);
           end
           r(x,1) = obj.generateCorrelation(random(x).diff);
           random(x).corr = r(x,1);
       end
       for x = 1:voxelLength(2)
           if cor == 1
            sequence(x).diff = obj.generatePosNegDiff(seqRoi(:,x),seqPeak);
           else
           	sequence(x).diff = obj.generateDifferences(seqRoi(:,x),seqPeak);
           end
           %sequence(x).diff = obj.generateDifferences(seqRoi(:,x),sequencepeak);
           r(x,2) = obj.generateCorrelation(sequence(x).diff);
           sequence(x).corr = r(x,2);
       end
       r = struct('correlations',r,'random',random,'sequence',sequence);
      end
      
      
      function obj = ppiAnalyzer(SPM,roi_data,peak_voxel,pause)
           obj.SPM = SPM;
           obj.roi_data = roi_data;
           obj.peak_voxel = peak_voxel;
           obj.norm = obj.autoParse(pause);
           obj.corr = obj.correlationArray(0,obj.norm.ranRoi, ...
               obj.norm.seqRoi,obj.norm.ranPeak,obj.norm.seqPeak)
       end
    end
    
end

