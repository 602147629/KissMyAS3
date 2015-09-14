package effect
{
    import flash.display.*;
    import flash.geom.*;

    public class EffectParticleBossMainBase extends Object
    {
        protected var _setTime:Number;
        protected var _waitTime:Number;
        protected var _bmpData:BitmapData;
        protected var _bmp:Bitmap;
        protected var _cbParticleCreate:Function;
        protected var _aParticle:Array;
        protected var _offset:Point;

        public function EffectParticleBossMainBase(param1:BitmapData, param2:DisplayObjectContainer, param3:Function, param4:Number)
        {
            this._setTime = param4;
            this._waitTime = 0;
            this._aParticle = [];
            this._cbParticleCreate = param3;
            if (param1 == null)
            {
                this._bmpData = new BitmapData(Constant.SCREEN_WIDTH_HALF + 200, Constant.SCREEN_HEIGHT, true, 0);
            }
            else
            {
                this._bmpData = param1;
            }
            this._bmp = new Bitmap(this._bmpData);
            this._bmp.x = (-this._bmpData.width) * 0.5;
            this._bmp.y = -this._bmpData.height;
            param2.addChild(this._bmp);
            this._offset = new Point(-this._bmp.x, -this._bmp.y);
            return;
        }// end function

        public function get waitTime() : Number
        {
            return this._waitTime;
        }// end function

        public function set waitTime(param1:Number) : void
        {
            this._waitTime = param1;
            return;
        }// end function

        public function get bmpData() : BitmapData
        {
            return this._bmpData;
        }// end function

        public function clearBmp() : void
        {
            this.removeBmp();
            this._bmpData = null;
            return;
        }// end function

        public function get offset() : Point
        {
            return this._offset;
        }// end function

        public function setTransform(param1:Number, param2:Number) : void
        {
            this._bmp.x = this._bmp.x + param1;
            this._bmp.y = this._bmp.y + param2;
            this._offset.x = this._offset.x - param1;
            this._offset.y = this._offset.y - param2;
            return;
        }// end function

        private function removeBmp() : void
        {
            if (this._bmp != null)
            {
                if (this._bmp.parent)
                {
                    this._bmp.parent.removeChild(this._bmp);
                }
                this._bmp.bitmapData = null;
            }
            this._bmp = null;
            return;
        }// end function

        public function release() : void
        {
            if (this._bmpData != null)
            {
                this._bmpData.dispose();
            }
            this._bmpData = null;
            this.removeBmp();
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this._waitTime = this._waitTime - param1;
            if (this._waitTime < 0)
            {
                this._waitTime = this._setTime;
                if (this._cbParticleCreate != null)
                {
                    this._cbParticleCreate();
                }
            }
            this._bmpData.lock();
            this._bmpData.fillRect(new Rectangle(0, 0, this._bmpData.width, this._bmpData.height), 0);
            this.controlParticle(param1);
            this._bmpData.unlock();
            return;
        }// end function

        protected function controlParticle(param1:Number) : void
        {
            return;
        }// end function

    }
}
