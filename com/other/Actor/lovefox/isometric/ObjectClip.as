package lovefox.isometric
{
    import flash.display.*;
    import flash.events.*;

    public class ObjectClip extends Sprite
    {
        public var _bitmap:Bitmap;
        public var _bitmapArray:Array;
        private var _currFrame:int;
        private var _frames:uint;
        private var _frameSkip:uint;
        private var _frameLeft:uint;
        public var _width:uint;
        public var _height:uint;
        public var _yOff:int;
        public var _data:XML;
        private var _tile:Object;
        private static var _buff:Object = {};

        public function ObjectClip(param1:XML, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            this._data = param1;
            this._tile = param2;
            this._yOff = parseInt(this._data.yOff);
            this._frames = parseInt(this._data.frames);
            this._frameSkip = parseInt(this._data.frameSkip);
            _loc_4 = BitmapLoader.pick(this._data.dir);
            this._width = parseInt(_loc_4.width) / this._frames;
            this._height = parseInt(_loc_4.height);
            this._bitmapArray = [];
            _loc_3 = 0;
            while (_loc_3 < this._frames)
            {
                
                this._bitmapArray[_loc_3] = new BitmapData(this._width, this._height, true, 0);
                this._bitmapArray[_loc_3].copyPixels(_loc_4, new Rectangle(this._width * _loc_3, 0, this._width * (_loc_3 + 1), this._height), Config._point0, null, null, true);
                _loc_3 = _loc_3 + 1;
            }
            _loc_4.dispose();
            this.init();
            return;
        }// end function

        public function init()
        {
            this._bitmap = new Bitmap();
            if (this._tile != null)
            {
                this._bitmap.x = (-this._width) / 2;
                this._bitmap.y = -this._yOff;
            }
            this._currFrame = 0;
            this._frameLeft = this._frameSkip;
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame, false, 0, true);
            return;
        }// end function

        public function destroy()
        {
            var _loc_1:* = undefined;
            this.hide();
            _loc_1 = 0;
            while (_loc_1 < this._frames)
            {
                
                this._bitmapArray[_loc_1].dispose();
                _loc_1 = _loc_1 + 1;
            }
            if (this._tile != null)
            {
                if (this._tile._object == this)
                {
                    this._tile._object = null;
                }
            }
            return;
        }// end function

        public function hide()
        {
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            if (this._bitmap.parent == this)
            {
                removeChild(this._bitmap);
            }
            return;
        }// end function

        public function show()
        {
            if (this._bitmap.parent != this)
            {
                removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                addEventListener(Event.ENTER_FRAME, this.onEnterFrame, false, 0, true);
                addChild(this._bitmap);
                this._frameLeft = 0;
                this.playAnimation();
            }
            return;
        }// end function

        private function onEnterFrame(event:Event)
        {
            this.playAnimation();
            return;
        }// end function

        private function playAnimation()
        {
            var _loc_1:* = undefined;
            if (this._frameLeft <= 0)
            {
                this._frameLeft = this._frameSkip;
                var _loc_2:* = this;
                var _loc_3:* = this._currFrame + 1;
                _loc_2._currFrame = _loc_3;
                if (this._currFrame >= this._frames)
                {
                    this._currFrame = 0;
                }
                this._bitmap.bitmapData = this._bitmapArray[this._currFrame];
            }
            else
            {
                var _loc_2:* = this;
                var _loc_3:* = this._frameLeft - 1;
                _loc_2._frameLeft = _loc_3;
            }
            if (this._tile != null)
            {
                _loc_1 = this._tile._map.mapToTile(this._tile._map);
                if (Math.abs(this._tile._x - _loc_1._x) > this._tile._map._iso._size || Math.abs(this._tile._y - _loc_1._y) > this._tile._map._iso._size)
                {
                    this.hide();
                }
            }
            return;
        }// end function

    }
}
