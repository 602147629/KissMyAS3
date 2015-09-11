package haxegame.scene
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import flash.*;
    import flash.net.*;

    public class Menu extends Object
    {
        public var view:MenuView;
        public var settingButton:MouseEventChecker;
        public var layer:IDisplayObjectContainer;
        public var gameDataButton:MouseEventChecker;
        public var closeButton:MouseEventChecker;
        public var aboutButton:MouseEventChecker;

        public function Menu(param1:IDisplayObjectContainer = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            view = new MenuView();
            settingButton = CommonClassSet.createMouseEventChecker(view.settingButton);
            gameDataButton = CommonClassSet.createMouseEventChecker(view.gameDataButton);
            aboutButton = CommonClassSet.createMouseEventChecker(view.aboutButton);
            closeButton = CommonClassSet.createMouseEventChecker(view.closeButton);
            return;
        }// end function

        public function show() : void
        {
            layer.addChild(view);
            return;
        }// end function

        public function run() : void
        {
            if (aboutButton.isDowned())
            {
                Lib.getURL(new URLRequest("http://www.deeg-entertainment.jp/" + "app/"), "_blank");
            }
            settingButton.reset();
            gameDataButton.reset();
            aboutButton.reset();
            closeButton.reset();
            return;
        }// end function

        public function hide() : void
        {
            layer.removeChild(view);
            return;
        }// end function

    }
}
