package questSelect
{
    import button.*;
    import flash.display.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class CampaignDetail extends Object
    {
        private var _mcTop:MovieClip;
        private var _aBtnNull:Array;
        private var _aEventBtnMc:Array;
        private var _aButton:Array;
        private var _aDispButton:Array;
        private var _page:PageButton;
        private var _pageAnim:PageAnim;
        private var _pageIndex:int;
        private var _cbBtnClick:Function;
        private var _bBtnEnable:Boolean;
        private var _isoMain:InStayOut;
        private var _resourcePath:String;
        private var _aEventDetail:Array;

        public function CampaignDetail(param1:DisplayObjectContainer, param2:String, param3:Function)
        {
            this._resourcePath = param2;
            this._mcTop = ResourceManager.getInstance().createMovieClip(this._resourcePath, "EventSet");
            param1.addChild(this._mcTop);
            this._aBtnNull = [];
            this._aEventBtnMc = [];
            this._aButton = [];
            this._aDispButton = [];
            this._cbBtnClick = param3;
            this._isoMain = new InStayOut(this._mcTop);
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            while (_loc_6 < this._mcTop.numChildren)
            {
                
                _loc_4 = this._mcTop.getChildAt(_loc_6) as MovieClip;
                if (_loc_4 != null)
                {
                    _loc_5 = _loc_4.name.indexOf("mcBtnNull");
                    if (_loc_5 != -1)
                    {
                        this._aBtnNull.push(_loc_4);
                    }
                }
                _loc_6++;
            }
            this._pageAnim = new PageAnim(this._mcTop, this.changePage, this.cbPageAnimEnd);
            this._page = new PageButton(this._mcTop.pageBtnSetGuidMc, this.cbChangePage);
            return;
        }// end function

        private function get _btnNullMax() : int
        {
            return this._aBtnNull != null ? (this._aBtnNull.length) : (0);
        }// end function

        public function get bOpen() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain.bClosed;
        }// end function

        public function get bBtnEnable() : Boolean
        {
            return this._bBtnEnable;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_2 in this._aDispButton)
            {
                
                if (_loc_2)
                {
                    _loc_1 = _loc_2.getMoveClip();
                    if (_loc_1 && _loc_1.parent)
                    {
                        _loc_1.parent.removeChild(_loc_1);
                    }
                    ButtonManager.getInstance().removeArray(_loc_2);
                }
            }
            this._aDispButton = null;
            for each (_loc_2 in this._aButton)
            {
                
                if (_loc_2)
                {
                    _loc_2.release();
                    _loc_2 = null;
                }
            }
            this._aButton = null;
            if (this._pageAnim)
            {
                this._pageAnim.release();
            }
            this._pageAnim = null;
            if (this._page)
            {
                this._page.release();
            }
            this._page = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcTop && this._mcTop.parent)
            {
                this._mcTop.parent.removeChild(this._mcTop);
            }
            this._mcTop = null;
            this._cbBtnClick = null;
            this._aBtnNull = null;
            this._aEventBtnMc = null;
            this._aEventDetail = null;
            return;
        }// end function

        public function Init(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._aEventDetail = param1;
            var _loc_5:* = 0;
            while (_loc_5 < this._aEventDetail.length)
            {
                
                _loc_4 = this._aEventDetail[_loc_5];
                try
                {
                    if (_loc_4)
                    {
                        _loc_2 = ResourceManager.getInstance().createMovieClip(this._resourcePath, "EventBtnMc" + _loc_5);
                        if (_loc_2 != null)
                        {
                            this._aEventBtnMc.push(_loc_2);
                            _loc_3 = new ButtonBase(_loc_2, this.cbClickEventButton, null, null);
                            _loc_3.setId(_loc_5);
                            _loc_3.enterSeId = Constant.UNDECIDED;
                            _loc_3.setDisableFlag(true);
                            this._aButton.push(_loc_3);
                        }
                    }
                }
                catch (err:Error)
                {
                }
                _loc_5++;
            }
            this._pageIndex = 0;
            var _loc_6:* = Math.ceil(this._aEventBtnMc.length / this._btnNullMax);
            this._page.setPage(this._pageIndex, _loc_6);
            this._page.btnEnable(false);
            if (_loc_6 <= 1)
            {
                this._mcTop.pageBtnSetGuidMc.visible = false;
            }
            else
            {
                this._mcTop.pageBtnSetGuidMc.visible = true;
            }
            this.setList();
            return;
        }// end function

        public function setIn() : void
        {
            this.setBtnEnableAll(false);
            if (this._isoMain)
            {
                this._isoMain.setIn();
            }
            return;
        }// end function

        public function setOut() : void
        {
            this.setBtnEnableAll(false);
            if (this._isoMain)
            {
                this._isoMain.setOut();
            }
            return;
        }// end function

        private function setList() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = this._btnNullMax * this._pageIndex;
            _loc_1 = 0;
            while (_loc_1 < this._aDispButton.length)
            {
                
                _loc_2 = this._aDispButton[_loc_1];
                if (_loc_2)
                {
                    _loc_4 = _loc_2.getMoveClip();
                    if (_loc_4 && _loc_4.parent)
                    {
                        _loc_4.parent.removeChild(_loc_4);
                        ButtonManager.getInstance().removeArray(_loc_2);
                    }
                }
                _loc_1++;
            }
            this._aDispButton = [];
            _loc_1 = 0;
            while (_loc_1 < this._aButton.length)
            {
                
                _loc_2 = this._aButton[_loc_1];
                if (_loc_2)
                {
                    if (_loc_6 <= _loc_1 && _loc_1 < _loc_6 + this._btnNullMax)
                    {
                        _loc_4 = _loc_2.getMoveClip();
                        _loc_5 = this._aEventDetail[_loc_1];
                        TextControl.setText(_loc_4.textMc.textDt, _loc_5.subTitle);
                        _loc_4.newIcon.visible = !_loc_5.bRead;
                        this._aDispButton.push(_loc_2);
                    }
                }
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this._aDispButton.length)
            {
                
                _loc_2 = this._aDispButton[_loc_1];
                if (_loc_2)
                {
                    _loc_3 = this._aBtnNull[_loc_1];
                    if (_loc_3)
                    {
                        _loc_4 = _loc_2.getMoveClip();
                        _loc_3.addChild(_loc_4);
                        ButtonManager.getInstance().addButtonBase(_loc_2);
                    }
                }
                _loc_1++;
            }
            return;
        }// end function

        public function updateNewIcon() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            while (_loc_4 < this._aDispButton.length)
            {
                
                _loc_1 = this._aDispButton[_loc_4];
                if (_loc_1)
                {
                    _loc_3 = this._aEventDetail[_loc_1.id];
                    _loc_2 = _loc_1.getMoveClip();
                    if (_loc_2 && _loc_3)
                    {
                        _loc_2.newIcon.visible = !_loc_3.bRead;
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        private function changePage(param1:int) : void
        {
            if (this._pageIndex == param1)
            {
                return;
            }
            this._pageIndex = param1;
            this._page.changePage(this._pageIndex);
            this.setList();
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
            switch(param2)
            {
                case PageButton.PAGE_BUTTON_ID_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_END:
                {
                    this._pageAnim.setRight(param1);
                    break;
                }
                case PageButton.PAGE_BUTTON_ID_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_END:
                {
                    this._pageAnim.setLeft(param1);
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            this.setBtnEnableAll(false);
            return false;
        }// end function

        private function cbPageAnimEnd() : void
        {
            this.setBtnEnableAll(true);
            return;
        }// end function

        private function cbClickEventButton(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._cbBtnClick != null)
            {
                _loc_2 = this._aEventDetail[param1];
                this._cbBtnClick(_loc_2.campaignSubId);
            }
            return;
        }// end function

        public function setBtnEnableAll(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this._bBtnEnable = param1;
            for each (_loc_2 in this._aDispButton)
            {
                
                if (_loc_2 != null)
                {
                    _loc_2.setDisableFlag(!param1);
                }
            }
            if (this._page)
            {
                this._page.btnEnable(param1);
            }
            return;
        }// end function

    }
}
