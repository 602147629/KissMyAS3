package haxegame.achievement
{
    import flash.*;

    final public class AchievementType extends Object
    {
        public var tag:String;
        public var index:int;
        public var params:Array;
        public const __enum__:Boolean = true;
        public static const __isenum:Boolean = true;
        public static var __constructs__:Object;
        public static var ZOMBIE_SECRET:AchievementType;
        public static var ZOMBIE:AchievementType;
        public static var SCORE_SECRET:AchievementType;
        public static var SCORE:AchievementType;
        public static var PLAY_COUNT_SECRET:AchievementType;
        public static var PLAY_COUNT:AchievementType;
        public static var HUMAN_SECRET:AchievementType;
        public static var HUMAN:AchievementType;
        public static var COMBO_SECRET:AchievementType;
        public static var COMBO:AchievementType;

        public function AchievementType(param1:String, param2:int, param3) : void
        {
            tag = param1;
            index = param2;
            params = param3;
            return;
        }// end function

        final public function toString() : String
        {
            return Boot.enum_to_string(this);
        }// end function

    }
}
