package lovefox.gui
{
    import flash.display.*;

    public class GPanel extends Sprite
    {
        private var _bmp:Bitmap;

        public function GPanel(param1)
        {
            this._bmp = new Bitmap(BitmapLoader.pick(param1.dir), PixelSnapping.AUTO, true);
            addChild(this._bmp);
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        public function destroy()
        {
            this._bmp.bitmapData.dispose();
            return;
        }// end function

    }
}
