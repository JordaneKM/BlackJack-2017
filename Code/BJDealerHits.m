function BJDealerHits(handles)

global CARDS
global BJDEALER
global BJBOARD

%Deal Card
set(handles.BJDEALER.Card_3,'CData','');
set(handles.BJDEALER.Card_4,'CData','');
BJDealCard('dealer',handles,0,0);

%Check and compensate for aces
if (CARDS.Rank(CARDS.NextCard) == 1) && (BJDEALER.Total < 12)
    BJDEALER.Total = BJDEALER.Total + 10;
    BJDEALER.Ace = 1;
end
if (BJDEALER.Ace == 1) && (BJDEALER.Total > 21)
    BJDEALER.Total = BJDEALER.Total - 10;
    BJDEALER.Ace = 0;
end

%Update dealer's total
set(handles.DealerTotalTxt,'string',num2str(BJDEALER.Total) );

%Update Hi-Lo count
% BJUpdateHiLoCount(handles,CARDS.NextCard-1);

pause(BJBOARD.Delays);