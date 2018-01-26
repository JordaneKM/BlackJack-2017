function BJDetermineWinner
%Determines the winner of the blackjack hand

global BJPLAYER
global BJDEALER
global BANKROLL
% global QUITGAME 

for n=1:length(BJPLAYER.Total)
    if BJPLAYER.Blackjack(n) && ~BJDEALER.Blackjack                  %Player has Blackjack
        BJPLAYER.Winner(n) = 1;
        if ~BJPLAYER.Splits                                        %Only pay out 1.5x if it wasn't a split
            BANKROLL.Bet(n) = BANKROLL.Bet(n)*1.5;
        end
    elseif ~BJPLAYER.Blackjack(n) && BJDEALER.Blackjack              %Dealer has Blackjack
        BJPLAYER.Winner(n) = 2; 
    elseif BJPLAYER.Blackjack(n) && BJDEALER.Blackjack               %Both have Blackjack
        BJPLAYER.Winner(n) = 0;
    elseif BJPLAYER.Bust(n)                                        %Player Busts
        BJPLAYER.Winner(n) = 2;
    elseif BJDEALER.Bust                                           %Dealer Busts
        BJPLAYER.Winner(n) = 1;
    elseif (BJPLAYER.Total(n) > BJDEALER.Total)                      %Player beats Dealer
        BJPLAYER.Winner(n) = 1;
    elseif (BJDEALER.Total > BJPLAYER.Total(n))                      %Dealer beats Player
        BJPLAYER.Winner(n) = 2;
    elseif (BJPLAYER.Total(n) == BJDEALER.Total)                     %Push
        BJPLAYER.Winner(n) = 0;
    end
    
%     QUITGAME = 0;
end