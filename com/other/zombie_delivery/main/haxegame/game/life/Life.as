package haxegame.game.life
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import flash.*;
    import flash.display.*;
    import haxegame.game.*;

    public class Life extends Object
    {
        public var view:LifeView;
        public var num:int;
        public var layer:IDisplayObjectContainer;
        public static var MAX:int;

        public function Life(param1:IDisplayObjectContainer = undefined, param2:GameGuideView = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            view = new LifeView();
            var _loc_3:* = view;
            var _loc_4:* = param2.life;
            _loc_3.x = _loc_4.x;
            _loc_3.y = _loc_4.y;
            param1.addChild(view);
            initialize();
            return;
        }// end function

        public function isZero() : Boolean
        {
            return num <= 0;
        }// end function

        public function initialize() : void
        {
            num = 3;
            view.life3.visible = true;
            view.life2.visible = true;
            view.life1.visible = true;
            return;
        }// end function

        public function decrement() : void
        {
            (num - 1);
            if (num == 2)
            {
                view.life3.visible = false;
            }
            else if (num == 1)
            {
                view.life2.visible = false;
            }
            else if (num == 0)
            {
                view.life1.visible = false;
            }
            return;
        }// end function

    }
}
