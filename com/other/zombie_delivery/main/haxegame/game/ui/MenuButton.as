package haxegame.game.ui
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import com.dango_itimi.utils.*;
    import flash.*;

    public class MenuButton extends Object
    {
        public var view:MenuButtonView;
        public var mouseEventChecker:MouseEventChecker;
        public var mainFunction:Function;
        public var layer:IDisplayObjectContainer;
        public var hitArea:RectangleUtil;

        public function MenuButton(param1:MouseEventChecker = undefined, param2:IDisplayObjectContainer = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            mouseEventChecker = param1;
            layer = param2;
            view = new MenuButtonView();
            hitArea = DisplayObjectConverter.toRectangleUtil(view.area);
            param2.addChild(view);
            initialize();
            return;
        }// end function

        public function waitToClickButton() : void
        {
            if (!mouseEventChecker.isUpped())
            {
                return;
            }
            var _loc_1:* = mouseEventChecker.getUppedLocalPoint();
            if (hitArea.hitTestPoint(_loc_1.x, _loc_1.y))
            {
                mainFunction = click;
            }
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            return;
        }// end function

        public function isClicked() : Boolean
        {
            return Reflect.compareMethods(mainFunction, click);
        }// end function

        public function initialize() : void
        {
            mainFunction = waitToClickButton;
            return;
        }// end function

        public function hide() : void
        {
            layer.removeChild(view);
            return;
        }// end function

        public function click() : void
        {
            return;
        }// end function

    }
}
