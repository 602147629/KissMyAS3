package haxegame.game.background
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import flash.*;

    public class Background extends Object
    {
        public var view:BackgroundView;

        public function Background(param1:IDisplayObjectContainer = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            view = new BackgroundView();
            param1.addChild(view);
            return;
        }// end function

    }
}
