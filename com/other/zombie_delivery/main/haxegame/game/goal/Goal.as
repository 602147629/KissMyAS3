package haxegame.game.goal
{
    import com.dango_itimi.as3_and_createjs.utils.*;
    import com.dango_itimi.utils.*;
    import flash.*;
    import haxegame.game.*;

    public class Goal extends Object
    {
        public var rightArea:RectangleUtil;
        public var leftArea:RectangleUtil;

        public function Goal(param1:GameGuideView = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            leftArea = DisplayObjectConverter.toRectangleUtil(param1.leftGoalArea);
            rightArea = DisplayObjectConverter.toRectangleUtil(param1.rightGoalArea);
            return;
        }// end function

    }
}
