package effect
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;

    public class EffectDustParts extends EffectBase
    {
        private const _VANISH_TIME:Number = 0.3;
        private const _MAX_ALPHA:Number = 0.3;
        private var _bmp:Bitmap;
        private var _bmp2:Bitmap;
        private var _pos:Point;
        private var _vec:Point;
        private var _scale:Number;
        private var _liveTime:Number;
        public static const RESOURCE_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "Dust01.png";

        public function EffectDustParts(param1:DisplayObjectContainer, param2:Point, param3:Point, param4:Number)
        {
            super(null, null, null);
            this._bmp = ResourceManager.getInstance().createBitmap(RESOURCE_PATH);
            this._bmp.alpha = this._MAX_ALPHA;
            this._bmp2 = new Bitmap(this._bmp.bitmapData.clone());
            this._bmp2.alpha = this._MAX_ALPHA;
            this._bmp2.scaleX = -1;
            param1.addChild(this._bmp);
            param1.addChild(this._bmp2);
            this._pos = param2.clone();
            this._vec = param3.clone();
            this._scale = 0.5;
            this._pos.x = this._pos.x - this._scale * this._bmp.width * 0.25;
            this.updatePosition();
            this._liveTime = param4;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._bmp)
            {
                if (this._bmp.parent)
                {
                    this._bmp.parent.removeChild(this._bmp);
                }
                if (this._bmp.bitmapData)
                {
                    this._bmp.bitmapData.dispose();
                }
            }
            this._bmp = null;
            if (this._bmp2)
            {
                if (this._bmp2.parent)
                {
                    this._bmp2.parent.removeChild(this._bmp2);
                }
                if (this._bmp2.bitmapData)
                {
                    this._bmp2.bitmapData.dispose();
                }
            }
            this._bmp2 = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            this._liveTime = this._liveTime - param1;
            this._scale = this._scale + 0.5 * param1;
            this._pos.x = this._pos.x + this._vec.x * param1;
            this._pos.y = this._pos.y + this._vec.y * param1;
            this.updatePosition();
            var _loc_2:* = 1;
            if (this._liveTime <= this._VANISH_TIME)
            {
                _loc_2 = this._liveTime / this._VANISH_TIME;
                if (_loc_2 < 0)
                {
                    _loc_2 = 0;
                }
            }
            this._bmp.alpha = _loc_2 * this._MAX_ALPHA;
            this._bmp2.alpha = this._bmp.alpha;
            this._vec.x = this._vec.x - this._vec.x * 5 * param1;
            this._vec.y = this._vec.y - this._vec.y * 5 * param1;
            return;
        }// end function

        private function updatePosition() : void
        {
            this._bmp.scaleX = this._scale * 0.7;
            this._bmp.scaleY = this._scale;
            this._bmp2.scaleX = this._scale * -1 * 0.7;
            this._bmp2.scaleY = this._scale;
            this._bmp.x = this._pos.x;
            this._bmp.y = this._pos.y + (-this._bmp.height) * 0.5;
            this._bmp2.x = this._bmp.x * -1;
            this._bmp2.y = this._bmp.y;
            return;
        }// end function

        override public function isEnd() : Boolean
        {
            return this._liveTime <= 0;
        }// end function

    }
}
