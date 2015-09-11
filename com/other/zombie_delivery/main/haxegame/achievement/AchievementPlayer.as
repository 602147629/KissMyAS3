package haxegame.achievement
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import flash.*;

    public class AchievementPlayer extends Object
    {
        public var set:Array;
        public var mainFunction:Function;
        public var layer:IDisplayObjectContainer;
        public var displayedAchievement:Achievement;

        public function AchievementPlayer(param1:IDisplayObjectContainer = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            set = [];
            mainFunction = wait;
            return;
        }// end function

        public function wait() : void
        {
            return;
        }// end function

        public function setAchievement(param1:AchievementType) : void
        {
            var _loc_2:* = new Achievement(layer, param1);
            set.push(_loc_2);
            if (!Reflect.compareMethods(mainFunction, play))
            {
                initializeToPlay();
            }
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            return;
        }// end function

        public function play() : void
        {
            if (!displayedAchievement.movieclip.isLastFrame())
            {
                displayedAchievement.movieclip.nextFrame();
            }
            else
            {
                destroyToPlay();
            }
            return;
        }// end function

        public function initializeToPlay() : void
        {
            displayedAchievement = set.shift();
            displayedAchievement.show();
            mainFunction = play;
            return;
        }// end function

        public function destroyToPlay() : void
        {
            displayedAchievement.hide();
            if (set.length > 0)
            {
                initializeToPlay();
            }
            else
            {
                mainFunction = wait;
            }
            return;
        }// end function

    }
}
