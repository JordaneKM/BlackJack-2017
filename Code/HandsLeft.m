function HandsLeft(handles)

%function for updating the value of Bankroll.HandsLeft when the
%HandsLeftBox is modified

global BANKROLL;
BANKROLL.HandsLeft = str2double(get(handles.HandsLeftBox,'string'));