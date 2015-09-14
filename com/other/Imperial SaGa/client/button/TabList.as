package button
{
    import flash.display.*;
    import message.*;

    public class TabList extends Object
    {
        private var _frontSprite:Sprite;
        private var _backSprite:Sprite;
        private var _aBtnTab:Array;
        private var _tabBtn:TabButton;
        private var _cbChangeTab:Function;
        private var _tabIndex:int;
        private var _setupedIndex:int;
        private var _bEnable:Boolean;

        public function TabList(param1:Function = null, param2:int = -1)
        {
            this._frontSprite = null;
            this._backSprite = null;
            this._aBtnTab = [];
            this._tabBtn = new TabButton();
            this._cbChangeTab = param1;
            this._tabIndex = param2;
            this._setupedIndex = Constant.UNDECIDED;
            this._bEnable = true;
            ButtonManager.getInstance().addButtonBase(this._tabBtn);
            this.update();
            return;
        }// end function

        public function get tabIndex() : int
        {
            return this._tabIndex;
        }// end function

        public function release() : void
        {
            if (this._tabBtn)
            {
                ButtonManager.getInstance().removeButton(this._tabBtn);
            }
            this._tabBtn = null;
            this._aBtnTab = null;
            if (this._backSprite && this._backSprite.parent)
            {
                this._backSprite.parent.removeChild(this._backSprite);
            }
            this._backSprite = null;
            if (this._frontSprite && this._frontSprite.parent)
            {
                this._frontSprite.parent.removeChild(this._frontSprite);
            }
            this._frontSprite = null;
            return;
        }// end function

        public function addTab(param1:MovieClip, param2:String, param3:int) : void
        {
            var _loc_4:* = new ButtonBase(param1, this.cbTabButton);
            new ButtonBase(param1, this.cbTabButton).setId(param3);
            _loc_4.enterSeId = ButtonBase.SE_CURSOR_ID;
            _loc_4.setHitMovieClip(param1.mcBtnAmbit);
            TextControl.setText(param1.textMc.textDt, param2);
            this._aBtnTab.push(_loc_4);
            this._tabBtn.addBtn(_loc_4);
            if (this._frontSprite == null)
            {
                this._frontSprite = new Sprite();
                param1.parent.addChildAt(this._frontSprite, param1.parent.getChildIndex(param1));
            }
            if (this._backSprite == null)
            {
                this._backSprite = new Sprite();
                this._frontSprite.parent.addChildAt(this._backSprite, this._frontSprite.parent.getChildIndex(this._frontSprite));
            }
            return;
        }// end function

        public function changeTabIndex(param1:int) : void
        {
            this._tabIndex = param1;
            this.update();
            return;
        }// end function

        public function changeTabId(param1:int) : void
        {
            this._tabIndex = this.searchTabIndex(param1);
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
                for each (_loc_2 in this._aBtnTab)
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

        public function update() : void
        {
            this.btnUpdate();
            return;
        }// end function

        public function getButtonId(param1:int) : int
        {
            var _loc_2:* = this._aBtnTab[param1];
            if (_loc_2)
            {
                return _loc_2.id;
            }
            return Constant.EMPTY_ID;
        }// end function

        private function btnUpdate() : void
        {
            var _loc_1:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = this._aBtnTab.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_1 = this._aBtnTab[_loc_3];
                _loc_4 = _loc_3 != this._tabIndex;
                _loc_1.setDisable(!_loc_4);
                if (_loc_4 && !this._bEnable)
                {
                    _loc_1.setDisableFlag(true);
                }
                _loc_3++;
            }
            if (this._frontSprite && this._backSprite && this._setupedIndex != this._tabIndex)
            {
                _loc_5 = [];
                _loc_3 = 0;
                while (_loc_3 < this._tabIndex)
                {
                    
                    _loc_1 = this._aBtnTab[_loc_3];
                    _loc_6 = _loc_1.getMoveClip();
                    if (_loc_6.parent)
                    {
                        _loc_6.parent.removeChild(_loc_6);
                    }
                    this._backSprite.addChild(_loc_6);
                    _loc_5.push(_loc_1);
                    _loc_3++;
                }
                _loc_3 = _loc_2 - 1;
                while (_loc_3 > this._tabIndex)
                {
                    
                    _loc_1 = this._aBtnTab[_loc_3];
                    _loc_6 = _loc_1.getMoveClip();
                    if (_loc_6.parent)
                    {
                        _loc_6.parent.removeChild(_loc_6);
                    }
                    this._backSprite.addChild(_loc_6);
                    _loc_5.push(_loc_1);
                    _loc_3 = _loc_3 - 1;
                }
                if (this._tabIndex >= 0)
                {
                    _loc_1 = this._aBtnTab[this._tabIndex];
                    if (_loc_1)
                    {
                        _loc_6 = _loc_1.getMoveClip();
                        if (_loc_6.parent)
                        {
                            _loc_6.parent.removeChild(_loc_6);
                        }
                        this._frontSprite.addChild(_loc_6);
                        _loc_5.push(_loc_1);
                    }
                }
                this._tabBtn.sortBtn(_loc_5);
                _loc_5 = null;
                this._setupedIndex = this._tabIndex;
            }
            return;
        }// end function

        private function cbTabButton(param1:int) : void
        {
            this._tabIndex = this.searchTabIndex(param1);
            if (this._cbChangeTab == null || this._cbChangeTab(this._tabIndex, param1) == true)
            {
                this.update();
            }
            return;
        }// end function

        private function searchTabIndex(param1:int) : int
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aBtnTab.length)
            {
                
                _loc_3 = this._aBtnTab[_loc_2];
                if (_loc_3.id == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return Constant.UNDECIDED;
        }// end function

    }
}
