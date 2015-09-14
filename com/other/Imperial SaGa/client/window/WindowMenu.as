package window
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;

    public class WindowMenu extends WindowBase
    {
        private var _adjustHeight:int = 576;
        private var _adjustWidth:int = 1024;
        private var _windowMc:MovieClip;
        private var _horzSize:int;

        public function WindowMenu(param1:Function = null, param2:int = 0, param3:WindowStyle = null)
        {
            super(param1, param2, param3);
            this._windowMc = ResourceManager.getInstance().createMovieClip(ResourceManager.EMBED_COMMON_WINDOW, "windowBaseMc");
            this._windowMc.cacheAsBitmap = true;
            addChild(this._windowMc);
            this._windowMc.textnull.x = this._windowMc.textnull.x + param2;
            _baseMc = this._windowMc.windoMc;
            this._horzSize = 1;
            if (_windowStyle != null)
            {
                this._horzSize = _windowStyle.rowNum;
            }
            return;
        }// end function

        override public function release() : void
        {
            if (this._windowMc && this._windowMc.parent)
            {
                this._windowMc.parent.removeChild(this._windowMc);
            }
            this._windowMc = null;
            super.release();
            return;
        }// end function

        override public function open(param1:Number, param2:Number) : void
        {
            var _loc_3:* = new Point(param1, param2);
            _loc_3 = localToGlobal(_loc_3);
            if (this._windowMc.windoMc.height + _loc_3.y > this._adjustHeight)
            {
                _loc_3.y = Math.max(0, this._adjustHeight - this._windowMc.windoMc.height);
            }
            if (this._windowMc.windoMc.width + _loc_3.x > this._adjustWidth)
            {
                _loc_3.x = Math.max(0, this._adjustWidth - this._windowMc.windoMc.width);
            }
            _loc_3 = localToGlobal(_loc_3);
            super.open(_loc_3.x, _loc_3.y);
            return;
        }// end function

        override protected function openInit(param1:Number, param2:Number) : void
        {
            super.openInit(param1, param2);
            return;
        }// end function

        override protected function itemRearrangement() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_3:* = this._windowMc.textnull;
            var _loc_4:* = new Point();
            new Point().y = new Point().y + _windowStyle.topMargin;
            var _loc_5:* = new Point();
            for each (_loc_2 in _aItem)
            {
                
                if (_loc_2.size.x > _loc_5.x)
                {
                    _loc_5.x = _loc_2.size.x;
                }
                if (_loc_2.size.y > _loc_5.y)
                {
                    _loc_5.y = _loc_2.size.y;
                }
            }
            _loc_6 = 0;
            _loc_7 = 0;
            _loc_8 = 0;
            for each (_loc_2 in _aItem)
            {
                
                if (_loc_2.bSingleHorz || _loc_6 == 0)
                {
                    var _loc_11:* = 0;
                    _loc_7 = 0;
                    _loc_8 = _loc_11;
                    _loc_8 = _windowStyle.leftMargin;
                }
                _loc_2.y = _loc_4.y;
                _loc_2.x = _loc_8;
                if (_loc_2.bMask)
                {
                    _loc_3.addChild(_loc_2);
                }
                else
                {
                    addChild(_loc_2);
                }
                _loc_8 = _loc_8 + _loc_5.x;
                if (_loc_7 < _loc_2.size.y)
                {
                    _loc_7 = _loc_2.size.y;
                }
                _loc_6++;
                if (_loc_6 == this._horzSize)
                {
                    _loc_4.y = _loc_4.y + _loc_7;
                    _loc_4.y = _loc_4.y + 2;
                    _loc_6 = 0;
                    _loc_7 = 0;
                }
            }
            _loc_4.x = _loc_4.x + (_loc_5.x * this._horzSize + _windowStyle.leftMargin + _windowStyle.rightMargin);
            _loc_4.y = _loc_4.y + (_windowStyle.bottomMargin + _loc_7);
            this._windowMc.windoMc.width = _loc_4.x + _loc_3.x * 4;
            this._windowMc.windoMc.height = _loc_4.y + _loc_3.y * 4;
            _size.x = this._windowMc.windoMc.width;
            _size.y = this._windowMc.windoMc.height;
            for each (_loc_2 in _aItem)
            {
                
                _loc_2.setWidth(_loc_4.x);
            }
            return;
        }// end function

    }
}
