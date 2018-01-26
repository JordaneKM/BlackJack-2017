function [handlegot] = BJDealCard(recipient,handles,facedown,Split)


% Take into four parameters (inputs) !
% Recipient : - Dealer / Player 
% Handles : - Handles in Blackjack.m
% facedown - For the dealer !!
% if facedown = 1 ... get facedown card ....
% if facedown = 0 ... no facedown card ...

% the fourth capability of BJDealCard is to split !


global BJPLAYER % KEISHA INTERNATIONAL !
global BJDEALER % KEISHA INTERNATIONAL !
global CARDS % KEISHA INTERNATIONAL !
global GENERAL % KEISHA INTERNATIONAL !
% handles = BJBoardCreation;
% BJPLAYER.handle_get = 0;
% recipient = 'player';

handlegot = 0; %initializes variables to zero
add = 0; % initializes variables to zero


if ~exist('facedown','var') || ~facedown 
    %if facedown variable does not exist/ real ... or if facedown == 0
    Rank = CARDS.Rank(CARDS.NextCard);
else 
    Rank = 0;
end

if BJPLAYER.Splits == 1
    add = 30;
end


switch recipient
    
    case 'player'
        if BJPLAYER.handle_get == 0
            % BJPLAYER.XIncrement = [ row matrix with two elements ]
            % [ 30 30 ]
            BJPLAYER.XIncrement(1) = 0;
            BJPLAYER.XIncrement(2) = 0;
            handlegot = handles.BJPLAYER.Card_1;
            BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
            BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
            BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
            Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
            set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(1)+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
            CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
            BJPLAYER.XIncrement(1) = BJPLAYER.XIncrement(1) + 30;
            BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
            BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
        elseif BJPLAYER.handle_get == 1
            set(handles.BJPLAYER.Card_2,'CData','','visible','off');
            set(handles.BJPLAYER.Card_3,'CData','','visible','off');
            handlegot = handles.BJPLAYER.Card_2;
            BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
            BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
            BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
            Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
            set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(1)+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
            CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
            BJPLAYER.XIncrement(1) = BJPLAYER.XIncrement(1) + 30;
            BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
            BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
        elseif BJPLAYER.handle_get == 2
            set(handles.BJPLAYER.Card_3,'CData','','visible','off');
            set(handles.BJPLAYER.Card_4,'CData','','visible','off');
            handlegot = handles.BJPLAYER.Card_3;
            BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
            BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
            BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
            Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
            if BJPLAYER.Splits == 0
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(1)+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
            else
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(30+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
            end
            CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
            BJPLAYER.XIncrement(1) = BJPLAYER.XIncrement(1) + 30;
            BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
            BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
        elseif BJPLAYER.handle_get == 3
            set(handles.BJPLAYER.Card_4,'CData','','visible','off');
            handlegot = handles.BJPLAYER.Card_4;
            BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
            BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
            BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
            Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
            if BJPLAYER.Splits == 0
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(1)+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
            else
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(2)+Split+30), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
            end
            CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
            if Split == 0
                BJPLAYER.XIncrement(1) = BJPLAYER.XIncrement(1) + 30;
            else
                BJPLAYER.XIncrement(2) = BJPLAYER.XIncrement(2) + 60;
            end 
            BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
            BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
        elseif BJPLAYER.handle_get == 4
                if BJPLAYER.CurrentHand == 1
%                     disp(BJPLAYER.XIncrement(1));
                    set(handles.BJPLAYER.Card_6,'CData','','visible','off');
                    set(handles.BJPLAYER.Card_5,'CData','','visible','off');
                    handlegot = handles.BJPLAYER.Card_5;
                    BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                    BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                    BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                    Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                    set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(1)-add+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                    CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                    BJPLAYER.XIncrement(1) = BJPLAYER.XIncrement(1) + 30;
                    BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                    BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
                elseif BJPLAYER.CurrentHand == 2
                    set(handles.BJPLAYER.Card_6,'CData','','visible','off');
                    set(handles.BJPLAYER.Card_5,'CData','','visible','off');
                    handlegot = handles.BJPLAYER.Card_5;
                    BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                    BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                    BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                    Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                    set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(2)+BJPLAYER.SPLITx), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                    CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                    BJPLAYER.XIncrement(2) = BJPLAYER.XIncrement(2) + 30;
                    BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                    BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
                end   
        elseif BJPLAYER.handle_get == 5
                if BJPLAYER.CurrentHand == 1
                    set(handles.BJPLAYER.Card_6,'CData','','visible','off');
                    handlegot = handles.BJPLAYER.Card_6;
                    BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                    BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                    BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                    Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                    set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(1)-add+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                    CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1;
                    BJPLAYER.XIncrement(1) = BJPLAYER.XIncrement(1) + 30;
                    BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                    BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
                elseif BJPLAYER.CurrentHand == 2
                    set(handles.BJPLAYER.Card_6,'CData','','visible','off');
                    handlegot = handles.BJPLAYER.Card_6;
                    BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                    BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                    BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                    Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                    set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(2)+BJPLAYER.SPLITx), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                    CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                    BJPLAYER.XIncrement(2) = BJPLAYER.XIncrement(2) + 30;
                    BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                    BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
                end
        elseif BJPLAYER.handle_get == 6
            if BJPLAYER.CurrentHand == 1
                set(handles.BJPLAYER.Card_7,'CData','','visible','off');
                handlegot = handles.BJPLAYER.Card_7;
                BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(1)-add+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                BJPLAYER.XIncrement(1) = BJPLAYER.XIncrement(1) + 30;
                BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
            elseif BJPLAYER.CurrentHand == 2
                set(handles.BJPLAYER.Card_7,'CData','','visible','off');
                handlegot = handles.BJPLAYER.Card_7;
                BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(2)+BJPLAYER.SPLITx), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                BJPLAYER.XIncrement(2) = BJPLAYER.XIncrement(2) + 30;
                BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
            end
        elseif BJPLAYER.handle_get == 7
            if BJPLAYER.CurrentHand == 1
                set(handles.BJPLAYER.Card_8,'CData','','visible','off');
                handlegot = handles.BJPLAYER.Card_8;
                BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(1)-add+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                BJPLAYER.XIncrement(1) = BJPLAYER.XIncrement(1) + 30;
                BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
            elseif BJPLAYER.CurrentHand == 2
                set(handles.BJPLAYER.Card_8,'CData','','visible','off');
                handlegot = handles.BJPLAYER.Card_8;
                BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(2)+BJPLAYER.SPLITx), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                BJPLAYER.XIncrement(2) = BJPLAYER.XIncrement(2) + 30;
                BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
            end
        elseif BJPLAYER.handle_get == 8
            if BJPLAYER.CurrentHand == 1
                set(handles.BJPLAYER.Card_9,'CData','','visible','off');
                handlegot = handles.BJPLAYER.Card_9;
                BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(1)-add+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                BJPLAYER.XIncrement(1) = BJPLAYER.XIncrement(1) + 30;
                BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
            elseif BJPLAYER.CurrentHand == 2
                set(handles.BJPLAYER.Card_9,'CData','','visible','off');
                handlegot = handles.BJPLAYER.Card_9;
                BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(2)+BJPLAYER.SPLITx), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                BJPLAYER.XIncrement(2) = BJPLAYER.XIncrement(2) + 30;
                BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
            end
        elseif BJPLAYER.handle_get == 9
            if BJPLAYER.CurrentHand == 1
                set(handles.BJPLAYER.Card_10,'CData','','visible','off');
                handlegot = handles.BJPLAYER.Card_10;
                BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(1)-add+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                BJPLAYER.XIncrement(1) = BJPLAYER.XIncrement(1) + 30;
                BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
            elseif BJPLAYER.CurrentHand == 2
                set(handles.BJPLAYER.Card_10,'CData','','visible','off');
                handlegot = handles.BJPLAYER.Card_10;
                BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(2)+BJPLAYER.SPLITx), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                BJPLAYER.XIncrement(2) = BJPLAYER.XIncrement(2) + 30;
                BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
            end
        elseif BJPLAYER.handle_get == 10
            if BJPLAYER.CurrentHand == 1
                set(handles.BJPLAYER.Card_11,'CData','','visible','off');
                handlegot = handles.BJPLAYER.Card_11;
                BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(1)-add+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                BJPLAYER.XIncrement(1) = BJPLAYER.XIncrement(1) + 30;
                BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
            elseif BJPLAYER.CurrentHand == 2
                set(handles.BJPLAYER.Card_11,'CData','','visible','off');
                handlegot = handles.BJPLAYER.Card_11;
                BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(2)+BJPLAYER.SPLITx), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                BJPLAYER.XIncrement(2) = BJPLAYER.XIncrement(2) + 30;
                BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
            end
        elseif BJPLAYER.handle_get == 11
            if BJPLAYER.CurrentHand == 1
                set(handles.BJPLAYER.Card_12,'CData','','visible','off');
                handlegot = handles.BJPLAYER.Card_12;
                BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(1)-add+BJPLAYER.X1), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                BJPLAYER.XIncrement(1) = BJPLAYER.XIncrement(1) + 30;
                BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
            elseif BJPLAYER.CurrentHand == 2
                set(handles.BJPLAYER.Card_12,'CData','','visible','off');
                handlegot = handles.BJPLAYER.Card_12;
                BJPLAYER.handle(BJPLAYER.handle_get + 1) = handlegot;
                BJPLAYER.NumCards(BJPLAYER.CurrentHand) = BJPLAYER.NumCards(BJPLAYER.CurrentHand) + 1;
                BJPLAYER.Hand(BJPLAYER.CurrentHand,BJPLAYER.NumCards(BJPLAYER.CurrentHand)) = CARDS.NextCard;
                Card_Spec = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
                set(BJPLAYER.handle(BJPLAYER.handle_get + 1),'pos',[(BJPLAYER.XIncrement(2)+BJPLAYER.SPLITx), BJPLAYER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec,'visible','on');
                CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1; 
                BJPLAYER.XIncrement(2) = BJPLAYER.XIncrement(2) + 30;
                BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + CARDS.Value(CARDS.NextCard);
                BJPLAYER.handle_get  = BJPLAYER.handle_get + 1;
            end
        end
        
    case 'dealer'
        if BJDEALER.handle_get == 0
            BJDEALER.XIncrement = 0;
            handlegot = handles.BJDEALER.Card_1;
            BJDEALER.handle(BJDEALER.handle_get + 1) = handlegot;
            BJDEALER.NumCards = BJDEALER.NumCards + 1;
            BJDEALER.Hand(BJDEALER.NumCards) = CARDS.NextCard;
            Card_Spec_1 = CardGet(0,CARDS.Suit(CARDS.NextCard));
            set(BJDEALER.handle(BJDEALER.handle_get + 1),'pos',[(BJDEALER.XIncrement+BJDEALER.X1), BJDEALER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec_1,'visible','on');
            CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1;
            BJDEALER.XIncrement = BJDEALER.XIncrement + 30;
            BJDEALER.Total = BJDEALER.Total + CARDS.Value(CARDS.NextCard);
            BJDEALER.handle_get  = BJDEALER.handle_get + 1;
        elseif BJDEALER.handle_get == 1
            set(handles.BJDEALER.Card_2,'CData','','visible','off');
            set(handles.BJDEALER.Card_3,'CData','','visible','off');
            handlegot = handles.BJDEALER.Card_2;
            BJDEALER.handle(BJDEALER.handle_get + 1) = handlegot;
            BJDEALER.NumCards = BJDEALER.NumCards + 1;
            BJDEALER.Hand(BJDEALER.NumCards) = CARDS.NextCard;
            Card_Spec_1 = CardGet(Rank,CARDS.Suit(CARDS.NextCard));
            set(BJDEALER.handle(BJDEALER.handle_get + 1),'pos',[(BJDEALER.XIncrement+BJDEALER.X1), BJDEALER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec_1,'visible','on');
            CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1;
            BJDEALER.XIncrement = BJDEALER.XIncrement + 30;
            BJDEALER.Total = BJDEALER.Total + CARDS.Value(CARDS.NextCard);
            BJDEALER.handle_get  = BJDEALER.handle_get + 1;
        elseif BJDEALER.handle_get == 2
            set(handles.BJDEALER.Card_3,'CData','','visible','off');
            set(handles.BJDEALER.Card_4,'CData','','visible','off');
            handlegot = handles.BJDEALER.Card_3;
            BJDEALER.handle(BJDEALER.handle_get + 1) = handlegot;
            BJDEALER.NumCards = BJDEALER.NumCards + 1;
            BJDEALER.Hand(BJDEALER.NumCards) = CARDS.NextCard;
            Card_Spec_1 = CardGet(Rank,CARDS.Suit(CARDS.NextCard));
            set(BJDEALER.handle(BJDEALER.handle_get + 1),'pos',[(BJDEALER.XIncrement+BJDEALER.X1), BJDEALER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec_1,'visible','on');
            CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1;
            BJDEALER.XIncrement = BJDEALER.XIncrement + 30;
            BJDEALER.Total = BJDEALER.Total + CARDS.Value(CARDS.NextCard);
            BJDEALER.handle_get  = BJDEALER.handle_get + 1;
        elseif BJDEALER.handle_get == 3
            set(handles.BJDEALER.Card_4,'CData','','visible','off');
            handlegot = handles.BJDEALER.Card_4;
            BJDEALER.handle(BJDEALER.handle_get + 1) = handlegot;
            BJDEALER.NumCards = BJDEALER.NumCards + 1;
            BJDEALER.Hand(BJDEALER.NumCards) = CARDS.NextCard;
            Card_Spec_1 = CardGet(Rank,CARDS.Suit(CARDS.NextCard));
            set(BJDEALER.handle(BJDEALER.handle_get + 1),'pos',[(BJDEALER.XIncrement+BJDEALER.X1), BJDEALER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec_1,'visible','on');
            CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1;
            BJDEALER.XIncrement = BJDEALER.XIncrement + 30;
            BJDEALER.Total = BJDEALER.Total + CARDS.Value(CARDS.NextCard);
            BJDEALER.handle_get  = BJDEALER.handle_get + 1;
        elseif BJDEALER.handle_get == 4
            set(handles.BJDEALER.Card_5,'CData','','visible','off');
            handlegot = handles.BJDEALER.Card_5;
            BJDEALER.handle(BJDEALER.handle_get + 1) = handlegot;
            BJDEALER.NumCards = BJDEALER.NumCards + 1;
            BJDEALER.Hand(BJDEALER.NumCards) = CARDS.NextCard;
            Card_Spec_1 = CardGet(Rank,CARDS.Suit(CARDS.NextCard));
            set(BJDEALER.handle(BJDEALER.handle_get + 1),'pos',[(BJDEALER.XIncrement+BJDEALER.X1), BJDEALER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec_1,'visible','on');
            CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1;
            BJDEALER.XIncrement = BJDEALER.XIncrement + 30;
            BJDEALER.Total = BJDEALER.Total + CARDS.Value(CARDS.NextCard);
            BJDEALER.handle_get  = BJDEALER.handle_get + 1;
        elseif BJDEALER.handle_get == 5
            set(handles.BJDEALER.Card_6,'CData','','visible','off');
            handlegot = handles.BJDEALER.Card_6;
            BJDEALER.handle(BJDEALER.handle_get + 1) = handlegot;
            BJDEALER.NumCards = BJDEALER.NumCards + 1;
            BJDEALER.Hand(BJDEALER.NumCards) = CARDS.NextCard;
            Card_Spec_1 = CardGet(Rank,CARDS.Suit(CARDS.NextCard));
            set(BJDEALER.handle(BJDEALER.handle_get + 1),'pos',[(BJDEALER.XIncrement+BJDEALER.X1), BJDEALER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec_1,'visible','on');
            CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1;
            BJDEALER.XIncrement = BJDEALER.XIncrement + 30;
            BJDEALER.Total = BJDEALER.Total + CARDS.Value(CARDS.NextCard);
            BJDEALER.handle_get  = BJDEALER.handle_get + 1;
        elseif BJDEALER.handle_get == 6
            set(handles.BJDEALER.Card_7,'CData','','visible','off');
            handlegot = handles.BJDEALER.Card_7;
            BJDEALER.handle(BJDEALER.handle_get + 1) = handlegot;
            BJDEALER.NumCards = BJDEALER.NumCards + 1;
            BJDEALER.Hand(BJDEALER.NumCards) = CARDS.NextCard;
            Card_Spec_1 = CardGet(Rank,CARDS.Suit(CARDS.NextCard));
            set(BJDEALER.handle(BJDEALER.handle_get + 1),'pos',[(BJDEALER.XIncrement+BJDEALER.X1), BJDEALER.Y1, GENERAL.cwidth, GENERAL.cheight],'CData', Card_Spec_1,'visible','on');
            CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) = CARDS.CardCount(CARDS.Rank(CARDS.NextCard)) - 1;
            BJDEALER.XIncrement = BJDEALER.XIncrement + 30;
            BJDEALER.Total = BJDEALER.Total + CARDS.Value(CARDS.NextCard);
            BJDEALER.handle_get  = BJDEALER.handle_get + 1;
        end
        
        
end
      

CARDS.NextCard = CARDS.NextCard + 1;
CARDS.CardsLeft = CARDS.CardsLeft - 1;

end