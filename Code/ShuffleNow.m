function ShuffleNow(NumDecks)
%This function takes the number of decks needed as an input, and outputs a
%structure named Cards that contains the value (a number from 1 to 10),
%rank (1 number from 1 to 13), and suit (the character c, h, s or d).
%Value and Rank are different because in blackjack, Jacks, Queens and Kings
%are all worth the same (i.e. Their rank would be 11, 12, or 13, but their
%value is always 10).

% NumDecks = 6;
%Initialize variables
global CARDS
CARDS.Rank = randperm(52*NumDecks); % Random number out of a row matrix of 52 to 142 cards
CARDS.CardCount(1:13)=0; %Sets a row matrix of 13 values to zero

for n = 1:(52*NumDecks)
    %This sets the card's suit based on the original number's remainder
    %when dividing by 4 -> 0 is clubs, 1 is hearts, 2 is spades, 3 is
    %diamonds.
    switch mod(CARDS.Rank(n), 4)
        case 0
            CARDS.Suit(n) = 'C';
        case 1
            CARDS.Suit(n) = 'H';   % Method in randomizing the card's suit by using a remainder calculation
        case 2
            CARDS.Suit(n) = 'S';
        case 3
            CARDS.Suit(n) = 'D';
        otherwise
            fprintf('%s\n','CARDS.Suit error');
            CARDS.Suit(n) = 'X';
    end

    %This sets the card's value such that the first 1/13th of the numbers = 1 (ace),
    %next 1/13th of numbers = 2, etc.  Also, 11 = Jack, 12 = Queen, 13 = King.
    %It is stored in matrix CardArray.
    if (CARDS.Rank(n) <= 1*NumDecks*4)
        CARDS.Rank(n) = 1;
        CARDS.Value(n) = 1;
        CARDS.CardCount(1)= CARDS.CardCount(1) + 1;
    elseif (CARDS.Rank(n) <= 2*NumDecks*4)
        CARDS.Rank(n) = 2;
        CARDS.Value(n) = 2;
        CARDS.CardCount(2) = CARDS.CardCount(2) + 1;   % Ensures that the value occurence of cards
    elseif (CARDS.Rank(n) <= 3*NumDecks*4)             % Within a deck occurs a maximum of 4 times randomly
        CARDS.Rank(n) = 3;
        CARDS.Value(n) = 3;
        CARDS.CardCount(3) = CARDS.CardCount(3) + 1;   %Keeps track of the cards occurence in the 13 zeroed row matrix
    elseif (CARDS.Rank(n) <= 4*NumDecks*4)             %By adding one to the position
        CARDS.Rank(n) = 4;
        CARDS.Value(n) = 4;
        CARDS.CardCount(4) = CARDS.CardCount(4) + 1;
    elseif (CARDS.Rank(n) <= 5*NumDecks*4)
        CARDS.Rank(n) = 5;
        CARDS.Value(n) = 5;
        CARDS.CardCount(5) = CARDS.CardCount(5) + 1;
    elseif (CARDS.Rank(n) <= 6*NumDecks*4)
        CARDS.Rank(n) = 6;
        CARDS.Value(n) = 6;
        CARDS.CardCount(6) = CARDS.CardCount(6) + 1;
    elseif (CARDS.Rank(n) <= 7*NumDecks*4)
        CARDS.Rank(n) = 7;
        CARDS.Value(n) = 7;
        CARDS.CardCount(7) = CARDS.CardCount(7) + 1;
    elseif (CARDS.Rank(n) <= 8*NumDecks*4)
        CARDS.Rank(n) = 8;
        CARDS.Value(n) = 8;
        CARDS.CardCount(8) = CARDS.CardCount(8) + 1;
    elseif (CARDS.Rank(n) <= 9*NumDecks*4)
        CARDS.Rank(n) = 9;
        CARDS.Value(n) = 9;
        CARDS.CardCount(9) = CARDS.CardCount(9) + 1;
    elseif (CARDS.Rank(n) <= 13*NumDecks*4)   %All cards worth 10
        CARDS.Value(n) = 10;
        
        if (CARDS.Rank(n) <= 10*NumDecks*4)
            CARDS.Rank(n) = 10;
            CARDS.CardCount(10) = CARDS.CardCount(10) + 1;
        elseif (CARDS.Rank(n) <= 11*NumDecks*4)
            CARDS.Rank(n) = 11;
            CARDS.CardCount(11) = CARDS.CardCount(11) + 1;
        elseif (CARDS.Rank(n) <= 12*NumDecks*4)
            CARDS.Rank(n) = 12;
            CARDS.CardCount(12) = CARDS.CardCount(12) + 1;
        elseif (CARDS.Rank(n) <= 13*NumDecks*4)
            CARDS.Rank(n) = 13;
            CARDS.CardCount(13) = CARDS.CardCount(13) + 1;
        end
    end
    
%     CARDS.NextCard = 1;
%     obj = CardGet(CARDS.Rank(CARDS.NextCard),CARDS.Suit(CARDS.NextCard));
%     imshow(obj);
%     
end
       