package playerList
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import message.*;
    import resource.*;
    import sound.*;
    import status.*;
    import utility.*;
    import window.*;

    public class PlayerListBase extends Object
    {
        protected var _listColCount:int;
        protected var _listRowCount:int;
        protected var _mcBase:MovieClip;
        protected var _mcInfoBar:MovieClip;
        protected var _isoInfoBar:InStayOut;
        protected var _aPlayerNull:Array;
        protected var _aListPlayerData:Array;
        protected var _aNotDisplayPlayerUniqueId:Array;
        protected var _aListShowPlayerData:Array;
        protected var _aListPlayerDisplay:Array;
        protected var _page:PageButton;
        protected var _sortBtn:ButtonBase;
        protected var _ascendBtn:ButtonBase;
        protected var _descendBtn:ButtonBase;
        protected var _aSortTextId:Array;
        protected var _aSortId:Array;
        protected var _selectSortId:int = 0;
        protected var _sortWindowMenu:WindowMenu;
        protected var _bAscend:Boolean;
        protected var _bEnableBtn:Boolean = true;
        protected var _bPlayerSelectEnable:Boolean;
        protected var _cbPlayerSelectFunc:Function;
        protected var _cbPlayerUnselectFunc:Function;
        protected var _cbPlayerMouseOverFunc:Function;
        protected var _cbPlayerMouseOutFunc:Function;
        protected var _mouseOverPlayer:ListPlayerDisplay;
        protected var _mouseDownPlayer:ListPlayerDisplay;
        protected var _selectedPlayer:ListPlayerDisplay;
        protected var _selectedListPlayerData:ListPlayerData;
        protected var _balloonStatus:PlayerSimpleStatus;
        protected var _bEnableBalloonStatus:Boolean;
        static const _BALLOON_STATUS_DISPLAY_POSITION_X:int = 243;
        static const _BALLOON_STATUS_DISPLAY_POSITION_TOP:int = -190;
        static const _BALLOON_STATUS_DISPLAY_POSITION_UNDER:int = 105;

        public function PlayerListBase(param1:MovieClip, param2:Array, param3:int = 3, param4:int = 4)
        {
            this._aSortTextId = [MessageId.PLAYER_LIST_SORT_NEW, MessageId.PLAYER_LIST_SORT_CHARACTER, MessageId.PLAYER_LIST_SORT_RARITY, MessageId.PLAYER_LIST_SORT_HP, MessageId.PLAYER_LIST_SORT_ATTACK, MessageId.PLAYER_LIST_SORT_DEFENSE, MessageId.PLAYER_LIST_SORT_SPEED, MessageId.PLAYER_LIST_SORT_BATTLE_COUNT];
            this._aSortId = [ListPlayerSort.SORT_ID_NEW, ListPlayerSort.SORT_ID_CHARACTER_NAME, ListPlayerSort.SORT_ID_RARITY, ListPlayerSort.SORT_ID_HP, ListPlayerSort.SORT_ID_ATTACK, ListPlayerSort.SORT_ID_DEFENSE, ListPlayerSort.SORT_ID_SPEED, ListPlayerSort.SORT_ID_BATTLE_COUNT];
            this._mcBase = param1;
            this._mcInfoBar = param1.infoWindowMc;
            this._isoInfoBar = null;
            if (this._mcInfoBar)
            {
                this._isoInfoBar = new InStayOut(this._mcInfoBar);
            }
            this._aListPlayerData = param2;
            this._listColCount = param3;
            this._listRowCount = param4;
            this._aNotDisplayPlayerUniqueId = [];
            this._cbPlayerSelectFunc = null;
            this._cbPlayerUnselectFunc = null;
            this._cbPlayerMouseOverFunc = null;
            this._cbPlayerMouseOutFunc = null;
            this._mouseOverPlayer = null;
            this._mouseDownPlayer = null;
            this._selectedPlayer = null;
            this._selectedListPlayerData = null;
            this._sortWindowMenu = null;
            this._balloonStatus = null;
            this._bPlayerSelectEnable = true;
            this._bEnableBalloonStatus = true;
            this.initCharacterNull();
            this._page = new PageButton(this._mcBase.pageBtnSetGuidMc ? (this._mcBase.pageBtnSetGuidMc) : (this._mcBase), this.cbChangePage);
            this._sortBtn = null;
            if (this._mcBase.sortBtnMc)
            {
                this._sortBtn = ButtonManager.getInstance().addButton(this._mcBase.sortBtnMc, this.cbClickSortOn);
                this._sortBtn.enterSeId = ButtonBase.SE_CURSOR_ID;
            }
            this._ascendBtn = null;
            if (this._mcBase.ascendingOrderBtn)
            {
                this._ascendBtn = ButtonManager.getInstance().addButton(this._mcBase.ascendingOrderBtn, this.cbClickAscend);
                this._ascendBtn.enterSeId = ButtonBase.SE_CURSOR_ID;
                TextControl.setIdText(this._mcBase.ascendingOrderBtn.textMc.textDt, MessageId.PLAYER_LIST_SORT_LOWER_BUTTON);
            }
            this._descendBtn = null;
            if (this._mcBase.descendingOrderBtn)
            {
                this._descendBtn = ButtonManager.getInstance().addButton(this._mcBase.descendingOrderBtn, this.cbClickDescend);
                this._descendBtn.getMoveClip().visible = false;
                this._descendBtn.enterSeId = ButtonBase.SE_CURSOR_ID;
                TextControl.setIdText(this._mcBase.descendingOrderBtn.textMc.textDt, MessageId.PLAYER_LIST_SORT_UPPER_BUTTON);
            }
            this._bAscend = false;
            if (this._mcBase.sortTextMc)
            {
                TextControl.setIdText(this._mcBase.sortTextMc.textDt, this._aSortTextId[this._selectSortId]);
            }
            this.initListPlayerDisplay();
            this.createPlayerList();
            this.changePickupStatus();
            this.btnEnable(true);
            InputManager.getInstance().addMouseCallback(this, this.cbMouseMove, this.cbMouseClick, this.cbMouseUp, this.cbMouseDown, 0);
            return;
        }// end function

        public function get listColCount() : int
        {
            return this._listColCount;
        }// end function

        public function get listRowCount() : int
        {
            return this._listRowCount;
        }// end function

        public function get listCount() : int
        {
            return this._listColCount * this._listRowCount;
        }// end function

        private function initListPlayerDisplay() : void
        {
            var _loc_2:* = null;
            this._aListPlayerDisplay = [];
            var _loc_1:* = 0;
            while (_loc_1 < this._aPlayerNull.length)
            {
                
                _loc_2 = this._aPlayerNull[_loc_1];
                this._aListPlayerDisplay.push(this.createListPlayerDisplay(_loc_2));
                _loc_1++;
            }
            return;
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._sortBtn);
            this._sortBtn = null;
            ButtonManager.getInstance().removeButton(this._ascendBtn);
            this._ascendBtn = null;
            ButtonManager.getInstance().removeButton(this._descendBtn);
            this._descendBtn = null;
            if (this._page)
            {
                this._page.release();
            }
            this._page = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._aListPlayerDisplay.length)
            {
                
                this._aListPlayerDisplay[_loc_1].release();
                _loc_1++;
            }
            this._aListPlayerDisplay = null;
            if (this._balloonStatus)
            {
                this._balloonStatus.release();
            }
            this._balloonStatus = null;
            if (this._isoInfoBar)
            {
                this._isoInfoBar.release();
            }
            this._isoInfoBar = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            InputManager.getInstance().delMouseCallback(this);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

        public function setPlayerSelectCallback(param1:Function) : void
        {
            this._cbPlayerSelectFunc = param1;
            return;
        }// end function

        public function setPlayerUnselectCallback(param1:Function) : void
        {
            this._cbPlayerUnselectFunc = param1;
            return;
        }// end function

        public function setPlayerMouseOverCallback(param1:Function) : void
        {
            this._cbPlayerMouseOverFunc = param1;
            return;
        }// end function

        public function setPlayerMouseOutCallback(param1:Function) : void
        {
            this._cbPlayerMouseOutFunc = param1;
            return;
        }// end function

        public function setCaptionText(param1:String) : void
        {
            TextControl.setText(this._mcBase.reserveListTitleMc.textDt, param1);
            return;
        }// end function

        public function setCaptionIdText(param1:int) : void
        {
            TextControl.setIdText(this._mcBase.reserveListTitleMc.textDt, param1);
            return;
        }// end function

        public function setSelectEnable(param1:Boolean) : void
        {
            this.setPlayerSelectEnable(param1);
            this.btnEnable(param1);
            return;
        }// end function

        public function setPlayerSelectEnable(param1:Boolean) : void
        {
            var _loc_2:* = this._bPlayerSelectEnable != param1;
            this._bPlayerSelectEnable = param1;
            if (_loc_2)
            {
                if (!this._bPlayerSelectEnable)
                {
                    if (this._mouseOverPlayer && this._mouseOverPlayer != this._selectedPlayer)
                    {
                        this._mouseOverPlayer.bMouseOver = false;
                        this._mouseOverPlayer.playerActionController.resetAction();
                    }
                    this._mouseOverPlayer = null;
                    this.hideBalloonStatus();
                }
                else
                {
                    this.cbMouseMove(null);
                }
            }
            return;
        }// end function

        public function resetSelect() : void
        {
            if (this._selectedPlayer)
            {
                this._selectedPlayer.bMouseOver = false;
                this._selectedPlayer.playerDisplay.setSelect(false);
                this._selectedPlayer.playerActionController.resetAction();
            }
            this._selectedPlayer = null;
            this._selectedListPlayerData = null;
            this.hideBalloonStatus();
            return;
        }// end function

        public function getSelectedPlayerData() : ListPlayerData
        {
            return this._selectedPlayer ? (this._selectedPlayer.playerData) : (null);
        }// end function

        public function getSelectedPlayerPosition() : Point
        {
            if (this._selectedPlayer)
            {
                return this._selectedPlayer.playerDisplay.effectNull.localToGlobal(new Point());
            }
            return new Point(0, 0);
        }// end function

        public function getPlayerPosition(param1:int) : Point
        {
            if (param1 < 0 && param1 >= this._aListPlayerDisplay.length)
            {
                return new Point(0, 0);
            }
            return (this._aListPlayerDisplay[param1] as ListPlayerDisplay).playerDisplay.effectNull.localToGlobal(new Point());
        }// end function

        public function isOpenedSortMenu() : Boolean
        {
            return this._sortWindowMenu != null;
        }// end function

        public function setPlayerList(param1:Array) : void
        {
            this._aListPlayerData = param1;
            this.createPlayerList();
            return;
        }// end function

        public function addPlayer(param1:ListPlayerData) : void
        {
            this._aListPlayerData.push(param1);
            this.createPlayerList();
            return;
        }// end function

        public function removePlayer(param1:int) : void
        {
            var _loc_2:* = this._aListPlayerData.length - 1;
            while (_loc_2 >= 0)
            {
                
                if ((this._aListPlayerData[_loc_2] as ListPlayerData).personal.uniqueId == param1)
                {
                    this._aListPlayerData.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            this.createPlayerList();
            return;
        }// end function

        public function setNotDisplayPlayer(param1:Array) : void
        {
            this._aNotDisplayPlayerUniqueId = param1.concat();
            this.createPlayerList();
            return;
        }// end function

        public function addNotDisplayPlayer(param1:int) : void
        {
            if (this._aNotDisplayPlayerUniqueId.indexOf(param1) == -1)
            {
                this._aNotDisplayPlayerUniqueId.push(param1);
            }
            this.createPlayerList();
            return;
        }// end function

        public function removeNotDisplayPlayer(param1:int) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._aNotDisplayPlayerUniqueId.length)
            {
                
                if (this._aNotDisplayPlayerUniqueId[_loc_2] == param1)
                {
                    this._aNotDisplayPlayerUniqueId.splice(_loc_2, 1);
                    break;
                }
                _loc_2++;
            }
            this.createPlayerList();
            return;
        }// end function

        public function createPlayerList() : void
        {
            var _loc_1:* = null;
            this._aListShowPlayerData = [];
            for each (_loc_1 in this._aListPlayerData)
            {
                
                if (this._aNotDisplayPlayerUniqueId.indexOf(_loc_1.personal.uniqueId) == -1)
                {
                    this._aListShowPlayerData.push(_loc_1);
                }
            }
            this.sortListPlayerData(this._selectSortId);
            return;
        }// end function

        public function updateList() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = false;
            this._page.setMaxPage(Math.ceil(this._aListShowPlayerData.length / this.listCount));
            this.btnEnable(this._bEnableBtn);
            var _loc_1:* = this._page.pageIndex * this.listCount;
            var _loc_2:* = 0;
            while (_loc_2 < this._aListPlayerDisplay.length)
            {
                
                _loc_3 = this._aListPlayerDisplay[_loc_2];
                _loc_4 = _loc_1 + _loc_2;
                if (_loc_4 < this._aListShowPlayerData.length)
                {
                    _loc_5 = this._aListShowPlayerData[_loc_4];
                    _loc_3.setPlayerData(_loc_5);
                    _loc_6 = this.isSelectedPlayer(_loc_3);
                    _loc_3.playerDisplay.setSelect(_loc_6);
                    this.onUpdatePlayer(_loc_2, _loc_3, _loc_6);
                }
                else
                {
                    _loc_3.reset();
                }
                _loc_2++;
            }
            return;
        }// end function

        public function isBalloonHit() : Boolean
        {
            return this._balloonStatus && this._balloonStatus.isHitTest();
        }// end function

        public function setInformationBarMessage(param1:String) : void
        {
            var _loc_2:* = null;
            if (this._mcInfoBar)
            {
                _loc_2 = param1.split("\n");
                this._mcInfoBar.infoMc.gotoAndStop(_loc_2.length > 1 ? ("2line") : ("1line"));
                TextControl.setText(this._mcInfoBar.infoMc.infoWindowTextMc.textDt, param1);
            }
            return;
        }// end function

        public function checkEmptyInformation(param1:String = null) : void
        {
            var msg:* = param1;
            if (this._mcInfoBar && this._isoInfoBar)
            {
                if (this._aListShowPlayerData.length == 0)
                {
                    if (msg)
                    {
                        this.setInformationBarMessage(msg);
                    }
                    this.openInformationBar();
                }
                else
                {
                    this.closeInformationBar(function () : void
            {
                if (msg)
                {
                    setInformationBarMessage(msg);
                }
                return;
            }// end function
            );
                }
            }
            return;
        }// end function

        public function openInformationBar(param1:Function = null) : void
        {
            if (this._isoInfoBar)
            {
                if (this._isoInfoBar.bClosed)
                {
                    this._isoInfoBar.setIn(param1);
                }
                else if (param1 != null)
                {
                    this.param1();
                }
            }
            return;
        }// end function

        public function closeInformationBar(param1:Function = null) : void
        {
            if (this._isoInfoBar)
            {
                if (this._isoInfoBar.bOpened)
                {
                    this._isoInfoBar.setOut(param1);
                }
                else if (param1 != null)
                {
                    this.param1();
                }
            }
            return;
        }// end function

        public function setRestEndAction(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aListPlayerDisplay)
            {
                
                if (_loc_2.playerData && _loc_2.playerData.personal && _loc_2.playerData.personal.uniqueId == param1)
                {
                    _loc_2.playerActionController.restEndAction();
                    break;
                }
            }
            return;
        }// end function

        protected function initCharacterNull() : void
        {
            this._aPlayerNull = [];
            var _loc_1:* = 0;
            while (_loc_1 < this.listCount)
            {
                
                this._aPlayerNull.push(this._mcBase["charaNull" + (_loc_1 + 1)]);
                _loc_1++;
            }
            return;
        }// end function

        protected function createListPlayerDisplay(param1:MovieClip) : ListPlayerDisplay
        {
            return new ListPlayerDisplay(this.createMiniStatus(param1));
        }// end function

        protected function createMiniStatus(param1:MovieClip) : PlayerMiniStatus
        {
            return new PlayerMiniStatus(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", param1);
        }// end function

        protected function onMouseOverPlayer(param1:int, param2:ListPlayerDisplay, param3:Boolean) : void
        {
            var listIndex:* = param1;
            var listPlayerDisplay:* = param2;
            var bSelected:* = param3;
            if (listPlayerDisplay.playerActionController.bMouseOverAction)
            {
                if (this.isEnableBalloonStatus())
                {
                    this.showBalloonStatus(listIndex, listPlayerDisplay);
                }
                if (this._cbPlayerMouseOverFunc != null)
                {
                    this._cbPlayerMouseOverFunc(listIndex, listPlayerDisplay.playerData);
                }
            }
            else
            {
                listPlayerDisplay.playerActionController.mouseOverAction(function () : void
            {
                if (isEnableBalloonStatus())
                {
                    showBalloonStatus(listIndex, listPlayerDisplay);
                }
                if (_cbPlayerMouseOverFunc != null)
                {
                    _cbPlayerMouseOverFunc(listIndex, listPlayerDisplay.playerData);
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        protected function onMouseOutPlayer(param1:int, param2:ListPlayerDisplay, param3:Boolean) : void
        {
            this.hideBalloonStatus();
            if (!param3)
            {
                param2.playerActionController.resetAction();
            }
            if (this._cbPlayerMouseOutFunc != null)
            {
                this._cbPlayerMouseOutFunc(param1, param2.playerData);
            }
            return;
        }// end function

        protected function onSelectPlayer(param1:int, param2:ListPlayerDisplay, param3:ListPlayerDisplay) : void
        {
            if (param3 && param3 != param2)
            {
                param3.playerDisplay.setSelect(false);
                param3.playerActionController.resetAction();
            }
            SoundManager.getInstance().playSe(SoundId.SE_CHARA_SELECT);
            if (this._cbPlayerSelectFunc != null)
            {
                this._cbPlayerSelectFunc(param1, param2.playerData);
            }
            return;
        }// end function

        protected function onClickOutside() : void
        {
            return;
        }// end function

        protected function onUpdatePlayer(param1:int, param2:ListPlayerDisplay, param3:Boolean) : void
        {
            if (param2.playerActionController.bMouseOverAction)
            {
                if (!param3)
                {
                    param2.playerActionController.resetAction();
                }
            }
            else if (param3)
            {
                param2.playerActionController.mouseOverAction();
            }
            param2.playerActionController.update();
            return;
        }// end function

        protected function isSelectedPlayer(param1:ListPlayerDisplay) : Boolean
        {
            return this._selectedListPlayerData && this._selectedListPlayerData == param1.playerData;
        }// end function

        protected function showBalloonStatus(param1:int, param2:ListPlayerDisplay) : void
        {
            var _loc_3:* = new Point();
            var _loc_4:* = param1 / this._listRowCount >= 2;
            _loc_3.x = this._mcBase.localToGlobal(new Point()).x + _BALLOON_STATUS_DISPLAY_POSITION_X;
            _loc_3.y = this.getPlayerPosition(param1).y;
            _loc_3.y = _loc_3.y + (_loc_4 ? (_BALLOON_STATUS_DISPLAY_POSITION_TOP) : (_BALLOON_STATUS_DISPLAY_POSITION_UNDER));
            if (param2.playerData != null)
            {
                if (this._balloonStatus == null)
                {
                    this._balloonStatus = this.createBalloonStatus();
                }
                this.setupBalloonStatus(param1, param2);
                this._balloonStatus.setPosition(_loc_3);
                this._balloonStatus.setArrowTargetPosition(this.getPlayerPosition(param1));
                this._balloonStatus.show();
            }
            return;
        }// end function

        protected function hideBalloonStatus() : void
        {
            if (this._balloonStatus && this._balloonStatus.isShow())
            {
                this._balloonStatus.hide();
            }
            return;
        }// end function

        protected function createBalloonStatus() : PlayerSimpleStatus
        {
            return new PlayerSimpleStatus(Main.GetProcess(), PlayerSimpleStatus.LABEL_MAIN);
        }// end function

        protected function setupBalloonStatus(param1:int, param2:ListPlayerDisplay) : void
        {
            this._balloonStatus.setStatus(param2.playerData.personal);
            return;
        }// end function

        protected function isEnableBalloonStatus() : Boolean
        {
            return this._bEnableBalloonStatus && this._bPlayerSelectEnable;
        }// end function

        protected function sortList(param1:int) : void
        {
            this.sortListPlayerData(this._aSortId[param1]);
            TextControl.setIdText(this._mcBase.sortTextMc.textDt, this._aSortTextId[this._selectSortId]);
            this.changePickupStatus();
            this.resetMouseOverAction();
            this.updateList();
            return;
        }// end function

        protected function sortListPlayerData(param1:int) : void
        {
            this._selectSortId = param1;
            ListPlayerSort.sortListPlayer(this._aListShowPlayerData, this._selectSortId, this._bAscend);
            return;
        }// end function

        protected function changePickupStatus() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = StatusConstant.PICKUP_STATUS_NONE;
            switch(this._selectSortId)
            {
                case ListPlayerSort.SORT_ID_CHARACTER_NAME:
                {
                    _loc_1 = StatusConstant.PICKUP_STATUS_NONE;
                    break;
                }
                case ListPlayerSort.SORT_ID_RARITY:
                {
                    _loc_1 = StatusConstant.PICKUP_STATUS_NONE;
                    break;
                }
                case ListPlayerSort.SORT_ID_NEW:
                {
                    _loc_1 = StatusConstant.PICKUP_STATUS_GET_TIME;
                    break;
                }
                case ListPlayerSort.SORT_ID_BATTLE_COUNT:
                {
                    _loc_1 = StatusConstant.PICKUP_STATUS_USE_COUNT;
                    break;
                }
                case ListPlayerSort.SORT_ID_HP:
                {
                    _loc_1 = StatusConstant.PICKUP_STATUS_HP;
                    break;
                }
                case ListPlayerSort.SORT_ID_ATTACK:
                {
                    _loc_1 = StatusConstant.PICKUP_STATUS_ATTACK;
                    break;
                }
                case ListPlayerSort.SORT_ID_DEFENSE:
                {
                    _loc_1 = StatusConstant.PICKUP_STATUS_DEFENSE;
                    break;
                }
                case ListPlayerSort.SORT_ID_SPEED:
                {
                    _loc_1 = StatusConstant.PICKUP_STATUS_SPEED;
                    break;
                }
                case ListPlayerSort.SORT_ID_RESTORE_TIME:
                {
                    _loc_1 = StatusConstant.PICKUP_STATUS_RESTORE_TIME;
                    break;
                }
                default:
                {
                    break;
                }
            }
            for each (_loc_2 in this._aListPlayerDisplay)
            {
                
                _loc_2.status.setPickupStatus(_loc_1);
            }
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            this._bEnableBtn = param1;
            this._page.btnEnable(this._bEnableBtn);
            if (this._sortBtn)
            {
                this._sortBtn.setDisable(!this._bEnableBtn);
            }
            if (this._ascendBtn)
            {
                this._ascendBtn.setDisable(!this._bEnableBtn || this._bAscend);
            }
            if (this._descendBtn)
            {
                this._descendBtn.setDisable(!this._bEnableBtn || !this._bAscend);
            }
            return;
        }// end function

        private function resetMouseOverAction() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aListPlayerDisplay)
            {
                
                if (_loc_1.bShow && _loc_1.playerActionController.bMouseOverAction)
                {
                    _loc_1.playerActionController.resetAction();
                }
            }
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
            this.resetMouseOverAction();
            this.updateList();
            return true;
        }// end function

        private function cbClickSortOn(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._aSortId.length)
            {
                
                _loc_5 = new WindowTextButton(MessageManager.getInstance().getMessage(this._aSortTextId[this._aSortId[_loc_3]]), this.cbSortSelect, _loc_3);
                _loc_2.push(_loc_5);
                _loc_3++;
            }
            var _loc_4:* = new WindowStyle();
            if (this._sortWindowMenu)
            {
                WindowManager.getInstance().removeWindow(this._sortWindowMenu);
            }
            this._sortWindowMenu = null;
            this._sortWindowMenu = WindowManager.getInstance().createMenuWindow(this._mcBase, _loc_2, _loc_4, new Point(this._mcBase.sortTextMc.x, this._mcBase.sortTextMc.y + 25));
            return;
        }// end function

        private function cbSortSelect(param1:int) : void
        {
            this.sortList(param1);
            this._sortWindowMenu = null;
            return;
        }// end function

        private function cbClickAscend(param1:int) : void
        {
            this._bAscend = true;
            if (this._ascendBtn)
            {
                this._ascendBtn.getMoveClip().visible = !this._bAscend;
            }
            if (this._descendBtn)
            {
                this._descendBtn.getMoveClip().visible = this._bAscend;
            }
            this.sortListPlayerData(this._selectSortId);
            this.resetMouseOverAction();
            this.updateList();
            this.btnEnable(this._bEnableBtn);
            return;
        }// end function

        private function cbClickDescend(param1:int) : void
        {
            this._bAscend = false;
            if (this._ascendBtn)
            {
                this._ascendBtn.getMoveClip().visible = !this._bAscend;
            }
            if (this._descendBtn)
            {
                this._descendBtn.getMoveClip().visible = this._bAscend;
            }
            this.sortListPlayerData(this._selectSortId);
            this.resetMouseOverAction();
            this.updateList();
            this.btnEnable(this._bEnableBtn);
            return;
        }// end function

        private function cbMouseMove(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_5:* = false;
            var _loc_6:* = false;
            if (!this._bPlayerSelectEnable || this.isOpenedSortMenu())
            {
                return;
            }
            var _loc_3:* = -1;
            var _loc_4:* = 0;
            for each (_loc_2 in this._aListPlayerDisplay)
            {
                
                if (_loc_2.bShow && _loc_2.playerDisplay.isHitTest())
                {
                    _loc_3 = _loc_4;
                    break;
                }
                _loc_4++;
            }
            if (_loc_3 == -1)
            {
                this._mouseOverPlayer = null;
            }
            _loc_4 = 0;
            for each (_loc_2 in this._aListPlayerDisplay)
            {
                
                if (_loc_2.bShow)
                {
                    _loc_5 = _loc_4 == _loc_3;
                    if (_loc_2.bMouseOver != _loc_5)
                    {
                        _loc_2.bMouseOver = _loc_5;
                        if (_loc_5)
                        {
                            this._mouseOverPlayer = _loc_2;
                            SoundManager.getInstance().playSe(ButtonBase.SE_SELECT_ID);
                        }
                        _loc_6 = this.isSelectedPlayer(_loc_2);
                        _loc_2.playerDisplay.setSelect(_loc_6 || _loc_5);
                        if (_loc_5)
                        {
                            this.onMouseOverPlayer(_loc_3, _loc_2, _loc_6);
                        }
                        else
                        {
                            this.onMouseOutPlayer(_loc_3, _loc_2, _loc_6);
                        }
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        private function cbMouseDown(event:MouseEvent) : void
        {
            this._mouseDownPlayer = this._mouseOverPlayer;
            return;
        }// end function

        private function cbMouseUp(event:MouseEvent) : void
        {
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (this.isOpenedSortMenu())
            {
                if (!this._sortWindowMenu.hitTestPoint(event.stageX, event.stageY) && !this._sortBtn.getHitMoveClip().hitTestPoint(event.stageX, event.stageY))
                {
                    WindowManager.getInstance().removeWindow(this._sortWindowMenu);
                    this._sortWindowMenu = null;
                    return;
                }
            }
            if (this._mouseDownPlayer && this._bPlayerSelectEnable)
            {
                _loc_2 = this._selectedPlayer;
                this._selectedPlayer = this._mouseDownPlayer;
                this._selectedListPlayerData = this._selectedPlayer ? (this._selectedPlayer.playerData) : (null);
                _loc_3 = 0;
                if (this._selectedListPlayerData)
                {
                    for each (_loc_4 in this._aListShowPlayerData)
                    {
                        
                        if (_loc_4 == this._selectedListPlayerData)
                        {
                            break;
                        }
                        ++_loc_3 = ++_loc_3 % this.listCount;
                    }
                }
                this.onSelectPlayer(++_loc_3, this._selectedPlayer, _loc_2);
            }
            else if (this._balloonStatus && !this._balloonStatus.isHitTest())
            {
                this.onClickOutside();
            }
            return;
        }// end function

        static function loadSoundResourceBase() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            SoundManager.getInstance().loadSoundArray([SoundId.SE_CHARA_SELECT]);
            return;
        }// end function

    }
}
