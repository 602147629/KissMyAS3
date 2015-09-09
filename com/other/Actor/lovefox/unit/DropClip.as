package lovefox.unit
{
    import flash.display.*;
    import flash.geom.*;
    import lovefox.buffer.*;
    import lovefox.gui.*;

    public class DropClip extends Sprite
    {
        private var _poolPushed:Boolean = false;
        public var _fileHead:Object;
        public var _iconURL:Object;
        public var _bitmap:Bitmap;
        public var _bitmapData:BitmapData;
        public var _bitmapRect:Rectangle;
        public var _yOff:int;
        public var _width:Object = 0;
        public var _height:Object = 0;
        public var _ySpeed:Object = -4;
        public var _shiningClip:GClip;
        private var _destroyed:Object = false;
        private var _bottomHeight:Object = 2;
        private var _loader:BitmapLoader;
        public var _bitmapRectY:uint;
        private var _shadowScale:Number = 1;
        private var _z:Number = 0;
        public static var _shadowOn:Boolean = true;
        private static var _objectPool:Array = [];

        public function DropClip(param1:String)
        {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this._shiningClip = GClip.newGClip("shining");
            this._fileHead = param1.substr(0, 2);
            this._iconURL = Config.findIconURL(param1);
            var _loc_2:* = BitmapLoader.pick(this._iconURL);
            if (_loc_2 != null)
            {
                this.handleLoadComplete(null, _loc_2);
            }
            else
            {
                if (this._loader != null)
                {
                    this._loader.removeEventListener("complete", this.handleLoadComplete);
                    this._loader.removeEventListener("complete", this.handleLoadComplete);
                }
                this._loader = BitmapLoader.newBitmapLoader();
                this._loader.removeEventListener("complete", this.handleLoadComplete);
                this._loader.addEventListener("complete", this.handleLoadComplete);
                this._loader.load([this._iconURL]);
            }
            return;
        }// end function

        private function handleLoadComplete(param1 = null, param2 = null)
        {
            if (param1 != null)
            {
                param1.target.removeEventListener("complete", this.handleLoadComplete);
            }
            if (this._destroyed)
            {
                if (param2 != null)
                {
                    param2.dispose();
                }
                return;
            }
            if (param2 == null)
            {
                param2 = BitmapLoader.pick(this._iconURL);
            }
            var _loc_3:* = param2.getColorBoundsRect(4278190080, 0, false);
            if (_loc_3.width == 0 || _loc_3.height == 0)
            {
                param2.dispose();
                return;
            }
            this._bitmapData = new BitmapData(_loc_3.width, _loc_3.height, true, 0);
            this._bitmapData.copyPixels(param2, _loc_3, Config._point0);
            param2.dispose();
            if (this._bitmap == null)
            {
                this._bitmap = new Bitmap(this._bitmapData, "auto", true);
            }
            else
            {
                this._bitmap.bitmapData = this._bitmapData;
                var _loc_4:* = 1;
                this._bitmap.scaleY = 1;
                this._bitmap.scaleX = _loc_4;
            }
            if (this._fileHead == "15" || this._fileHead == "17" || this._fileHead == "18" || this._fileHead == "19" || this._fileHead == "20" || this._fileHead == "21" || this._fileHead == "22")
            {
                var _loc_4:* = 0.7;
                this._bitmap.scaleY = 0.7;
                this._bitmap.scaleX = _loc_4;
            }
            this._bitmapRect = new Rectangle(0, 0, this._bitmap.width, this._bitmap.height);
            this._width = this._bitmapRect.width;
            this._height = this._bitmapRect.height;
            this._bitmapRectY = this._height;
            this._yOff = (-this._bitmap.height) * 1.5;
            this._bitmap.y = this._yOff;
            this._bitmap.x = (-this._width) / 2;
            addChild(this._bitmap);
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            this.addShadow(this._width + (this._yOff + this._height - this._bottomHeight) / this._height * this._width);
            if (this._shiningClip.parent != null)
            {
                this._shiningClip.x = parent.x + this._width / 3;
                this._shiningClip.y = parent.y - this._height / 3 * 2;
            }
            return;
        }// end function

        public function addShadow(param1 = null, param2 = null)
        {
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            if (param2 != null)
            {
                this._shadowScale = param2;
            }
            this.graphics.clear();
            if (_shadowOn)
            {
                this.graphics.clear();
                this.graphics.lineStyle(0, 0, 0);
                _loc_3 = new Matrix();
                if (param1 == null)
                {
                    _loc_4 = this._width;
                }
                else
                {
                    _loc_4 = param1;
                }
                _loc_4 = _loc_4 * this._shadowScale;
                _loc_3.createGradientBox(_loc_4, _loc_4 / 2, 0, (-_loc_4) / 2, (-_loc_4) / 4);
                this.graphics.beginGradientFill(GradientType.RADIAL, [0, 0], [0.8, 0.3], [0, 255], _loc_3);
                this.graphics.drawEllipse((-_loc_4) / 2, (-_loc_4) / 4, _loc_4, _loc_4 / 2);
                this.graphics.endFill();
            }
            else
            {
                this.removeShadow();
            }
            return;
        }// end function

        public function set zoff(param1:Number)
        {
            this._z = param1;
            if (this._bitmap != null)
            {
                this._bitmap.y = this._yOff - this._z;
            }
            this.addShadow(null, (200 - this._z) / 200);
            return;
        }// end function

        public function removeShadow()
        {
            this.graphics.clear();
            return;
        }// end function

        private function handleEnterFrame(param1)
        {
            this._ySpeed = this._ySpeed + Config.gravity;
            this._yOff = this._yOff + this._ySpeed;
            this.addShadow(this._width + (this._yOff + this._height - this._bottomHeight) / this._height * this._width);
            if (this._yOff >= -this._height + this._bottomHeight)
            {
                this._yOff = -this._height + this._bottomHeight;
                this._bitmap.y = this._yOff;
                removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            }
            else
            {
                this._bitmap.y = this._yOff;
            }
            return;
        }// end function

        public function destroy()
        {
            if (this._loader != null)
            {
                this._loader.removeEventListener("complete", this.handleLoadComplete);
                this._loader = null;
            }
            this._destroyed = true;
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            if (this._bitmapData != null)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            }
            if (this._shiningClip.parent != null)
            {
                this._shiningClip.parent.removeChild(this._shiningClip);
            }
            this._shiningClip.clear();
            if (!this._poolPushed)
            {
                this._poolPushed = true;
                _objectPool.push(this);
            }
            return;
        }// end function

        public static function set shadow(param1:Boolean)
        {
            var _loc_2:* = undefined;
            _shadowOn = param1;
            var _loc_3:* = Item.itemArray;
            if (_shadowOn)
            {
                for (_loc_2 in _loc_3)
                {
                    
                    if (_loc_3[_loc_2]._img != null)
                    {
                        _loc_3[_loc_2]._img.addShadow();
                    }
                }
            }
            else
            {
                for (_loc_2 in _loc_3)
                {
                    
                    if (_loc_3[_loc_2]._img != null)
                    {
                        _loc_3[_loc_2]._img.removeShadow();
                    }
                }
            }
            return;
        }// end function

        public static function get shadow()
        {
            return _shadowOn;
        }// end function

        public static function newDropClip(param1:String)
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            if (_objectPool.length == 0)
            {
                return new DropClip(param1);
            }
            _loc_2 = _objectPool.shift();
            _loc_2._shiningClip.style = "shining";
            _loc_2._poolPushed = false;
            _loc_2._destroyed = false;
            _loc_2._ySpeed = -4;
            _loc_2._fileHead = param1.substr(0, 2);
            _loc_2._iconURL = Config.findIconURL(param1);
            _loc_3 = BitmapLoader.pick(_loc_2._iconURL);
            if (_loc_3 != null)
            {
                _loc_2.handleLoadComplete(null, _loc_3);
            }
            else
            {
                if (_loc_2._loader != null)
                {
                    _loc_2._loader.removeEventListener("complete", _loc_2.handleLoadComplete);
                    _loc_2._loader.removeEventListener("complete", _loc_2.handleLoadComplete);
                }
                _loc_2._loader = BitmapLoader.newBitmapLoader();
                _loc_2._loader.removeEventListener("complete", _loc_2.handleLoadComplete);
                _loc_2._loader.addEventListener("complete", _loc_2.handleLoadComplete);
                _loc_2._loader.load([_loc_2._iconURL]);
            }
            _loc_2.y = 0;
            _loc_2._shadowScale = 1;
            _loc_2._z = 0;
            return _loc_2;
        }// end function

    }
}
