package script
{

    public class ScriptComConstant extends Object
    {
        public static const TRIGGER_PIECE_LANDING:int = 1;
        public static const TRIGGER_BEFORE_OF_TITLE:int = 2;
        public static const TRIGGER_AFTER_OF_TITLE:int = 3;
        public static const TRIGGER_BEFORE_OF_BATTLE:int = 4;
        public static const TRIGGER_AFTER_OF_BATTLE:int = 5;
        public static const TRIGGER_AFTER_OF_BATTLE_WIN:int = 6;
        public static const TRIGGER_AFTER_OF_BATTLE_LOSE:int = 7;
        public static const TRIGGER_IN_SCREEN:int = 100;
        public static const TRIGGER_EMPEROR_SELECT:int = 200;
        public static const TRIGGER_SPECIAL_SCRIPT:int = 300;
        public static const BALLOON_TYPE1:int = 0;
        public static const BALLOON_TYPE2:int = 1;
        public static const BALLOON_TYPE3:int = 2;
        public static const BALLOON_TYPE4:int = 3;
        public static const BALLOON_TYPE5:int = 4;
        public static const MESSAGE_SPEED_NORMAL:int = 0;
        public static const MESSAGE_SPEED_FAST:int = 1;
        public static const MESSAGE_SPEED_SLOW:int = 2;
        public static const SCRIPT_COMMENT:String = "Comment";
        public static const SCRIPT_EVENT_START:String = "EventStart";
        public static const SCRIPT_EVENT_END:String = "EventEnd";
        public static const SCRIPT_INFORMATION:String = "Information";
        public static const SCRIPT_CHARACTER_SET:String = "CharacterSet";
        public static const SCRIPT_CHARACTER_ANIMATION:String = "CharacterAnimation";
        public static const SCRIPT_CHARACTER_DISPLAY:String = "CharacterDisplay";
        public static const SCRIPT_CHARACTER_DISPLAY_TOP:String = "CharacterDisplayTop";
        public static const SCRIPT_CHARACTER_PRIORITY_TOP:String = "CharacterPriorityTop";
        public static const SCRIPT_CHARACTER_DIRECTION:String = "CharacterDirection";
        public static const SCRIPT_CHARACTER_MOVE:String = "CharacterMove";
        public static const SCRIPT_CHARACTER_MOVE_ALPHA:String = "CharacterMoveAlpha";
        public static const SCRIPT_CHARACTER_ERASE_FLASH:String = "CharacterEraseFlash";
        public static const SCRIPT_CHARACTER_FADE_OUT:String = "CharacterFadeOut";
        public static const SCRIPT_CHARACTER_FADE_IN:String = "CharacterFadeIn";
        public static const SCRIPT_CHARACTER_ALPHA:String = "CharacterAlpha";
        public static const SCRIPT_BACKGROUND_SET:String = "BackgroundSet";
        public static const SCRIPT_BACKGROUND_DISPLAY:String = "BackgroundDisplay";
        public static const SCRIPT_BACKGROUND_FADE_OUT:String = "BackgroundFadeOut";
        public static const SCRIPT_BACKGROUND_FADE_IN:String = "BackgroundFadeIn";
        public static const SCRIPT_BACKGROUND_ALPHA:String = "BackgroundAlpha";
        public static const SCRIPT_BACKGROUND_SCROLL:String = "BackgroundScroll";
        public static const SCRIPT_BGM_SET:String = "BgmSet";
        public static const SCRIPT_BGM_PLAY:String = "BgmPlay";
        public static const SCRIPT_BGM_STOP:String = "BgmStop";
        public static const SCRIPT_SE_SET:String = "SeSet";
        public static const SCRIPT_SE_PLAY:String = "SePlay";
        public static const SCRIPT_MOVIE_SET:String = "MovieSet";
        public static const SCRIPT_MOVIE_PLAY:String = "MoviePlay";
        public static const SCRIPT_MOVIE_PLAY_2:String = "MoviePlay2";
        public static const SCRIPT_LOAD_WAIT:String = "LoadWait";
        public static const SCRIPT_BALLOON_SET:String = "BalloonSet";
        public static const SCRIPT_BALLOON_SET_CHARACTER:String = "BalloonSetCharacter";
        public static const SCRIPT_BALLOON_SET_MESSAGE_SE:String = "BalloonSetMessageSe";
        public static const SCRIPT_BALLOON_SET_MESSAGE_SPEED:String = "BalloonSetMessageSpeed";
        public static const SCRIPT_BALLOON_SET_MESSAGE_WAIT:String = "BalloonSetMessageWait";
        public static const SCRIPT_BALLOON_SPEECH:String = "BalloonSpeech";
        public static const SCRIPT_BALLOON_DISPLAY:String = "BalloonDisplay";
        public static const SCRIPT_BALLOON_CLOSE:String = "BalloonClose";
        public static const SCRIPT_NARRATION_SET:String = "NarrationSet";
        public static const SCRIPT_NARRATION_SET_MESSAGE_SE:String = "NarrationSetMessageSe";
        public static const SCRIPT_NARRATION_SET_MESSAGE_SPEED:String = "NarrationSetMessageSpeed";
        public static const SCRIPT_NARRATION_SET_MESSAGE_WAIT:String = "NarrationSetMessageWait";
        public static const SCRIPT_NARRATION_MESSAGE:String = "NarrationMessage";
        public static const SCRIPT_NARRATION_DISPLAY:String = "NarrationDisplay";
        public static const SCRIPT_NARRATION_CLOSE:String = "NarrationClose";
        public static const SCRIPT_MONOLOGUE:String = "Monologue";
        public static const SCRIPT_MONOLOGUE2:String = "Monologue2";
        public static const SCRIPT_MONOLOGUE3:String = "Monologue3";
        public static const SCRIPT_LABEL:String = "Label";
        public static const SCRIPT_WAIT:String = "Wait";
        public static const SCRIPT_SELECT:String = "Select";
        public static const SCRIPT_SELECT_PASSIVE:String = "SelectPassive";
        public static const SCRIPT_AUTO_SELECT:String = "AutoSelect";
        public static const SCRIPT_DECIDE_SELECT:String = "DecideSelect";
        public static const SCRIPT_GOTO:String = "Goto";
        public static const SCRIPT_FADE_OUT:String = "FadeOut";
        public static const SCRIPT_FADE_IN:String = "FadeIn";
        public static const SCRIPT_FADE_OUT_ALPHA:String = "FadeOutAlpha";
        public static const SCRIPT_FADE_IN_ALPHA:String = "FadeInAlpha";
        public static const SCRIPT_SHAKE:String = "Shake";
        public static const SCRIPT_SHAKE_LOOP:String = "ShakeLoop";
        public static const SCRIPT_SHAKE_END:String = "ShakeEnd";
        public static const SCRIPT_HIPPOPOTAMUS_CHECK:String = "HippopotamusCheck";
        public static const SCRIPT_IF_FLAG:String = "IfFlag";
        public static const SCRIPT_IF_FLAG_AND:String = "IfFlagAnd";
        public static const SCRIPT_IF_FLAG_OR:String = "IfFlagOr";
        public static const SCRIPT_FLAG:String = "Flag";
        public static const SCRIPT_IF_QUEST_FLAG_AND:String = "IfQuestFlagAnd";
        public static const SCRIPT_IF_QUEST_FLAG_OR:String = "IfQuestFlagOr";
        public static const SCRIPT_QUEST_FLAG:String = "QuestFlag";
        public static const SCRIPT_ROUTE_SELECT:String = "RouteSelect";
        public static const SCRIPT_PAYMENT_EVENT_SELECT:String = "PaymentEventSelect";
        public static const SCRIPT_PAYMENT_EVENT_END:String = "PaymentEventEnd";
        public static const COMMAND_CATEGORY_NONE:int = 0;
        public static const COMMAND_CATEGORY_DISP:int = 1;
        public static const COMMAND_CATEGORY_SET:int = 2;
        public static const COMMAND_CATEGORY_WAIT:int = 3;
        public static const COMMAND_SKIP_RESULT_FINISH:int = 0;
        public static const COMMAND_SKIP_RESULT_WAIT:int = 1;
        public static const COMMAND_SKIP_RESULT_DONT:int = 2;

        public function ScriptComConstant()
        {
            return;
        }// end function

    }
}
