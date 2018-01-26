function [] = Help()

       f = figure('menu','none','toolbar','none','numbertitle','off', 'name','BLACKJACK');
       fid = fopen('Help.txt');
       ph = uipanel(f,'Units','normalized','position',[0 0 1 1],'title',...
               'Blackjack Help');
       lbh = uicontrol(ph,'style','listbox','Units','normalized','position',...
              [0 0 1 1],'FontSize',9);
       indic = 1;
           while 1
               tline = fgetl(fid);
               if ~ischar(tline) 
                    break
               end
             strings{indic}=tline; 
             indic = indic + 1;
                
           end
                
        fclose(fid);
        set(lbh,'string',strings);
        set(lbh,'Value',1);
        set(lbh,'Selected','on');
          