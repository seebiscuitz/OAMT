function [ TL, returncode, coordsmatrix ] = runpropmodels(currsesspref, surfobject, signalsources )
%RUNPROPMODELS Summary of this function goes here
%   Detailed explanation goes here
    global filepath
    global envclass
    global profmatrix
    switch currsesspref.propagationmodel
        case 'EnergyFlux'
            % - run energy flux model -
            TL=energyfluxmodel(surfobject,signalsources); %TL returned as efluxarray class
            % - end -
            % - save to session folder -
            mkdir([filepath '\data\EnergyFlux']);
            for i=1:length(TL)
                mkdir([filepath '\data\EnergyFlux\' TL(i).sourcelabel]);
               for j=1:length(TL(i).tlarray)
                  filename=sprintf('%s_%d',TL(i).sourcelabel,TL(i).tlarray(j).frequency);
                  var=TL(i).tlarray(j);
                  save([filepath '\data\EnergyFlux\' TL(i).sourcelabel '\' filename '.mat'],'var'); 
               end
            end
            save([filepath '\data\EnergyFlux\TL.mat'],'TL');
            % - end -            
            returncode='EnergyFlux';
            coordsmatrix=[];
            msgbox('Done')
        case 'RAM'
            % - create profmatrix -
            if ~(length(signalsources)==length(profmatrix))
                for i=1:length(signalsources)
                    profmatrix(i)=profclass;
                end
            end
            % - end -
            % - run RAM model -
            [ramsrcarray,coordsmatrix]=RAMmodel(surfobject, signalsources, envclass, profmatrix);
            % - end -
            % - save to session folder -
            mkdir([filepath '\data\RAM']);
            for i=1:length(ramsrcarrray)
            mkdir([filepath '\data\RAM\' ramsrcarrray(i).sourcelabel]);
               for j=1:length(ramsrcarrray(i).tlarray)
                  filename=sprintf('%s_%s',ramsrcarrray(i).sourcelabel,ramsrcarrray(i).tlarray(j).frequency);
                  var=ramsrcarrray(i).tlarray(j);
                  save([filepath '\data\RAM\' ramsrcarrray(i).sourcelabel '\' filename '.mat'],'var'); 
               end
            end
            save([filepath '\data\RAM\TL.mat'],'ramsrcarray');
            % - end -
            TL=ramsrcarray;
            returncode='RAM';
            msgbox('Done')
        otherwise
            TL=0;
    end
end

