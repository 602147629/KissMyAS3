package lovefox.gui
{
    import flash.display.*;
    import flash.geom.*;

    public class GClip extends Sprite
    {
        private var _poolPushed:Boolean = false;
        private var _bmp:Bitmap;
        public var _bitmap:Bitmap;
        public var _bitmapArray:Array;
        public var _frame:Object;
        public var _frameIndex:Object;
        public var _interval:Object;
        public var _frameskip:Object;
        public var _frameskipCount:Object;
        public var _bitmapRect:Rectangle;
        public var _yOff:int;
        public var _width:Object;
        public var _height:Object;
        private var _loop:Boolean = true;
        private static var _objectPool:Array = [];
        private static var _clipStack:Object = {};

        public function GClip(param1 = null)
        {
            this._bitmapArray = [];
            this._bmp = new Bitmap();
            if (param1 != null)
            {
                this.init(param1);
            }
            return;
        }// end function

        private function init(param1)
        {
            var _loc_2:* = _clipStack[param1];
            this._frame = _loc_2.frame;
            this._frameskip = _loc_2.frameskip;
            this._interval = _loc_2.interval;
            this._bitmapArray = _loc_2.bmpd;
            this._frameIndex = 0;
            this._frameskipCount = this._frameskip;
            this._bmp.bitmapData = this._bitmapArray[this._frameIndex];
            this._bmp.x = _loc_2.x;
            this._bmp.y = _loc_2.y;
            addChild(this._bmp);
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            removeEventListener(Event.ADDED_TO_STAGE, this.handleAdded);
            removeEventListener(Event.REMOVED_FROM_STAGE, this.handleRemoved);
            if (this._frame > 1)
            {
                addEventListener(Event.ADDED_TO_STAGE, this.handleAdded);
                addEventListener(Event.REMOVED_FROM_STAGE, this.handleRemoved);
                if (parent != null)
                {
                    this.handleAdded();
                }
            }
            return;
        }// end function

        public function set style(param1)
        {
            this.clear();
            if (param1 != null)
            {
                this.init(param1);
            }
            return;
        }// end function

        private function handleEnterFrame(param1)
        {
            if (this._frameskipCount <= 0)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._frameIndex + 1;
                _loc_2._frameIndex = _loc_3;
                if (this._frameIndex > (this._bitmapArray.length - 1))
                {
                    this._frameIndex = 0;
                }
                this._bmp.bitmapData = this._bitmapArray[this._frameIndex];
                if (this._frameIndex == (this._bitmapArray.length - 1))
                {
                    if (this._loop)
                    {
                        this._frameskipCount = this._interval;
                    }
                    else
                    {
                        removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
                    }
                }
                else
                {
                    this._frameskipCount = this._frameskip;
                }
            }
            else
            {
                var _loc_2:* = this;
                var _loc_3:* = this._frameskipCount - 1;
                _loc_2._frameskipCount = _loc_3;
            }
            return;
        }// end function

        public function clear()
        {
            this._bmp.bitmapData = null;
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            removeEventListener(Event.ADDED_TO_STAGE, this.handleAdded);
            removeEventListener(Event.REMOVED_FROM_STAGE, this.handleRemoved);
            return;
        }// end function

        private function handleAdded(param1 = null)
        {
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }// end function

        private function handleRemoved(param1)
        {
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }// end function

        public function destroy()
        {
            this.clear();
            if (!this._poolPushed)
            {
                this._poolPushed = true;
                _objectPool.push(this);
            }
            return;
        }// end function

        public function gotoAndPlay(param1:int, param2 = true) : void
        {
            this._loop = param2;
            this._frameIndex = param1;
            this._frameskipCount = this._frameskip;
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }// end function

        public function gotoAndStop(param1:int) : void
        {
            this._bmp.bitmapData = this._bitmapArray[param1];
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }// end function

        public function stop() : void
        {
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }// end function

        public function get totalFrame() : int
        {
            return this._bitmapArray.length * (this._frameskip + 1);
        }// end function

        public static function init()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = Config.findUI("clip");
            for (_loc_1 in _loc_7.children())
            {
                
                _loc_3 = [];
                _loc_4 = Number(_loc_7.children()[_loc_1].frame);
                _loc_5 = BitmapLoader.pick(String(_loc_7.children()[_loc_1].dir));
                _loc_6 = _loc_5.width / _loc_4;
                _loc_2 = 0;
                while (_loc_2 < _loc_4)
                {
                    
                    _loc_3[_loc_2] = new BitmapData(_loc_6, _loc_5.height, true, 0);
                    _loc_3[_loc_2].copyPixels(_loc_5, new Rectangle(_loc_6 * _loc_2, 0, _loc_6, _loc_5.height), new Point(), null, null, true);
                    _loc_2 = _loc_2 + 1;
                }
                _loc_5.dispose();
                _clipStack[_loc_7.children()[_loc_1].name()] = {bmpd:_loc_3, frame:_loc_4, interval:Number(_loc_7.children()[_loc_1].interval), frameskip:Number(_loc_7.children()[_loc_1].frameskip), x:Number(_loc_7.children()[_loc_1].x), y:Number(_loc_7.children()[_loc_1].y)};
            }
            return;
        }// end function

        public static function newGClip(param1 = null)
        {
            var _loc_2:* = null;
            if (_objectPool.length == 0)
            {
                return new GClip(param1);
            }
            _loc_2 = _objectPool.shift();
            _loc_2._poolPushed = false;
            _loc_2.x = 0;
            _loc_2.y = 0;
            _loc_2._loop = true;
            if (param1 != null)
            {
                _loc_2.init(param1);
            }
            return _loc_2;
        }// end function

    }
}
