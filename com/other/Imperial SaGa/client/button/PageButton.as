package button
{
    import flash.display.*;
    import utility.*;

    public class PageButton extends Object
    {
        private var _aBtnPage:Array;
        private var _numericPageNum:NumericNumberMc;
        private var _numericPageMax:NumericNumberMc;
        private var _cbChangePage:Function;
        private var _pageIndex:int;
        private var _pageMax:int;
        private var _bNotFoundMc:Boolean;
        private var _bEnable:Boolean;
        public static const PAGE_BUTTON_ID_NONE:int = 0;
        public static const PAGE_BUTTON_ID_LEFT:int = 1;
        public static const PAGE_BUTTON_ID_LEFT_LEFT:int = 2;
        public static const PAGE_BUTTON_ID_LEFT_END:int = 3;
        public static const PAGE_BUTTON_ID_RIGHT:int = 4;
        public static const PAGE_BUTTON_ID_RIGHT_RIGHT:int = 5;
        public static const PAGE_BUTTON_ID_RIGHT_END:int = 6;

        public function PageButton(param1:MovieClip, param2:Function = null, param3:int = 0, param4:int = 1)
        {
            var _loc_5:* = null;
            this._bNotFoundMc = param1.pageNumTextMc == null;
            if (!this._bNotFoundMc)
            {
                this._aBtnPage = [];
                _loc_5 = ButtonManager.getInstance().addButton(param1.lpage2BtnMc ? (param1.lpage2BtnMc) : (param1.pageBtnLeft1Mc), this.cbPageButton, PAGE_BUTTON_ID_LEFT);
                _loc_5.enterSeId = ButtonBase.SE_CURSOR_ID;
                this._aBtnPage.push(_loc_5);
                if (param1.lpage1BtnMc ? (param1.lpage1BtnMc) : (param1.pageBtnLeft2Mc))
                {
                    _loc_5 = ButtonManager.getInstance().addButton(param1.lpage1BtnMc ? (param1.lpage1BtnMc) : (param1.pageBtnLeft2Mc), this.cbPageButton, PAGE_BUTTON_ID_LEFT_LEFT);
                    _loc_5.enterSeId = ButtonBase.SE_CURSOR_ID;
                    this._aBtnPage.push(_loc_5);
                }
                if (param1.pageBtnLeft3Mc)
                {
                    _loc_5 = ButtonManager.getInstance().addButton(param1.pageBtnLeft3Mc, this.cbPageButton, PAGE_BUTTON_ID_LEFT_END);
                    _loc_5.enterSeId = ButtonBase.SE_CURSOR_ID;
                    this._aBtnPage.push(_loc_5);
                }
                _loc_5 = ButtonManager.getInstance().addButton(param1.rpage2BtnMc ? (param1.rpage2BtnMc) : (param1.pageBtnRight1Mc), this.cbPageButton, PAGE_BUTTON_ID_RIGHT);
                _loc_5.enterSeId = ButtonBase.SE_CURSOR_ID;
                this._aBtnPage.push(_loc_5);
                if (param1.rpage1BtnMc ? (param1.rpage1BtnMc) : (param1.pageBtnRight2Mc))
                {
                    _loc_5 = ButtonManager.getInstance().addButton(param1.rpage1BtnMc ? (param1.rpage1BtnMc) : (param1.pageBtnRight2Mc), this.cbPageButton, PAGE_BUTTON_ID_RIGHT_RIGHT);
                    _loc_5.enterSeId = ButtonBase.SE_CURSOR_ID;
                    this._aBtnPage.push(_loc_5);
                }
                if (param1.pageBtnRight3Mc)
                {
                    _loc_5 = ButtonManager.getInstance().addButton(param1.pageBtnRight3Mc, this.cbPageButton, PAGE_BUTTON_ID_RIGHT_END);
                    _loc_5.enterSeId = ButtonBase.SE_CURSOR_ID;
                    this._aBtnPage.push(_loc_5);
                }
                this._numericPageNum = new NumericNumberMc(param1.pageNumTextMc.pageNum2, 0, 1, false);
                this._numericPageMax = new NumericNumberMc(param1.pageNumTextMc.pageNum1, 0, 1, false, true);
            }
            else
            {
                this._aBtnPage = [];
                this._numericPageNum = null;
                this._numericPageMax = null;
            }
            this._cbChangePage = param2;
            this._pageIndex = param3;
            this._pageMax = Math.max(1, param4);
            this._bEnable = true;
            this.update();
            return;
        }// end function

        public function get pageIndex() : int
        {
            return this._pageIndex;
        }// end function

        public function get pageMax() : int
        {
            return this._pageMax;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._numericPageNum)
            {
                this._numericPageNum.release();
            }
            this._numericPageNum = null;
            if (this._numericPageMax)
            {
                this._numericPageMax.release();
            }
            this._numericPageMax = null;
            for each (_loc_1 in this._aBtnPage)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aBtnPage = null;
            return;
        }// end function

        public function changePage(param1:int) : void
        {
            this._pageIndex = param1;
            this.update();
            return;
        }// end function

        public function setPage(param1:int, param2:int) : void
        {
            this._pageIndex = param1;
            this._pageMax = Math.max(1, param2);
            this.update();
            return;
        }// end function

        public function setMaxPage(param1:int) : void
        {
            this._pageMax = Math.max(1, param1);
            if (this._pageIndex >= this._pageMax)
            {
                this._pageIndex = this._pageMax - 1;
            }
            this.update();
            return;
        }// end function

        public function btnEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this._bEnable = param1;
            if (this._bEnable)
            {
                this.btnUpdate();
            }
            else
            {
                for each (_loc_2 in this._aBtnPage)
                {
                    
                    _loc_2.setDisableFlag(true);
                }
            }
            return;
        }// end function

        public function btnDisable(param1:Boolean) : void
        {
            this.btnEnable(!param1);
            return;
        }// end function

        public function btnUpdate() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = false;
            if (this._bNotFoundMc)
            {
                return;
            }
            for each (_loc_1 in this._aBtnPage)
            {
                
                _loc_2 = false;
                switch(_loc_1.id)
                {
                    case PAGE_BUTTON_ID_LEFT:
                    case PAGE_BUTTON_ID_LEFT_LEFT:
                    case PAGE_BUTTON_ID_LEFT_END:
                    {
                        _loc_2 = this._pageIndex > 0;
                        break;
                    }
                    case PAGE_BUTTON_ID_RIGHT:
                    case PAGE_BUTTON_ID_RIGHT_RIGHT:
                    case PAGE_BUTTON_ID_RIGHT_END:
                    {
                        _loc_2 = this._pageIndex < (this._pageMax - 1);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_1.setDisable(!_loc_2);
                if (_loc_2 && !this._bEnable)
                {
                    _loc_1.setDisableFlag(true);
                }
            }
            return;
        }// end function

        public function update() : void
        {
            if (this._bNotFoundMc)
            {
                return;
            }
            this.btnUpdate();
            this._numericPageNum.setNum((this._pageIndex + 1));
            this._numericPageMax.setNum(this._pageMax);
            return;
        }// end function

        private function cbPageButton(param1:int) : void
        {
            switch(param1)
            {
                case PAGE_BUTTON_ID_LEFT:
                {
                    if (this._pageIndex <= 0)
                    {
                        return;
                    }
                    var _loc_2:* = this;
                    var _loc_3:* = this._pageIndex - 1;
                    _loc_2._pageIndex = _loc_3;
                    break;
                }
                case PAGE_BUTTON_ID_LEFT_LEFT:
                {
                    if (this._pageIndex > 10)
                    {
                        this._pageIndex = this._pageIndex - 10;
                    }
                    else
                    {
                        this._pageIndex = 0;
                    }
                    break;
                }
                case PAGE_BUTTON_ID_LEFT_END:
                {
                    this._pageIndex = 0;
                    break;
                }
                case PAGE_BUTTON_ID_RIGHT:
                {
                    if (this._pageIndex >= (this._pageMax - 1))
                    {
                        return;
                    }
                    var _loc_2:* = this;
                    var _loc_3:* = this._pageIndex + 1;
                    _loc_2._pageIndex = _loc_3;
                    break;
                }
                case PAGE_BUTTON_ID_RIGHT_RIGHT:
                {
                    if (this._pageIndex < this._pageMax - 11)
                    {
                        this._pageIndex = this._pageIndex + 10;
                    }
                    else
                    {
                        this._pageIndex = this._pageMax - 1;
                    }
                    break;
                }
                case PAGE_BUTTON_ID_RIGHT_END:
                {
                    this._pageIndex = this._pageMax - 1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._cbChangePage == null || this._cbChangePage(this._pageIndex, param1) == true)
            {
                this.update();
            }
            return;
        }// end function

    }
}
