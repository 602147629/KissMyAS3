package haxegame.game
{
    import flash.*;
    import flash.display.*;
    import haxegame.game.life.*;
    import haxegame.game.zombie.*;

    public class GameGuideView extends Sprite
    {
        public var zombieCombo:MovieClip;
        public var zombie:NeutralView;
        public var scorePosition:MovieClip;
        public var rightGoalArea:MovieClip;
        public var nextTurn:MovieClip;
        public var life:LifeView;
        public var leftGoalArea:MovieClip;
        public var humanCombo:MovieClip;
        public var human:haxegame.game.human::NeutralView;

        public function GameGuideView() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            return;
        }// end function

    }
}
