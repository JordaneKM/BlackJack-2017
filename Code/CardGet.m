function [ccard] = CardGet(RANK,SUIT)

% left bottom corner (X0,Y0)
% top right corner (X1, Y1)
% CSIZE - size dimensions of a card
% obj - card itself

% BJBoardCreation;

% global CARDS;
% 
% RANK = 0;
% SUIT = CARDS.Suit(CARDS.NextCard);

Card = SUIT;

if RANK == 11
    Rank = 'J';
    concat = [Rank Card '.jpg'];
    ccard = imread(concat);
elseif RANK == 1
    Rank = 'A';
    concat = [Rank Card '.jpg'];
    ccard = imread(concat);
elseif RANK == 12
    Rank = 'Q';
    concat = [Rank Card '.jpg'];
    ccard = imread(concat);
elseif RANK == 13
    Rank = 'K';
    concat = [Rank Card '.jpg'];
    ccard = imread(concat);
else
    Rank = RANK;
    concat = [num2str(Rank) Card '.jpg'];
    ccard = imread(concat);
end

% figure;
% imshow(ccard);
