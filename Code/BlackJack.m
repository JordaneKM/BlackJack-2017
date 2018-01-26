%BlackJack Twenty-One
%Main Function
%Written by Ishmael Leon
%                 Christopher Reid
%                       Scott Copley
%                           Jordane MCcalla
%December XX, 2017

%Constants to be initialized
close all;
clear global;
clc;

% global keisha;
%global - variables can be used in every function under the current folder
global CARDS;
global BANKROLL;
global BJDEALER;
global BJPLAYER;
global BJBOARD;
global QUITGAME;
global GENERAL;

BJBOARD.MaxDelay = 3;
% with global variables, we can use the dot feature to create a structure
% of that variable


%Open the graphics interface that a player uses to setup the game

Init = BJStartValues;
BJPLAYER.Total = 0;
BJDEALER.Total = 0;
BJPLAYER.Status = 'Stand';
BJPLAYER.HandsPlayed = 0;
BJPLAYER.Wins = 0;
BJPLAYER.Loses = 0;
BJPLAYER.Pushes = 0;
BJPLAYER.Percent = 0;
BANKROLL.Starting = 0;
BANKROLL.HandsLeft = Init.NumHands;
BANKROLL.Starting = Init.Bankroll;
BANKROLL.Unit = Init.BetUnit; % Point A . Let us find Init.BetUnit
CARDS.DecksUsed = Init.NumDecks;
% disp(Init.PN);
BJPLAYER.PN = Init.PN;
BJBOARD.Delays = BJBOARD.MaxDelay - BJBOARD.MaxDelay*Init.GameSpeed/100; % Controls the speed of the game
clear Init;
         

%First checking if it is a multi deck game - number of card packs to be
%used

if CARDS.DecksUsed == 1
    CARDS.MultiDeck = 0;
else 
    CARDS.MultiDeck = 1;
end

%Declaring and initializing constant variable shuffle

CARDS.Shuffle = 1; %Cards Shuffle when = 1

BANKROLL.History = BANKROLL.Starting; %Ensures that startup bank amount is the same
Bet = BANKROLL.Unit;                  %Inital Bet
BANKROLL.InsuranceBet = 0;


QUITGAME = 0;  %Ensures proper execution of our sentinal function
               %Program ends when 1 - To aid the functioning of the 
               %conditional while loop (while ~quitgame)... run program


FirstHand = 1;
AllVisible = 0; %When 1, all objects will be displayed on the board (for debug) - To ensure the proper functioning of the different elements on the board

BJPLAYER.XIncrement = [];
BJPLAYER.XIncrement(1) = 0;              %The increment in x direction between 
BJPLAYER.XIncrement(2) = 0;              %dealt cards - The spacing between 
                                         %the cards of a hand on the board (horizontally)

        
%Call the function that creates our playing board
Help;
uiwait;
handles = BJBoardCreation(Bet);
% Therefore handles takes in an assignment of the output of
%BJ BJBoardCreation(Bet)
% Let us go to BJBoardCreation() !!... 

pause(.2);            
               
 try
    while ~QUITGAME
        %Prepares array of cards randomly
        
        if CARDS.Shuffle == 1
            ShuffleNow(CARDS.DecksUsed);
            CARDS.Shuffle = 0;
            CARDS.CardsLeft = CARDS.DecksUsed*52; %Total number of cards
            CARDS.NextCard = 1;                   %Next card to be dealt

        end  

        %Variables initialized with every hand
        BJPLAYER.Total = 0;     %Player's Card Total
        BJDEALER.Total = 0;     %Dealer's Card Total
        BJPLAYER.Ace = 0;       %Becomes 1 if Player has an Ace used as 11
        BJDEALER.Ace = 0;  %Becomes 1 if Dealer has an Ace used as 11
        BJDEALER.Ace_2 = 0;
        BJDEALER.Ten = 0;
        BJPLAYER.Hand=[];       %Player's Hand
        BJDEALER.Hand=[];       %Dealer's Hand
        BJPLAYER.handle=[];     %Player's card handles
        BJDEALER.handle=[];     %Dealer's card handles
        BJPLAYER.Blackjack = 0; %Becomes 1 if Player has Blackjack
        BJDEALER.Blackjack = 0; %Becomes 1 if Dealer has Blackjack
        BJPLAYER.Bust = 0;      %Becomes 1 if Player Busts
        BJDEALER.Bust = 0;      %Becomes 1 if Dealer Busts
        BJPLAYER.NumCards = 0;  %Number of cards the player holds
        BJDEALER.NumCards = 0;  %Number of cards the dealer holds
        endhand = 0;            %If not 0, hand ends
        BJPLAYER.X1 = 250;      %Initialize Player's Card Coordinates
        BJPLAYER.Y1 = 80;
        BJPLAYER.SPLITx = 450;      %Player's 2nd hand coordinates for splitting
        BJPLAYER.SPLITy = 80;
        BJDEALER.X1 = 250;         %Initializes Dealer's Card Coordinates
        BJDEALER.Y1 = 400;
        BJPLAYER.Winner = 0;      %0=push, 1=Player wins, 2=Dealer wins
        BJPLAYER.Splits = 0;      %Becomes 1 if the player has used his one split
        BJPLAYER.CurrentHand = 1; %Always 1, unless playing the 2nd hand after a split
        BJPLAYER.handle_get = 0;
        BJDEALER.handle_get = 0;
        BJPLAYER.handle = [];
        BJDEALER.handle = [];
        GENERAL.cwidth = 104;
        GENERAL.cheight = 151;
        BJPLAYER.XIncrement(1) = 0; %The increment in x direction between 
        BJPLAYER.XIncrement(2) = 0; 
     
        %Wait for the player to press Deal or Quit
        
        if FirstHand
            %Set starting money to be the current bank amount
            BANKROLL.Money = BANKROLL.Starting;
            uiwait(gcf);
            
            set(handles.DealButton,'visible','off');
            set(handles.QuitButton,'visible','off');
            set(handles.ResultTxt,'visible','off');
            set(handles.InsuranceButton,'visible','off');
        end      
               
        %Determine Player's wager
        
        if (BANKROLL.Money > 0)
            Bet = str2double(get(handles.BetText,'string')); % If having some sort of money
            if (Bet > BANKROLL.Money)
                Bet = BANKROLL.Money; % Whatever you can afford
                set(handles.BetText,'string',num2str(Bet));
            elseif (Bet <= 0) && (BANKROLL.Money >= BANKROLL.Unit)
                Bet = BANKROLL.Unit; % If you can afford the initial bet
                set(handles.BetText,'string',num2str(Bet));
            elseif (Bet <= 0)
                Bet = BANKROLL.Money; % Bet becomes whatever money is in the bank
            end
        else
            endhand = 1;
            set(handles.OutofMoneyTxt,'visible','on'); % if money in bank is 0
        end
        
        %This defines the action of each hand % if endhand is 0 - con
        if ~endhand 
            
            %Deal 2 Cards to player
            %First Card
            BJDealCard('player',handles,0,0);
            %Second Card
            BJDealCard('player',handles,0,0);
            % We can use BJDealCard to deal a card either to a player or to
            % the dealer !!
            
            % Here we are dealing to the player !!!
            
   
            %Check Player's Hand for ace/blackjack and compensate for it
            if (CARDS.Value(CARDS.NextCard-2) == 1) %If the value of your first card is a 11, check it as an ace
                if (BJPLAYER.Total + 10) > 21
                    BJPLAYER.Total = BJPLAYER.Total;
                elseif (BJPLAYER.Total + 10) <= 21
                    BJPLAYER.Total = BJPLAYER.Total + 10;
                    BJPLAYER.Ace = 1; % Counts existence of an ace used as 11 
                end
                
            elseif (CARDS.Value(CARDS.NextCard-1) == 1) %If the value of your second card is a 11
                if (BJPLAYER.Total + 10) > 21
                    BJPLAYER.Total = BJPLAYER.Total;
                elseif (BJPLAYER.Total + 10) <= 21
                    BJPLAYER.Total = BJPLAYER.Total + 10;
                    BJPLAYER.Ace = 1; % Counts existence of an ace used as 11 
                end

            end
            
            if BJPLAYER.Total == 21 % Checks for blackjack in a players hand
                set(handles.PlayerBJTxt,'visible','on'); % Updates the gui for the occurence of blackjack
                endhand = 1; % Ends the current hanad of the game
                BJPLAYER.Blackjack = 1; % Counts existence of blackjack with a player
            end
            
            set(handles.PlayerTotalTxt,'string', num2str(BJPLAYER.Total),'visible','on'); % updates the player's total after the hand
                                                                                          % on gui                                                               
    
            
            %Deal 2 Cards to dealer, first is face down
            %First Card
            BJDealCard('dealer',handles,1,0);
            %Second Card
            BJDealCard('dealer',handles,0,0);    
            % Here we are dealing to the dealer !!
            % As observed to be the first parameter to BJDealCard !!
                                                                            
            % Check Dealer's Hand for ace/blackjack and compensate for it
            if (CARDS.Value(CARDS.NextCard-2) == 1)
                if (BJDEALER.Total + 10) > 21
                    BJDEALER.Total = BJDEALER.Total;
                elseif (BJPLAYER.Total + 10) <= 21
                    BJDEALER.Total = BJDEALER.Total + 10;
                    BJDEALER.Ace = 1; % Counts existence of an ace used as 11
                end

            elseif (CARDS.Value(CARDS.NextCard-1) == 1)
                if (BJDEALER.Total + 10) > 21
                    BJDEALER.Total = BJDEALER.Total;
                elseif (BJDEALER.Total + 10) <= 21
                    BJDEALER.Total = BJDEALER.Total + 10;
                    BJDEALER.Ace = 1;
%                     BJDEALER.Ace_2 = 1;
                end
                  
            end
            
            
            if(CARDS.Value(CARDS.NextCard-1) == 10)
                BJDEALER.Ten = 1;
            end
            
            if BJDEALER.Ten == 1
              set(handles.InsuranceButton,'visible','on');
              set(handles.InsuranceBox,'visible','on');
              set(handles.Reset,'visible','on');
            end
            
            set(handles.DealerTotalTxt,'string',[num2str( CARDS.Value(CARDS.NextCard-1) ) '+' ]);
            
            if BJDEALER.Ten && BJDEALER.Ace || (CARDS.Value(CARDS.NextCard-2) == 10 && BJDEALER.Ace)
                BJDEALER.Total = 21;
                
            end

             %If player has blackjack, show the dealer's down card
             if BJPLAYER.Blackjack == 1
                  set(handles.BJDEALER.Card_1,'CData',CardGet( CARDS.Value(CARDS.NextCard-1) ,CARDS.Suit(CARDS.NextCard-1) ) );
                  set(handles.PlayerTotalTxt,'string',num2str(BJPLAYER.Total));
             end
   
        end

        %Player's Turn
        while ~endhand
            
            %Make Selection Buttons visible
            set(handles.HitButton,'visible','on');
            set(handles.StandButton,'visible','on');
            set(handles.DoubleButton,'visible','off');
            set(handles.SplitButton,'visible','off');

            if BJPLAYER.NumCards(BJPLAYER.CurrentHand) == 2
                if (CARDS.Value(BJPLAYER.Hand(BJPLAYER.CurrentHand,1)) == CARDS.Value(BJPLAYER.Hand(BJPLAYER.CurrentHand,2))) && ~BJPLAYER.Splits
                    set(handles.SplitButton,'visible','on');
                end
                set(handles.DoubleButton,'visible','on');
            end
            


            %Wait for Hit, Stand, Double,Insurance or Split button to be pressed
            if BJPLAYER.Total(BJPLAYER.CurrentHand) < 21
                uiwait(gcf);    
            elseif BJPLAYER.Total == 21
                BJPLAYER.hitorstand = 6; %If player already has 21, just stand
                BJPLAYER.Status = 'Stand';
                set(handles.StatusTxt,'string',BJPLAYER.Status);
            end
            
             if BJPLAYER.hitorstand == 12
                BANKROLL.InsuranceBet = 0;
             end
             
             if BJPLAYER.hitorstand == 7
                 Bet= 2*Bet;
                 set(handles.BetText,'string',num2str(Bet));
                 set(handles.StatusTxt,'string','Double');
                 BJDealCard('player',handles,0,0);
                 break
             end
                 
             
            if BANKROLL.InsuranceBet ~= 0 
                set(handles.InsuranceBox,'string',num2str(BANKROLL.InsuranceBet));
            else
                ...
            end
            
            
            if BJPLAYER.hitorstand == 9
               BANKROLL.InsuranceBet = BANKROLL.InsuranceBet + 25;
            end
           
            
            if BANKROLL.InsuranceBet < 0.5*BANKROLL.Money
                set(handles.InsuranceBox,'string',num2str(BANKROLL.InsuranceBet)); 
            else
                msgbox('Not enough cash');
                pause(2);
                close(msgbox);
                set(handles.InsuranceBox,'string','25');
            end
            
            %Manages betting with buttons
            if(BJPLAYER.hitorstand == 2)
                if(BANKROLL.Money > 25)
                    Bet = Bet + 25; 
                elseif (BANKROLL.Money < 25) 
                end
            elseif(BJPLAYER.hitorstand == 3)
                if(BANKROLL.Money > 50)
                    Bet = Bet + 50;   
                elseif (BANKROLL.Money < 50)
                end
            elseif(BJPLAYER.hitorstand == 4)
                if(BANKROLL.Money > 100)
                    Bet = Bet + 100;  
                elseif (BANKROLL.Money < 100)
                        
                end
            elseif (BJPLAYER.hitorstand == 11)
                    Bet = 0;
            elseif (BJPLAYER.hitorstand == 10)
                    Bet = BANKROLL.Unit;
 
            end
            
            if BANKROLL.Money > Bet
                    set(handles.BetText,'string', num2str(Bet));
            else
                    set(handles.BetText,'string','25');
                    msgbox('Not enough cash');
%                     pause(2);
%                     close(msgbox);
                    
            end 
            
            %If the player hits or doubles down, deal another card
            if (BJPLAYER.hitorstand == 5)
                %Call the hit function
                BJPLAYER.Status = 'Hit';
                set(handles.StatusTxt,'string',BJPLAYER.Status);
                BJPlayerHits(handles);
                
            end

%            if BJPLAYER.Total == 21 % Checks for blackjack in a players hand
%                 set(handles.PlayerBJTxt,'visible','on'); % Updates the gui for the occurence of blackjack
%                 endhand = 1; % Ends the current hand of the game
%                 BJPLAYER.Blackjack = 1; % Counts existence of blackjack with a player
%            end
            
           
            
            %If the player stands or has already busted or hit 21, player's
            %turn ends unless he split and has another hand to go
            if ((BJPLAYER.hitorstand == 6) || (BJPLAYER.Total(BJPLAYER.CurrentHand) >= 21))
                BJPLAYER.Status = 'Stand';
                set(handles.StatusTxt,'string',BJPLAYER.Status);
                if (~BJPLAYER.Splits || ((BJPLAYER.Splits+1) == BJPLAYER.CurrentHand))
                     break
                elseif (BJPLAYER.Splits+1) > BJPLAYER.CurrentHand
                    BJPLAYER.CurrentHand = BJPLAYER.CurrentHand + 1;
                    set(handles.PlayerTotalSplitTxt(1),'foregroundcolor',[.5 .5 .5]);
                    set(handles.PlayerTotalSplitTxt(2),'foregroundcolor',[0 0 0]);
                end
            end

            %If the player has split, re-distribute his two cards, and play
            %both new hands
            if (BJPLAYER.hitorstand == 8)
                BJPLAYER.Status = 'Split';
                set(handles.StatusTxt,'string',BJPLAYER.Status);
                BJPLAYER.Splits = BJPLAYER.Splits + 1;

                %Double the bet
                Bet(1) = 2*Bet(1);
                %Can't get blackjack after a split
                BJPLAYER.Blackjack(1:2) = 0;
                
                %Move cards in split position
                set(BJPLAYER.handle(1),'pos',[BJPLAYER.X1 BJPLAYER.Y1 GENERAL.cwidth GENERAL.cheight],'visible','on');
                set(BJPLAYER.handle(2),'pos',[BJPLAYER.SPLITx BJPLAYER.SPLITy GENERAL.cwidth GENERAL.cheight],'visible','on');
                BJPLAYER.handle = [];

                %If aces were split, the hand ends after two new cards are dealt
                %Also, set ace field to 1 and update the totals
                if (CARDS.Rank(BJPLAYER.Hand(1)) == 1) && (CARDS.Rank(BJPLAYER.Hand(2)) == 1)
                    endhand = 1;
                    BJPLAYER.Ace(1) = 1;
                    BJPLAYER.Ace(2) = 1;
                    BJPLAYER.Total(1) = 11;
                    BJPLAYER.Total(2) = 11;
                else
                    BJPLAYER.Ace(1) = 0;
                    BJPLAYER.Ace(2) = 0;
                    BJPLAYER.Total(1) = CARDS.Value(CARDS.NextCard-4);
                    BJPLAYER.Total(2) = CARDS.Value(CARDS.NextCard-3);
                end

                %Update player total outputs
                set(handles.PlayerTotalTxt,'visible','off');
                set(handles.PlayerTotalSplitTxt(1),'string',num2str(BJPLAYER.Total(1)),'visible','on','foregroundcolor','b');
                set(handles.PlayerTotalSplitTxt(2),'string',num2str(BJPLAYER.Total(2)),'visible','on');

                BJPLAYER.Hand = [];
                BJPLAYER.Hand(1,1) = CARDS.NextCard - 4;
                BJPLAYER.Hand(2,1) = CARDS.NextCard - 3;

                pause(BJBOARD.Delays)

                %Fix BJPLAYER.NumCards
                BJPLAYER.NumCards(1) = 1;
                BJPLAYER.NumCards(2) = 1;

                %Deal next 2 cards
                BJDealCard('player',handles,0,0);
                pause(BJBOARD.Delays);
                BJPLAYER.CurrentHand = 2;
                BJDealCard('player',handles,0,BJPLAYER.SPLITx);
                BJPLAYER.CurrentHand = 1;
                
                
                
            %If the player hits or doubles down, deal another card
            if (BJPLAYER.hitorstand == 5) 
                %Call the hit function
                BJPLAYER.Status = 'Hit';
                set(handles.StatusTxt,'string',BJPLAYER.Status);
                BJPlayerHits(handles);
                
            end
            
            if BJPLAYER.Splits > 0
                BJPLAYER.Splits = 1;
            end

            
                %Look for aces
                for n = 1:BJPLAYER.Splits+1
                    for m = 1:max(BJPLAYER.NumCards)
                        if (CARDS.Value(BJPLAYER.Hand(n,m)) == 1) && ~BJPLAYER.Ace(n)
                            BJPLAYER.Ace(n) = 1;
                            BJPLAYER.Total(n) = BJPLAYER.Total(n) + 10;
                        end
                    end
                end
        

                set(handles.PlayerTotalSplitTxt(1),'string',num2str(BJPLAYER.Total(1)) );
                set(handles.PlayerTotalSplitTxt(2),'string',num2str(BJPLAYER.Total(2)) );
                pause(BJBOARD.Delays);
               
            end
        end
        
        if BJPLAYER.Splits > 0
            BJPLAYER.Splits = 1;
        end

        for n = 1:BJPLAYER.Splits+1
            if BJPLAYER.Total(n) > 21
                set(handles.PlayerTotalTxt,'string','Bust');
                set(handles.PlayerTotalSplitTxt(n),'string','Bust');
                BJPLAYER.Bust(n) = 1;

            else
                BJPLAYER.Bust(n) = 0;
            end
            
        end

        set(handles.HitButton,'visible','off');
        set(handles.StandButton,'visible','off');
        set(handles.DoubleButton,'visible','off');
        set(handles.SplitButton,'visible','off');

        %Dealer's Turn
        %Flip dealer's down card and output his new total

        set(handles.BJDEALER.Card_1,'CData',CardGet( CARDS.Value(BJDEALER.Hand(1)),CARDS.Suit(BJDEALER.Hand(1)) ) ); 
        
        
            %Check Dealer's Hand for ace/blackjack and compensate for it
            
            if CARDS.Value(CARDS.NextCard-1) == 1 && CARDS.Value(CARDS.NextCard-2) == 1
                BJDEALER.Total = 12;
            end
            
            if BJDEALER.Total == 21
                BJDEALER.Blackjack = 1;
                
            end
            
            set(handles.DealerTotalTxt,'string',num2str(BJDEALER.Total));
            
             if (BJDEALER.Blackjack)
                if BJPLAYER.Blackjack
                    set(handles.BothBJTxt,'visible','on');
                else
                    set(handles.DealerBJTxt,'visible','on');
                end
                
                %Show down card if dealer has Blackjack
                set(handles.BJDEALER.Card_1,'CData',CardGet( CARDS.Value(CARDS.NextCard-2),CARDS.Suit(CARDS.NextCard-2) ) );
                set(handles.DealerTotalTxt,'string',num2str( num2str(BJDEALER.Total) ) );
                set(handles.DealerBJTxt,'visible','on');
%                 BJDEALER.Blackjack = 1;
            end
       
                  
        %Dealer hits on 16 or less and soft 17 (17 with Ace as 11) unless player
        %has busted or had blackjack
        while ((BJDEALER.Total < 17) || ((BJDEALER.Total == 17) && (BJDEALER.Ace))) && ~all(BJPLAYER.Bust) && ~all(BJPLAYER.Blackjack)
            BJDealerHits(handles);
        end

        %Check for dealer bust
        if BJDEALER.Total > 21
             set(handles.DealerTotalTxt,'string','Bust','visible','on');
             BJDEALER.Bust = 1;
            
%         elseif BJDEALER.Total == 21
%             set(handles.DealerBJTxt,'visible','on');
%             BJDEALER.Blackjack = 1;
            
        end
        

        %Determine who wins
        BJDetermineWinner;

        %Bankroll changes based on results, and update Result txt
        for n = 1:length(BJPLAYER.Winner)
            switch BJPLAYER.Winner(n)
                case 1
                    BJPLAYER.Wins = BJPLAYER.Wins + 1;
                    BANKROLL.Money = BANKROLL.Money + Bet(n) + BANKROLL.InsuranceBet;
                    set(handles.ResultTxt,'string','You Won!','ForegroundColor','b','visible','on');
                case 2
                    BJPLAYER.Loses = BJPLAYER.Loses + 1;
                    BANKROLL.Money = BANKROLL.Money - Bet(n) - BANKROLL.InsuranceBet;
                    set(handles.ResultTxt,'string','You Lost!','ForegroundColor','b','visible','on');
                otherwise
                    BJPLAYER.Pushes = BJPLAYER.Pushes + 1;
                    set(handles.ResultTxt,'string','It''s a Push','ForegroundColor','b','visible','on');
            end
            set(handles.InsuranceButton,'visible','off');
            set(handles.InsuranceBox,'visible','off');
            set(handles.Reset,'visible','off');
            set(handles.WinsBox,'string',num2str(BJPLAYER.Wins));
            set(handles.LosesBox,'string',num2str(BJPLAYER.Loses));
            set(handles.PushesBox,'string',num2str(BJPLAYER.Pushes));
            set(handles.BankrollTxt,'string',num2str(BANKROLL.Money),'visible','on');
            break
        end
        
            %Update result txt when player split
            if BJPLAYER.Splits == 1
                if all(BJPLAYER.Winner == 1)
                    BJPLAYER.Wins = BJPLAYER.Wins + 2;
                    set(handles.ResultTxt,'string','You Win Both!','ForegroundColor','b','visible','on');
                elseif BJPLAYER.Winner(1) == 2 && BJPLAYER.Winner(2) == 2
                    BJPLAYER.Loses = BJPLAYER.Loses + 2;
                    set(handles.ResultTxt,'string','You Lose Both!','ForegroundColor','b','visible','on');
                elseif all(BJPLAYER.Winner == 0)
                    BJPLAYER.Pushes = BJPLAYER.Pushes + 2;
                    set(handles.ResultTxt,'string','You Push Both!','ForegroundColor','b','visible','on');
                elseif any(BJPLAYER.Winner == 1) && any(BJPLAYER.Winner == 2)
                    BJPLAYER.Wins = BJPLAYER.Wins + 1;
                    BJPLAYER.Loses = BJPLAYER.Loses + 1;
                    set(handles.ResultTxt,'string','Win one, Lose one!','ForegroundColor','b','visible','on');
                elseif any(BJPLAYER.Winner == 1) && any(BJPLAYER.Winner == 0)
                     BJPLAYER.Wins = BJPLAYER.Wins + 1;
                     BJPLAYER.Pushes = BJPLAYER.Pushes + 1;
                    set(handles.ResultTxt,'string','Win one, Push one!','ForegroundColor','b','visible','on');
                elseif any(BJPLAYER.Winner == 0) && any(BJPLAYER.Winner == 2)
                     BJPLAYER.Pushes = BJPLAYER.Pushes + 1;
                     BJPLAYER.Loses = BJPLAYER.Loses + 1;
                    set(handles.ResultTxt,'string','Push one, Lose one!','ForegroundColor','b','visible','on');
                end
                set(handles.InsuranceButton,'visible','off');
                set(handles.InsuranceBox,'visible','off');
                set(handles.WinsBox,'string',num2str(BJPLAYER.Wins));
                set(handles.LosesBox,'string',num2str(BJPLAYER.Loses));
                set(handles.PushesBox,'string',num2str(BJPLAYER.Pushes));
            end            

        if (BANKROLL.Money <= 0)
            set(handles.OutofMoneyTxt,'visible','on');
            QUITGAME = 1;
            
        end

        %Reduce # of hands to go by 1.  If we're now at 0, set endhand to 1.
        %If we were at 0 before, just keep going since there's no set # of
        %hands
        if BANKROLL.HandsLeft
            BANKROLL.HandsLeft = BANKROLL.HandsLeft - 1;
            set(handles.HandsLeftBox,'string',num2str(BANKROLL.HandsLeft));
            if ~BANKROLL.HandsLeft
                QUITGAME = 1;
                msgbox('Game has ended, Hands are finished');
            end
            
        end
        
        BJPLAYER.HandsPlayed = BJPLAYER.HandsPlayed + 1;
        set(handles.HandsPlayedBox,'string',num2str(BJPLAYER.HandsPlayed));
        BJPLAYER.Percent = (BJPLAYER.Wins/BJPLAYER.HandsPlayed)*100;
        set(handles.WinningPercentBox,'string',[num2str(round(BJPLAYER.Percent)) '%']);
        
        
        
        %Get ready for next hand
        if ~QUITGAME
            %Check Card Penetration
            %In single deck, shuffles after 66% of cards are used
            %In multi deck, shuffles after 75% of cards are used
            if (~CARDS.MultiDeck) && (CARDS.CardsLeft < (1/3*CARDS.DecksUsed*52))
                CARDS.Shuffle = 1;
                set(handles.ShuffleTxt,'visible','on');
                pause(2);
                set(handles.ShuffleTxt,'visible','off');
            end
            if (CARDS.MultiDeck) && (CARDS.CardsLeft < (1/4*CARDS.DecksUsed*52))
                CARDS.Shuffle = 1;
                set(handles.ShuffleTxt,'visible','on');
                pause(2);
                set(handles.ShuffleTxt,'visible','off');
            end

            %Ask player if he wants to deal again 
            if QUITGAME == 0
                set(handles.DealButton,'visible','on');
                set(handles.QuitButton,'visible','on');
                uiwait(gcf);
            end
         
            if  QUITGAME
                break
            end
        else
            pause(BJBOARD.Delays*2);
        end

        %Get ready for next hand
        FirstHand = 0;
        BANKROLL.Bet = str2double(get(handles.BetText,'string'));

    %         Clear the extra stuff from the board to prepare for the next hand
    %         Remove the player's cards
    
            set(handles.BJPLAYER.Card_1,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJPLAYER.Card_2,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJPLAYER.Card_3,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJPLAYER.Card_4,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJPLAYER.Card_5,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJPLAYER.Card_6,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJPLAYER.Card_7,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJPLAYER.Card_8,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJPLAYER.Card_9,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJPLAYER.Card_10,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJPLAYER.Card_11,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJPLAYER.Card_12,'style','pushbutton','visible','off', 'CData', '');
            

            set(handles.BJDEALER.Card_1,'style','pushbutton','visible','off' ,'CData', '');
            set(handles.BJDEALER.Card_2,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJDEALER.Card_3,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJDEALER.Card_4,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJDEALER.Card_5,'style','pushbutton','visible','off', 'CData', '');
            set(handles.BJDEALER.Card_6,'style','pushbutton','visible','off', 'CData', '');
              
            BJPLAYER.Total = 0;
            BJPLAYER.Ace = 0;
            BJDEALER.Total = 0;
            BJDEALER.Ace = 0;
            BJPLAYER.Hand = [];
            BJDEALER.Hand = [];
            BJPLAYER.handle = [];
            BJPLAYER.handle = [];
            endhand = 0;
            BJPLAYER.Splits = 0;
            BANKROLL.InsuranceBet = 0;

%        Clear the hand results
         set(handles.ResultTxt,'string','','visible','off');
         set(handles.QuitButton,'visible','off');
         set(handles.StatusTxt,'string','','visible','on');
         set(handles.PlayerTotalTxt,'string','','visible','on');
         set(handles.PlayerTotalSplitTxt(1),'visible','off');
         set(handles.PlayerTotalSplitTxt(2),'visible','off');
         set(handles.DealerTotalTxt,'string','');
         set(handles.PlayerBJTxt,'visible','off');
         set(handles.DealerBJTxt,'visible','off');
         set(handles.BothBJTxt,'visible','off');
         set(handles.OutofMoneyTxt,'visible','off');
         set(handles.NoDDMoneyTxt,'visible','off');
         set(handles.ShuffleTxt,'visible','off');
         set(handles.InsuranceButton,'visible','off');
         set(handles.InsuranceBox,'string','','visible','off');
         set(handles.Reset,'visible','off');

        BANKROLL.History(end+1) = BANKROLL.Money;
   end

      close all;
      delete(gcf); 
 catch
      return

end              
      
        
               
               
               
               
               
               
               
               
               
               
               
               
               
               