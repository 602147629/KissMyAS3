package effect
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;

    public class EffectAfterImagePutParts extends Sprite
    {
        private const _ALPHA_VANISH_TIME:Number = 0.1;
        private var _bmp:Bitmap;
        private var _time:Number;
        private var _scale:Number;
        private var _scaleAdd:Number;
        private var _vec:Point;
        private var _vecAdd:Point;
        private var _bEnd:Boolean;
        private var _mtx:Matrix;
        private var _offset:Point;

        public function EffectAfterImagePutParts(param1:DisplayObjectContainer, param2:Number)
        {
            this._scale = 1;
            this._scaleAdd = 0;
            var _loc_3:* = new BitmapData(param1.width, param1.height, true, 0);
            var _loc_4:* = param1.transform.pixelBounds;
            var _loc_5:* = param1.transform.concatenatedMatrix.clone();
            param1.transform.concatenatedMatrix.clone().invert();
            var _loc_6:* = _loc_5.transformPoint(_loc_4.topLeft);
            var _loc_7:* = new Point(0, 0);
            this._offset = _loc_6.clone();
            var _loc_8:* = new Matrix();
            new Matrix().translate(-_loc_6.x, -_loc_6.y);
            _loc_3.draw(param1, _loc_8);
            _loc_8.identity();
            _loc_8.translate(_loc_6.x, _loc_6.y);
            _loc_8.translate(_loc_7.x, _loc_7.y);
            this._bmp = new Bitmap(_loc_3);
            this._bmp.transform.matrix = _loc_8;
            this._time = param2;
            this._vec = new Point();
            this._vecAdd = new Point();
            this._mtx = _loc_8.clone();
            this.addChild(this._bmp);
            return;
        }// end function

        public function get time() : Number
        {
            return this._time;
        }// end function

        public function set scaleAdd(param1:Number) : void
        {
            this._scaleAdd = param1;
            return;
        }// end function

        public function set vecAdd(param1:Point) : void
        {
            this._vecAdd = param1.clone();
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function addBlur(param1:int, param2:int) : void
        {
            this._bmp.filters = [new BlurFilter(param1, param2)];
            return;
        }// end function

        public function setBlendMode(param1:String) : void
        {
            this._bmp.blendMode = param1;
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = this._bmp.bitmapData;
            _loc_1.dispose();
            if (this._bmp.parent)
            {
                this._bmp.parent.removeChild(this._bmp);
            }
            this._bmp = null;
            if (this.parent != null)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bEnd)
            {
                return;
            }
            this._time = this._time - param1;
            this._vec.x = this._vec.x + this._vecAdd.x * param1;
            this._vec.y = this._vec.y + this._vecAdd.y * param1;
            this._scale = this._scale + this._scaleAdd * param1;
            var _loc_2:* = this._mtx.clone();
            var _loc_3:* = new Matrix();
            _loc_3.translate(this._offset.x - _loc_2.tx, this._offset.y - _loc_2.ty);
            _loc_3.scale(this._scale, this._scale);
            _loc_3.translate(-this._offset.x + _loc_2.tx, -this._offset.y + _loc_2.ty);
            _loc_3.translate(this._vec.x, this._vec.y);
            _loc_2.concat(_loc_3);
            this._bmp.transform.matrix = _loc_2;
            if (this._time < 0)
            {
                this._bEnd = true;
                this._bmp.visible = false;
            }
            return;
        }// end function

    }
}
