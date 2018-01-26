function [handles] = BJBoardCreation(Bet)

%output from BJBoardCreation --- handles !
% Creates the BlackJack Playing Board

global BANKROLL;
global BJBOARD;
global BJPLAYER;
global BJDEALER;
% Bet = 50;
Creator = 'I-J-S-C';
Date = '1/12/17';

close all;

% What does BJBoardCreation outputs ??
% It outputs handles !!
% Therefore anything with handles.Keisha ... we have access to ! .. Thus ..
% We have access to the gui !!!

    


handles.Main = gcf; % gcf - Get current figure
% BJBOARD.pos=get(gcf,'pos');
BJBOARD.scr=get(0,'screensize');
set(handles.Main,'name','BlackJack','menubar','none','numbertitle','off','pos',[BJBOARD.scr(3)*0.25 60 810 640] );

% create an axes that spans the whole gui
handles.Main2 = axes('unit', 'normalized', 'position',[0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('Back.jpg'); 
imagesc(bg);
% prevent plotting over the background and turn the axis off
set(handles.Main2,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(handles.Main2, 'bottom'); 

 
handles.Author = uicontrol('style','text','string',strcat('Created By:',' ',Creator),'pos',[680 95 115 15],'fontsize',8, 'backgroundcolor', [0 1 0]);
handles.Date = uicontrol('style','text','string',Date,'pos',[715 80 50 15],'fontsize',8,'backgroundcolor', [0 1 0]);
handles.DealerText = uicontrol('style','text','string','Dealer','pos',[350 600 90 25],'fontsize',15,'horiz','c', 'backgroundcolor', [0 1 0]);
handles.YouText = uicontrol('style','text','string','You','pos',[352 305 90 25],'fontsize',15,'horiz','c', 'backgroundcolor', [0 1 0]);
handles.BankTxt = uicontrol('style','text','string','Bank','pos',[ 700 600 90 25],'fontsize',15,'horiz','l','horiz','c', 'backgroundcolor', [0 1 0]);
handles.BankrollTxt = uicontrol('style','text','string',['$' num2str(BANKROLL.Starting)],'pos',[718 575 60 20],'fontsize',15,'horiz','c', 'backgroundcolor', [0 1 0]);
% handles.HelpButton = uicontrol('style','pushbutton','string','Help','Position', [700 510 90 25],'fontsize',15,'visible','on','Callback','BJActionSelect(1);', 'backgroundcolor', 'w');

chip25 = imread('chip25.png');
chip50 = imread('chip50.png');
chip100 = imread('chip100.png');

handles.BetText = uicontrol('style','text','string',Bet,'pos',[55 150 90 25],'fontsize',15,'horiz','c','backgroundcolor',[0 1 0]); 
handles.BetButton25 = uicontrol('style','pushbutton','Position',[30 480 150 150],'CData',chip25,'visible','on','Callback','BJActionSelect(2);');
handles.BetButton50 = uicontrol('style','pushbutton','Position',[30 330 152 148],'CData',chip50,'visible','on','Callback','BJActionSelect(3);');
handles.BetButton100 = uicontrol('style','pushbutton','Position',[30 180 147 150], 'CData',chip100,'visible','on','Callback','BJActionSelect(4);');


handles.group = uibuttongroup('visible','on','Position',[0 0 1 .1],'SelectionChangedFcn',@bselection);
handles.HitButton = uicontrol('style','pushbutton','string','Hit','Position', [170 7 180 50],'fontsize',15,'visible','on','Callback','BJActionSelect(5);','backgroundcolor','w'); 
handles.DealButton = uicontrol('style','pushbutton','string','Deal','Position',[360 7 180 50],'fontsize',15,'visible','on','Callback','uiresume(gcf)','backgroundcolor','w');    %Deal Pushbutton
handles.StandButton = uicontrol('style','pushbutton','string','Stand','Position', [10 7 150 50],'fontsize',15,'visible','on','Callback','BJActionSelect(6);','backgroundcolor','w');
handles.DoubleButton = uicontrol('style','pushbutton','string','Double','Position', [550 7 150 50],'fontsize',15,'visible','on','Callback','BJActionSelect(7);','backgroundcolor','w');
handles.SplitButton = uicontrol('style','pushbutton','string','Split','Position', [710 7 90 50],'fontsize',15,'visible','on','Callback','BJActionSelect(8);','backgroundcolor','w');
handles.QuitButton = uicontrol('style','pushbutton','string','Quit','Position',[700 430 90 25],'fontsize',15,'horiz','c','visible','on','backgroundcolor','w','UserData',1,'CallBack','QuitGame');    %Quit Pushbutton
handles.HandsLeftTxt = uicontrol('style','text','string','Hands Left:','pos',[650 380 90 25],'backgroundcolor','w','horiz','c','fontsize',15);
handles.HandsLeftBox = uicontrol('style','text','string',num2str(BANKROLL.HandsLeft),'pos',[760 380 40 25],'Callback','HandsLeft(handles)','fontsize',15);
handles.Statistics = uicontrol('style','text','string','Statistics','pos',[700 310 90 25],'fontsize',15);
handles.HandsPlayed = uicontrol('style','text','string','Hands Played','pos',[610 270 130 25],'fontsize',11);
handles.HandsPlayedBox = uicontrol('style','text','string',num2str(BJPLAYER.HandsPlayed),'pos',[760 270 40 25],'horiz','c','fontsize',11);
handles.Wins = uicontrol('style','text','string','Wins','pos',[610 240 130 25],'fontsize',11);
handles.WinsBox = uicontrol('style','text','string',num2str(BJPLAYER.Wins),'pos',[760 240 40 25],'horiz','c','fontsize',11);
handles.Loses = uicontrol('style','text','string','Loses','pos',[610 210 130 25],'fontsize',11);
handles.LosesBox = uicontrol('style','text','string',num2str(BJPLAYER.Loses),'pos',[760 210 40 25],'horiz','c','fontsize',11);
handles.Pushes = uicontrol('style','text','string','Pushes','pos',[610 180 130 25],'fontsize',11);
handles.PushesBox = uicontrol('style','text','string',num2str(BJPLAYER.Pushes),'pos',[760 180 40 25],'horiz','c','fontsize',11);
handles.WinningPercent = uicontrol('style','text','string','Winning %','pos',[610 150 130 25],'fontsize',11);
handles.WinningPercentBox = uicontrol('style','text','string',[ num2str(BJPLAYER.Percent) '%' ],'pos',[760 150 40 25],'horiz','c','fontsize',11);




handles.InsuranceButton = uicontrol('style','pushbutton','string','Insurance','foregroundcolor','b','backgroundcolor','w','Position',[452 295 92 50],'fontsize',15,'visible','off','Callback','BJActionSelect(9);');
handles.InsuranceBox = uicontrol('style','text','string',num2str(BANKROLL.InsuranceBet),'foregroundcolor','b','backgroundcolor','w','Position',[452 265 90 25],'fontsize',15,'horiz','c','visible','off');
handles.Reset = uicontrol('style','pushbutton','string','Reset','foregroundcolor','b','backgroundcolor','w','Position',[452 345 92 25],'fontsize',15,'horiz','c','visible','off','Callback','BJActionSelect(12);');
 
handles.StatusTxt = uicontrol('style','text','string',BJPLAYER.Status,'pos',[700 470 90 25],'fontsize',15,'horiz','c','backgroundcolor',[0 1 0],'visible','on');
handles.PlayerName = uicontrol('style','text','string',BJPLAYER.PN,'pos',[700 540 90 25],'fontsize',15,'horiz','c','backgroundcolor',[ 0 1 0],'visible','on');
handles.PlayerTotalTxt = uicontrol('style','text','string',num2str(BJPLAYER.Total),'pos',[352 270 90 25],'fontsize',15,'horiz','c','backgroundcolor',[0 1 0]);   %Player's total
handles.DealerTotalTxt = uicontrol('style','text','string',num2str(BJDEALER.Total),'pos',[350 565 90 25],'fontsize',15,'horiz','c','backgroundcolor',[0 1 0]);


handles.ReplayButton = uicontrol('style','pushbutton','string','Replay Bet','Position',[21 80 75 60],'fontsize',10,'horiz','r','backgroundcolor','w','Callback','BJActionSelect(10);');    %Replay Bet Pushbutton
handles.ResetButton = uicontrol('style','pushbutton','string','Reset Bet','pos',[106 80 75 60],'fontsize',10,'horiz','r','backgroundcolor','w','Callback','BJActionSelect(11);');    %Reset Bet Pushbutton

handles.PlayerBJTxt = uicontrol('style','text','string','You have BlackJack!','pos',[420 215 190 45],'fontsize',15,'horiz','c','foregroundcolor','b','backgroundcolor',[0 1 0],'visible','off');
handles.DealerBJTxt = uicontrol('style','text','string','Dealer has BlackJack!','pos',[440 510 205 45],'fontsize',15,'horiz','c','foregroundcolor','b','backgroundcolor',[0 1 0],'visible','off');
handles.BothBJTxt = uicontrol('style','text','string','Both players have BJ!','pos',[300 430 205 45],'fontsize',15,'horiz','c','foregroundcolor','b','backgroundcolor',[0 1 0],'visible','off');
handles.OutofMoneyTxt = uicontrol('style','text','string','You''re out of money!','pos',[300 335 205 45],'fontsize',15,'horiz','c','foregroundcolor','b','backgroundcolor',[0 1 0],'visible','off');
handles.NoDDMoneyTxt = uicontrol('style','text','string','Can''t Double Down!','pos',[300 335 205 45],'fontsize',15,'horiz','c','foregroundcolor','b','backgroundcolor',[0 1 0],'visible','off');
handles.ShuffleTxt = uicontrol('style','text','string','Shuffling...','pos',[300 335 205 45],'fontsize',15,'horiz','c','foregroundcolor','b','backgroundcolor',[0 1 0],'visible','off');
handles.ResultTxt = uicontrol('style','text','string','YOU WIN FORTIS!','pos',[300 335 205 45],'fontsize',15,'horiz','c','foregroundcolor','b','backgroundcolor',[0 1 0],'visible','off');
handles.PlayerTotalSplitTxt(1) = uicontrol('style','text','string','Your Total :','pos',[250 240 140 25],'fontsize',15,'horiz','c','foregroundcolor','b','backgroundcolor',[0 1 0],'visible','off');   %Player's total for hand 1 when splitting
handles.PlayerTotalSplitTxt(2) = uicontrol('style','text','string','Your Total :','pos',[430 240 140 25],'fontsize',15,'horiz','c','foregroundcolor','b','backgroundcolor',[0 1 0],'visible','off');   %Player's total for hand 2 when splitting


handles.BJPLAYER.Card_1 = uicontrol('style','pushbutton','visible','off');
handles.BJPLAYER.Card_2 = uicontrol('style','pushbutton','visible','off');
handles.BJPLAYER.Card_3 = uicontrol('style','pushbutton','visible','off');
handles.BJPLAYER.Card_4 = uicontrol('style','pushbutton','visible','off');
handles.BJPLAYER.Card_5 = uicontrol('style','pushbutton','visible','off');
handles.BJPLAYER.Card_6 = uicontrol('style','pushbutton','visible','off');
handles.BJPLAYER.Card_7 = uicontrol('style','pushbutton','visible','off');
handles.BJPLAYER.Card_8 = uicontrol('style','pushbutton','visible','off');
handles.BJPLAYER.Card_9 = uicontrol('style','pushbutton','visible','off');
handles.BJPLAYER.Card_10 = uicontrol('style','pushbutton','visible','off');
handles.BJPLAYER.Card_11 = uicontrol('style','pushbutton','visible','off');
handles.BJPLAYER.Card_12 = uicontrol('style','pushbutton','visible','off');


handles.BJDEALER.Card_1 = uicontrol('style','pushbutton','visible','off');
handles.BJDEALER.Card_2 = uicontrol('style','pushbutton','visible','off');
handles.BJDEALER.Card_3 = uicontrol('style','pushbutton','visible','off');
handles.BJDEALER.Card_4 = uicontrol('style','pushbutton','visible','off');
handles.BJDEALER.Card_5 = uicontrol('style','pushbutton','visible','off');
handles.BJDEALER.Card_6 = uicontrol('style','pushbutton','visible','off');
handles.BJDEALER.Card_7 = uicontrol('style','pushbutton','visible','off');

if ~BANKROLL.HandsLeft    %If there are no hands left, update on gui
    set(handles.HandsLeftBox,'string','');
end 

