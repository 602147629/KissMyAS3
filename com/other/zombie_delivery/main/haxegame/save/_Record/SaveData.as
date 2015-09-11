package haxegame.save._Record
{
    import flash.*;
    import flash.system.*;
    import haxegame.save.*;

    public class SaveData extends Object
    {
        public var zombieSecretAchievement:Boolean;
        public var zombieAchievement:Boolean;
        public var zombie:int;
        public var scoreSecretAchievement:Boolean;
        public var scoreAchievement:Boolean;
        public var playCountSecretAchievement:Boolean;
        public var playCountAchievement:Boolean;
        public var playCount:int;
        public var maxCombo:int;
        public var language:String;
        public var humanSecretAchievement:Boolean;
        public var humanAchievement:Boolean;
        public var human:int;
        public var highScore:int;
        public var comboSecretAchievement:Boolean;
        public var comboAchievement:Boolean;
        public var bgm:BGM;
        public static var JAPANESE:String;

        public function SaveData() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            setLanguage();
            bgm = BGM.ON;
            highScore = 0;
            maxCombo = 0;
            zombie = 0;
            human = 0;
            playCount = 0;
            comboAchievement = false;
            scoreAchievement = false;
            zombieAchievement = false;
            humanAchievement = false;
            playCountAchievement = false;
            comboSecretAchievement = false;
            scoreSecretAchievement = false;
            zombieSecretAchievement = false;
            humanSecretAchievement = false;
            playCountSecretAchievement = false;
            return;
        }// end function

        public function setLanguage() : void
        {
            if (Capabilities.language == "ja")
            {
                language = "ja";
            }
            else
            {
                language = "eng";
            }
            return;
        }// end function

    }
}
