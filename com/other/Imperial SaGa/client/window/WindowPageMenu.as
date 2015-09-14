package window
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;

    public class WindowPageMenu extends WindowBase
    {
        private var _adjustHeight:int = 576;
        private var _adjustWidth:int = 1024;
        private var _windowMc:MovieClip;
        private var _pageMc:MovieClip;
        private var _horzSize:int;
        private var _maxItem:int;
        private var _dispIndex:int;
        private var _pagePos:Point;
        private var _rMaxBtn:ButtonBase;
        private var _rBtn:ButtonBase;
        private var _lMaxBtn:ButtonBase;
        private var _lBtn:ButtonBase;
        private var _pageNum:int;
        private var _pageMax:int;
        private static var _rPageMax:int = 1;
        private static var _rPage:int = 2;
        private static var _lPageMax:int = 3;
        private static var _lPage:int = 4;

        public function WindowPageMenu(param1:Function = null, param2:int = 0, param3:WindowStyle = null, param4:int = 5, param5:int = 1)
        {
            super(param1, param2, param3);
            this._windowMc = ResourceManager.getInstance().createMovieClip(ResourceManager.EMBED_COMMON_WINDOW, "windowBaseMc");
            this._windowMc.cacheAsBitmap = true;
            addChild(this._windowMc);
            this._pageMc = ResourceManager.getInstance().createMovieClip(ResourceManager.EMBED_COMMON_WINDOW, "pageButton");
            addChild(this._pageMc);
            this._pagePos = new Point(this._pageMc.pagenumtextMc.x + this._pageMc.pagenumtextMc.width / 2, this._pageMc.pagenumtextMc.y + this._pageMc.pagenumtextMc.height / 2);
            this._windowMc.textnull.x = this._windowMc.textnull.x + param2;
            _baseMc = this._windowMc.windoMc;
            this._maxItem = param4;
            this._pageNum = param5;
            this._dispIndex = this._maxItem * (this._pageNum - 1);
            this.createPageButton();
            this._horzSize = 1;
            if (_windowStyle != null)
            {
                this._horzSize = _windowStyle.rowNum;
            }
            return;
        }// end function

        public function get pageNum() : int
        {
            return this._pageNum;
        }// end function

        override public function release() : void
        {
            this.removeItem();
            ButtonManager.getInstance().removeButton(this._rMaxBtn);
            ButtonManager.getInstance().removeButton(this._rBtn);
            ButtonManager.getInstance().removeButton(this._lMaxBtn);
            ButtonManager.getInstance().removeButton(this._lBtn);
            if (this._pageMc && this._pageMc.parent)
            {
                this._pageMc.parent.removeChild(this._pageMc);
            }
            this._pageMc = null;
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
            var _loc_9:* = null;
            var _loc_3:* = this._windowMc.textnull;
            var _loc_4:* = new Point();
            new Point().x = new Point().x + _windowStyle.leftMargin;
            _loc_4.x = _loc_4.x + _windowStyle.rightMargin;
            _loc_4.y = _loc_4.y + _windowStyle.topMargin;
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
            _loc_1 = 0;
            for each (_loc_2 in _aItem)
            {
                
                _loc_9 = _loc_2 as WindowTextButton;
                if (_loc_1 >= this._dispIndex && _loc_1 < this._maxItem * this._pageNum)
                {
                    _loc_9.textButton.setDisable(false);
                    if (_loc_2.bSingleHorz || _loc_6 == 0)
                    {
                        var _loc_12:* = 0;
                        _loc_7 = 0;
                        _loc_8 = _loc_12;
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
                else
                {
                    _loc_9.textButton.setDisable(true);
                }
                _loc_1++;
            }
            _loc_4.x = _loc_5.x * this._horzSize + _loc_3.x;
            _loc_4.y = _loc_4.y + (_windowStyle.bottomMargin + _loc_7 + _loc_3.y);
            this._windowMc.windoMc.width = _loc_4.x + _loc_3.x * 2;
            this._windowMc.windoMc.height = _loc_4.y + _loc_3.y * 2;
            _size.x = this._windowMc.windoMc.width;
            _size.y = this._windowMc.windoMc.height;
            this._pageMc.x = _size.x / 2 - this._pagePos.x;
            this._pageMc.y = this._windowMc.y + this._windowMc.height;
            for each (_loc_2 in _aItem)
            {
                
                _loc_2.setWidth(_loc_4.x);
            }
            this._pageMax = Math.ceil(_aItem.length / this._maxItem);
            this.updatePageNumber();
            this.updatePageButton();
            return;
        }// end function

        override public function windowCloseFunc() : void
        {
            if (_cbWindowClose != null)
            {
                _cbWindowClose(this);
            }
            _cbWindowClose = null;
            return;
        }// end function

        private function createPageButton() : void
        {
            this._rMaxBtn = ButtonManager.getInstance().addButton(this._pageMc.rpage1BtnMc, this.cbPageButton, _rPageMax);
            this._rMaxBtn.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._rBtn = ButtonManager.getInstance().addButton(this._pageMc.rpage2BtnMc, this.cbPageButton, _rPage);
            this._rBtn.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._lMaxBtn = ButtonManager.getInstance().addButton(this._pageMc.lpage1BtnMc, this.cbPageButton, _lPageMax);
            this._lMaxBtn.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._lBtn = ButtonManager.getInstance().addButton(this._pageMc.lpage2BtnMc, this.cbPageButton, _lPage);
            this._lBtn.enterSeId = ButtonBase.SE_CURSOR_ID;
            return;
        }// end function

        private function updatePageButton() : void
        {
            if (this._pageNum == this._pageMax)
            {
                this._rBtn.setDisable(true);
                this._rMaxBtn.setDisable(true);
            }
            else
            {
                this._rBtn.setDisable(false);
                this._rMaxBtn.setDisable(false);
            }
            if (this._pageNum == 1)
            {
                this._lBtn.setDisable(true);
                this._lMaxBtn.setDisable(true);
            }
            else
            {
                this._lBtn.setDisable(false);
                this._lMaxBtn.setDisable(false);
            }
            return;
        }// end function

        private function updatePageNumber() : void
        {
            var _loc_1:* = String(this._pageNum + "/" + this._pageMax);
            TextControl.setText(this._pageMc.pagenumtextMc.textDt, _loc_1);
            return;
        }// end function

        private function removeItem() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._windowMc && this._windowMc.textnull)
            {
                _loc_1 = this._windowMc.textnull;
                _loc_2 = _loc_1.numChildren;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_1.removeChildAt(0);
                    _loc_3++;
                }
            }
            return;
        }// end function

        private function cbPageButton(param1:int) : void
        {
            if (param1 == _rPageMax)
            {
                this._pageNum = this._pageMax;
                this._dispIndex = this._maxItem * (this._pageNum - 1);
            }
            if (param1 == _rPage)
            {
                this._dispIndex = this._maxItem * this._pageNum;
                var _loc_2:* = this;
                var _loc_3:* = this._pageNum + 1;
                _loc_2._pageNum = _loc_3;
                if (this._pageNum > this._pageMax)
                {
                    this._pageNum = this._pageMax;
                }
            }
            if (param1 == _lPageMax)
            {
                this._pageNum = 1;
                this._dispIndex = 0;
            }
            if (param1 == _lPage)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._pageNum - 1;
                _loc_2._pageNum = _loc_3;
                this._dispIndex = this._maxItem * (this._pageNum - 1);
                if (this._pageNum < 1)
                {
                    this._pageNum = 1;
                }
            }
            this.removeItem();
            this.updatePageButton();
            this.updatePageNumber();
            this.itemRearrangement();
            return;
        }// end function

    }
}
