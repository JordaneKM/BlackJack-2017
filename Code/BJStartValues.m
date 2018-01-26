function Init = BJStartValues
%Copyright - Ishmael Leon, Scott Copely, Jordane McCalla, Christopher Reid
%Creates a GUI that allows the player to determine the initial values to be
%used in the game

[s,Fs]=audioread('jazz.wav'); 
% File Location - 'jazz.wav' ... Current folder
% Assigned to an array/matrix having only two elements called s & Fs
% Having that the output from audioread is a row matrix with only 2
% elements
player=audioplayer(s,Fs); 
    
global BJPLAYER
% clear BJPLAYER.hitorstand_intro;

%Initialize Default values

Init.NumHands = 0;
Init.Bankroll = 5000;
Init.BetUnit = 5;
Init.NumDecks = 1;
Init.GameSpeed = 50; %As a percentage
Init.PN = 'Fortis <3';


BoxSize = [530 180 260 340]; % dimensions of the box - [distance from left , distance from bottom. width, height]


%Initialize the box
color = [.4 .2 .4]; % Colour mixtures - red green blue - purple - "RGB TRIPLET"
% red = [ 1 0 0];
% blue = [0 0 1];
% green = [ 0 1 0];
% purple = [ 20 0 20 ];

handles.IntroBox = gcf; % Brings up a blank fig
%gcf - current figure handle .... graphical current figure
set(handles.IntroBox,'name','BlackJack Setup','menubar','none','numbertitle','off','color',color,'pos',BoxSize);



%Display the appropriate options and wait for the player to press Begin

handles.InitNumHandsTxt = uicontrol('style','text','string','Hands','fontsize',12,'pos',[50 BoxSize(4)-65 98 25],'backgroundcolor',color,'foregroundcolor','w','horiz','r');
handles.InitNumHandsBox = uicontrol('style','edit','string',num2str(Init.NumHands),'pos',[100 BoxSize(4)-80 50 18], 'horiz', 'c');
handles.Player = uicontrol('style','text','string','Player''s Name:','pos',[40 BoxSize(4)-40 120 25],'backgroundcolor',color,'foregroundcolor','w','horiz','r','fontsize',12);
handles.PlayerBox = uicontrol('style','edit','string',Init.PN,'pos',[165 BoxSize(4)-35 80 18],'horiz','c','fontsize',12);

handles.InitBankrollOpTxt = uicontrol('style','text','string','Bankroll Options:','fontsize',12,'pos',[69 BoxSize(4)-110 200 20],'backgroundcolor',color,'foregroundcolor','w','horiz','l');
handles.InitBankrollTxt = uicontrol('style','text','string','Bankroll:','fontsize',8,'pos',[25 BoxSize(4)-130 98 15],'backgroundcolor',color,'foregroundcolor','w','horiz','r');
handles.InitBankrollBox = uicontrol('style','edit','string',num2str(Init.Bankroll),'pos',[130 BoxSize(4)-130 50 18], 'horiz', 'c');
handles.InitBetUnitTxt = uicontrol('style','text','string','Bet Unit:','fontsize',8,'pos',[25 BoxSize(4)-150 98 15],'backgroundcolor',color,'foregroundcolor','w','horiz','r');
handles.InitBetUnitBox = uicontrol('style','edit','string',num2str(Init.BetUnit),'pos',[130 BoxSize(4)-150 50 18],'horiz','c');

handles.InitCardOpTxt = uicontrol('style','text','string','Card Options:','fontsize',12,'pos',[69 BoxSize(4)-180 200 20],'background',color,'foregroundcolor','w','horiz','l');
handles.InitNumDecksTxt = uicontrol('style','text','string','Number of Decks:','fontsize',8','pos',[63 BoxSize(4)-200 98 15],'backgroundcolor',color,'foregroundcolor','w','horiz','r');
handles.InitNumDecksBox = uicontrol('style','edit','string',num2str(Init.NumDecks),'pos',[161 BoxSize(4)-200 50 18],'horiz','c');

play(player);

handles.InitGamePlayOpTxt = uicontrol('style','text','string','Gameplay Options:','fontsize',12,'pos',[70 BoxSize(4)-230 200 20],'backgroundcolor',color,'horiz','l','foregroundcolor','w');
handles.InitGameSpeedTxt = uicontrol('style','text','string','Game Speed:','fontsize',8','pos',[43 BoxSize(4)-250 98 15],'backgroundcolor',color,'horiz','r','foregroundcolor','w');
handles.InitGameSpeedBox = uicontrol('style','edit','string',num2str(Init.GameSpeed),'pos',[142 BoxSize(4)-250 30 18],'horiz','c');
handles.InitGameSpeedTxt2 = uicontrol('style','text','string','%','fontsize',8','pos',[171.9 BoxSize(4)-250 20 15],'backgroundcolor',color,'foregroundcolor','w');

% handles.Help = uicontrol('style','pushbutton','string','Help','fontsize',12,'pos',[50 45 160 20],'callback','BJActionSelectIntro(1);');
handles.InitBegin = uicontrol('style','pushbutton','string','Start','fontsize',12,'pos',[50 30 160 20],'callback','uiresume;');


uiwait;
%Temporarily waits/pauses the game for an input from the user
stop(player); % Stops music on exiting

handles.IntroBox2 = figure; % Brings up a blank fig for the second title screen with only blackjack image
set(handles.IntroBox2,'name','','menubar','none','numbertitle','off','color',color);
imshow('blackjack.jpg');

robot = java.awt.Robot; 
robot.keyPress(java.awt.event.KeyEvent.VK_ALT);      %// send ALT
robot.keyPress(java.awt.event.KeyEvent.VK_SPACE);    %// send SPACE
robot.keyRelease(java.awt.event.KeyEvent.VK_SPACE);  %// release SPACE
robot.keyRelease(java.awt.event.KeyEvent.VK_ALT);    %// release ALT
robot.keyPress(java.awt.event.KeyEvent.VK_X);        %// send X
robot.keyRelease(java.awt.event.KeyEvent.VK_X);      %// release X

pause(5);



% When begin is pressed, 
%      save the values to the appropriate place, 
%          while checking to make sure all inputs are numeric
if ~isempty(get(handles.PlayerBox,'string'))
    Init.PN = get(handles.PlayerBox,'string');
end

if ~isempty(str2double(get(handles.InitNumHandsBox,'string'))) % convert to number first, checking if it is empty before assigning
    Init.NumHands = str2double(get(handles.InitNumHandsBox,'string')); % assign to our declared variable for future use
end
if str2double(get(handles.InitNumHandsBox,'string')) > 6
    Init.Numhands = 6;
end
if str2double(get(handles.InitNumHandsBox,'string')) <=0
    Init.Numhands = 1;
end

if ~isempty(str2double(get(handles.InitBankrollBox,'string')))
    Init.Bankroll = str2double(get(handles.InitBankrollBox,'string'));
end    
if str2double(get(handles.InitBankrollBox,'string')) < 1000
    Init.Bankroll = 1000; % Ensures the proper starting bankroll
end

if ~isempty(str2double(get(handles.InitBetUnitBox,'string')))
    Init.BetUnit = str2double(get(handles.InitBetUnitBox,'string'));
end 
if str2double(get(handles.InitBetUnitBox,'string')) <= 0 
    Init.BetUnit = 25;
end
if str2double(get(handles.InitBetUnitBox,'string')) > 500  % Ensures the proper starting betting unit
    Init.BetUnit = 500;
end


if ~isempty(str2double(get(handles.InitNumDecksBox,'string')))
    Init.NumDecks = str2double(get(handles.InitNumDecksBox,'string'));
end
if  str2double(get(handles.InitNumDecksBox,'string')) <=0 
    Init.NumDecks = 1;
end
if str2double(get(handles.InitNumDecksBox,'string')) > 6
    Init.NumDecks = 6;
end


if ~isempty(str2double(get(handles.InitGameSpeedBox,'string')))
    Init.GameSpeed = str2double(get(handles.InitGameSpeedBox,'string'));
end
if str2double(get(handles.InitGameSpeedBox,'string')) <=0 
    Init.GameSpeed = 50; % Ensures proper game speed
end
if str2double(get(handles.InitGameSpeedBox,'string')) > 100
    Init.GameSpeed = 50;
end

close all