package lovefox.gameUI
{
    import flash.display.*;

    public class RollNotice extends Sprite
    {
        public var _bmp:Bitmap;
        public var _mask:Shape;
        public var _over:int = 0;
        public var _count:int = 0;
        public static var _notice:RollNotice;
        private static var _noticeContentStack:Object;
        private static var _loopTimer:Number;

        public function RollNotice()
        {
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this._bmp = new Bitmap();
            addChild(this._bmp);
            this._mask = new Shape();
            addChild(this._mask);
            this._bmp.mask = this._mask;
            this.filters = [new GlowFilter(Style.WHITE_FONT, 1, 1.2, 1.2, 3), new GlowFilter(0, 1, 2, 2, 10)];
            return;
        }// end function

        public function show()
        {
            this._over = 0;
            this.removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            this.addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }// end function

        private function hide()
        {
            this._over = 1;
            this.removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            this.addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }// end function

        private function handleEnterFrame(param1)
        {
            var _loc_2:* = undefined;
            if (this._over == 1)
            {
                _loc_2 = -_notice._bmp.height - _notice._bmp.y;
                _notice._bmp.y = _loc_2 / 2 + _notice._bmp.y;
                if (Math.abs(_loc_2) < 0.1)
                {
                    _notice._bmp.y = -_notice._bmp.height;
                    this._over = 3;
                }
            }
            else if (this._over == 0)
            {
                _loc_2 = -_notice._bmp.y;
                _notice._bmp.y = _loc_2 / 2 + _notice._bmp.y;
                if (Math.abs(_loc_2) < 0.1)
                {
                    _notice._bmp.y = 0;
                    this._over = 2;
                }
            }
            else
            {
                var _loc_3:* = this;
                var _loc_4:* = this._count - 1;
                _loc_3._count = _loc_4;
                if (this._count <= 0)
                {
                    if (this._over == 2)
                    {
                        this._over = 1;
                    }
                    else
                    {
                        this.clear();
                    }
                }
            }
            return;
        }// end function

        private function clear()
        {
            this.removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            if (this._bmp.bitmapData != null)
            {
                this._bmp.bitmapData.dispose();
                this._bmp.bitmapData = null;
            }
            if (parent != null)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

        public static function start()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            if (_noticeContentStack == null)
            {
                _noticeContentStack = {};
                for (_loc_1 in Config._rollTipMap)
                {
                    
                    if (Number(Config._rollTipMap[_loc_1].open) == 0)
                    {
                        _loc_4 = {str:String(Config._rollTipMap[_loc_1].content)};
                        _loc_2 = Number(Config._rollTipMap[_loc_1].minLevel);
                        while (_loc_2 < (Number(Config._rollTipMap[_loc_1].maxLevel) + 1))
                        {
                            
                            if (_noticeContentStack[_loc_2] == null)
                            {
                                _noticeContentStack[_loc_2] = [];
                            }
                            _noticeContentStack[_loc_2].push(_loc_4);
                            _loc_2 = _loc_2 + 1;
                        }
                    }
                }
            }
            clearTimeout(_loopTimer);
            _loopTimer = setTimeout(loop, 120000);
            return;
        }// end function

        public static function stop()
        {
            clearTimeout(_loopTimer);
            return;
        }// end function

        public static function loop()
        {
            var _loc_1:* = null;
            clearTimeout(_loopTimer);
            if (Config.player != null)
            {
                _loc_1 = _noticeContentStack[Config.player.level];
                if (_loc_1 != null)
                {
                    show(_loc_1[Math.floor(Math.random() * _loc_1.length)].str);
                }
            }
            _loopTimer = setTimeout(loop, 600000);
            return;
        }// end function

        public static function show(param1) : void
        {
            if (_notice == null)
            {
                _notice = new RollNotice;
            }
            if (_notice._bmp.bitmapData != null)
            {
                _notice._bmp.bitmapData.dispose();
                _notice._bmp.bitmapData = null;
            }
            if (_notice.parent == null)
            {
                Config.stage.addChild(_notice);
            }
            var _loc_2:* = 16;
            var _loc_3:* = Text2Bitmap.toBmp(param1, Style.WHITE_FONT, _loc_2, null);
            _notice._bmp.bitmapData = _loc_3;
            _notice._bmp.y = _notice._bmp.height;
            _notice._mask.graphics.clear();
            _notice._mask.graphics.beginFill(0, 1);
            _notice._mask.graphics.drawRect(0, 0, _notice._bmp.width, _notice._bmp.height);
            _notice._mask.graphics.endFill();
            _notice.x = (Config.ui._width - _notice._bmp.width) / 2;
            _notice.y = Config.ui._height / 4 + 25 - _notice._bmp.height / 2;
            _notice._count = 290;
            _notice.show();
            return;
        }// end function

        public static function resize()
        {
            if (_notice != null && _notice.parent != null)
            {
                _notice.x = (Config.ui._width - _notice._bmp.width) / 2;
                _notice.y = Config.ui._height / 4 + 25 - _notice._bmp.height / 2;
            }
            return;
        }// end function

    }
}
