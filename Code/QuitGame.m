function QuitGame
    global QUITGAME;
%     set(handles.QuitButton,'UserData',1);
    QUITGAME = 1;
    uiresume(gcf);
end