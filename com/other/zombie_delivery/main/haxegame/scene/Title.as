package haxegame.scene
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.*;

    public class Title extends Object
    {
        public var viewMovieClipUtil:IMovieClipUtil;
        public var view:TitleView;
        public var tutorialButton:MouseEventChecker;
        public var menuButton:MouseEventChecker;
        public var mainFunction:Function;
        public var layer:IDisplayObjectContainer;
        public var gameStartButton:MouseEventChecker;

        public function Title(param1:IDisplayObjectContainer = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            view = new TitleView();
            view.backgroundx2.visible = false;
            gameStartButton = CommonClassSet.createMouseEventChecker(view.gameStartButton);
            tutorialButton = CommonClassSet.createMouseEventChecker(view.tutorialButton);
            menuButton = CommonClassSet.createMouseEventChecker(view.menuButton);
            return;
        }// end function

        public function show() : void
        {
            layer.addChild(view);
            return;
        }// end function

        public function run() : void
        {
            gameStartButton.reset();
            tutorialButton.reset();
            menuButton.reset();
            return;
        }// end function

        public function hide() : void
        {
            layer.removeChild(view);
            return;
        }// end function

    }
}
