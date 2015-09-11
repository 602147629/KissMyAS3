package haxegame.scene
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import flash.*;

    public class ExtraHeaderFooter extends Object
    {
        public var view:ExtraHeaderFooterView;
        public var layer:IDisplayObjectContainer;

        public function ExtraHeaderFooter(param1:IDisplayObjectContainer = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            view = new ExtraHeaderFooterView();
            param1.addChild(view);
            return;
        }// end function

    }
}
