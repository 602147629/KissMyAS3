package effect
{
    import flash.display.*;
    import flash.geom.*;

    public class EffectAfterImage extends EffectBase
    {
        private var _targetMc:Sprite;
        private var _bmpData:BitmapData;
        private var _bmp:Bitmap;
        private var _rate:Number = 0;
        private var _targetId:int = 0;
        private var _bDraw:Boolean;

        public function EffectAfterImage(param1:DisplayObjectContainer, param2:Sprite, param3:Number, param4:int = 0)
        {
            this._targetMc = param2;
            this._rate = param3;
            super(null, null);
            this._bDraw = true;
            this._targetId = param4;
            this._bmpData = new BitmapData(Main.GetProcess().stage.width, Main.GetProcess().height, true, 0);
            this._bmp = new Bitmap(this._bmpData);
            param1.addChild(this._bmp);
            return;
        }// end function

        public function set bDraw(param1:Boolean) : void
        {
            this._bDraw = param1;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            this._bmpData.dispose();
            this._bmpData = null;
            if (this._bmp.parent)
            {
                this._bmp.parent.removeChild(this._bmp);
                this._bmp.bitmapData = null;
            }
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            this._bmpData.colorTransform(this._bmpData.rect, new ColorTransform(1, 1, 1, this._rate));
            if (this._bDraw)
            {
                if (this._targetId == 0)
                {
                    this._bmpData.draw(this._targetMc, new Matrix(1, 0, 0, 1, this._targetMc.x, this._targetMc.y));
                }
                else
                {
                    this._bmpData.draw(this._targetMc, new Matrix(-1, 0, 0, -1, this._targetMc.x, this._targetMc.y));
                }
            }
            return;
        }// end function

    }
}
