%This function is called when the Hit, Stand and Double boxes are pressed
function BJActionSelect(Action)
    global BJPLAYER
    BJPLAYER.hitorstand = Action; %Save which button was pressed
    uiresume(gcf);  %Un-pause
end