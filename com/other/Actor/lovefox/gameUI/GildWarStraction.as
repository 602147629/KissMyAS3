package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import lovefox.component.*;

    public class GildWarStraction extends Window
    {

        public function GildWarStraction(param1:DisplayObjectContainer = null, param2:Number = 200, param3:Number = 100)
        {
            super(param1, param2, param3);
            this.resize(400, 350);
            this.title = Config.language("GildWarStraction", 1);
            var _loc_4:* = new CanvasUI(this, 0, 22, 385, 320);
            var _loc_5:* = new Sprite();
            new Sprite().graphics.beginFill(16777215, 0.4);
            _loc_5.graphics.drawRoundRect(10, 0, 380, 580, 5);
            _loc_5.graphics.endFill();
            _loc_4.addChildUI(_loc_5);
            var _loc_6:* = new Label(_loc_5, 10, 5, Config._straction);
            return;
        }// end function

    }
}
