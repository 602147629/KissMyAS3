package utility
{
    import flash.display.*;

    public class ColorScreen extends Shape
    {

        public function ColorScreen(param1:DisplayObjectContainer, param2:uint = 0)
        {
            this.graphics.beginFill(param2);
            this.graphics.drawRect(0, 0, Constant.SCREEN_WIDTH, Constant.SCREEN_HEIGHT);
            this.graphics.endFill();
            param1.addChild(this);
            return;
        }// end function

        public function release() : void
        {
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

    }
}
