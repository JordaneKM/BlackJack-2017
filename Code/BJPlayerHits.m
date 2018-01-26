function BJPlayerHits(handles)
%Performs the required actions when a player decides to hit, on the hand
%specified by Player.CurrentHand

global BJPLAYER
% global BJDEALER
global CARDS
global BANKROLL

%If the player doubled down but doesn't have the money, call it
%a hit
if (BJPLAYER.hitorstand == 7) && (BANKROLL.Money < 2*BANKROLL.Bet(BJPLAYER.CurrentHand))
    set(handles.NoDDMoneyTxt,'visible','on');
    BJPLAYER.hitorstand = 5;
end

%Deal another card
set(handles.BJPLAYER.Card_3,'CData','');
set(handles.BJPLAYER.Card_4,'CData','');
BJDealCard('player',handles,0,0);

%Check and compensate for Aces
if (CARDS.Rank(CARDS.NextCard-1) == 1) && (BJPLAYER.Total(BJPLAYER.CurrentHand) < 12)
    BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) + 10;
    BJPLAYER.Ace(BJPLAYER.CurrentHand) = 1;
end
if (BJPLAYER.Ace(BJPLAYER.CurrentHand) == 1) && (BJPLAYER.Total(BJPLAYER.CurrentHand) > 21)
    BJPLAYER.Total(BJPLAYER.CurrentHand) = BJPLAYER.Total(BJPLAYER.CurrentHand) - 10;
    BJPLAYER.Ace(BJPLAYER.CurrentHand) = 0;
end

%Update the appropriate string with the new total
if BJPLAYER.Splits
    set(handles.PlayerTotalSplitTxt(BJPLAYER.CurrentHand),'string',num2str(BJPLAYER.Total(BJPLAYER.CurrentHand)));
else
    set(handles.PlayerTotalTxt,'string',num2str(BJPLAYER.Total));
end

%Double the bet if it was a double down
if BJPLAYER.hitorstand == 7
    BANKROLL.Bet(BJPLAYER.CurrentHand) = BANKROLL.Bet(BJPLAYER.CurrentHand)*2;
end