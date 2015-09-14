package dropdownList
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import message.*;
    import window.*;

    public class DropdownList extends Object
    {
        private var _baseMc:MovieClip;
        private var _textMc:MovieClip;
        private var _btnMc:MovieClip;
        private var _aList:Array;
        private var _cbOpen:Function;
        private var _cbMenu:Function;
        private var _cbClose:Function;
        private var _bEnable:Boolean;
        private var _btnBase:ButtonBase;
        private var _windowMenu:WindowMenu;
        private var _bMenuOpen:Boolean;
        private var _selectIndex:int;
        private var _selectId:int;

        public function DropdownList(param1:MovieClip, param2:MovieClip, param3:MovieClip, param4:String, param5:Array, param6:Function, param7:Function, param8:Function)
        {
            this._baseMc = param1;
            this._textMc = param2;
            this._btnMc = param3;
            this._aList = param5;
            this._cbOpen = param6;
            this._cbMenu = param7;
            this._cbClose = param8;
            this._btnBase = ButtonManager.getInstance().addButton(this._btnMc, this.cbClick);
            this._btnBase.enterSeId = ButtonBase.SE_CURSOR_ID;
            if (param4 && this._btnMc.textMc)
            {
                TextControl.setText(this._btnMc.textMc.textDt, param4);
            }
            this._windowMenu = null;
            this._bMenuOpen = false;
            this._selectIndex = 0;
            this._bEnable = true;
            InputManager.getInstance().addMouseCallback(this, null, this.cbMouseClick, null, null, 0);
            var _loc_9:* = this._aList[this._selectIndex];
            TextControl.setText(this._textMc.textDt, _loc_9.text);
            return;
        }// end function

        public function get aList() : Array
        {
            return this._aList.concat();
        }// end function

        public function get selectIndex() : int
        {
            return this._selectIndex;
        }// end function

        public function get selectId() : int
        {
            return this._aList[this._selectIndex] ? (this._aList[this._selectIndex].id) : (Constant.EMPTY_ID);
        }// end function

        public function release() : void
        {
            InputManager.getInstance().delMouseCallback(this);
            if (this._windowMenu)
            {
                WindowManager.getInstance().removeWindow(this._windowMenu);
            }
            this._windowMenu = null;
            if (this._btnBase)
            {
                ButtonManager.getInstance().removeButton(this._btnBase);
            }
            this._btnBase = null;
            this._cbClose = null;
            this._cbMenu = null;
            this._cbOpen = null;
            this._aList = null;
            this._btnMc = null;
            this._textMc = null;
            this._baseMc = null;
            return;
        }// end function

        public function setSelectIndex(param1:int) : void
        {
            var _loc_2:* = null;
            if (param1 >= this._aList.length)
            {
                param1 = this._aList.length;
            }
            if (param1 < 0)
            {
                param1 = 0;
            }
            if (this._selectIndex != param1)
            {
                this._selectIndex = param1;
                _loc_2 = this._aList[this._selectIndex];
                TextControl.setText(this._textMc.textDt, _loc_2.text);
            }
            return;
        }// end function

        public function searchIndex(param1:int) : int
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aList.length)
            {
                
                _loc_3 = this._aList[_loc_2];
                if (_loc_3.id == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public function setEnable(param1:Boolean) : void
        {
            this._bEnable = param1;
            this._btnBase.setDisable(!this._bEnable || this._bMenuOpen);
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            if (this._windowMenu != null)
            {
                if (!this._windowMenu.hitTestPoint(event.stageX, event.stageY) && !this._btnBase.getHitMoveClip().hitTestPoint(event.stageX, event.stageY))
                {
                    WindowManager.getInstance().removeWindow(this._windowMenu);
                    this._windowMenu = null;
                    this._bMenuOpen = false;
                    this.setEnable(this._bEnable);
                    if (this._cbClose != null)
                    {
                        this._cbClose();
                    }
                }
            }
            return;
        }// end function

        private function cbClick(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            this._bMenuOpen = true;
            this.setEnable(this._bEnable);
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._aList.length)
            {
                
                _loc_5 = this._aList[_loc_3];
                _loc_6 = new WindowTextButton(_loc_5.text, this.cbSelect, _loc_3);
                _loc_2.push(_loc_6);
                _loc_3++;
            }
            var _loc_4:* = new WindowStyle();
            if (this._windowMenu)
            {
                WindowManager.getInstance().removeWindow(this._windowMenu);
            }
            this._windowMenu = null;
            this._windowMenu = WindowManager.getInstance().createMenuWindow(this._baseMc, _loc_2, _loc_4, new Point(0, this._baseMc.height));
            if (this._cbOpen != null)
            {
                this._cbOpen();
            }
            return;
        }// end function

        private function cbSelect(param1:int) : void
        {
            var _loc_2:* = null;
            this.setSelectIndex(param1);
            this._windowMenu = null;
            this._bMenuOpen = false;
            this.setEnable(this._bEnable);
            if (this._cbMenu != null)
            {
                _loc_2 = this._aList[this._selectIndex];
                this._cbMenu(_loc_2.id);
            }
            return;
        }// end function

    }
}
