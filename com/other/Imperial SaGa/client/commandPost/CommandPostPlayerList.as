package commandPost
{
    import flash.display.*;
    import message.*;
    import playerList.*;
    import sound.*;
    import status.*;
    import user.*;

    public class CommandPostPlayerList extends PlayerListBase
    {
        private var _bFrontSelect:Boolean;
        private var _cbDetailBtn:Function;
        private var _cbSort:Function;

        public function CommandPostPlayerList(param1:MovieClip, param2:Array, param3:int)
        {
            this._bFrontSelect = false;
            this._cbDetailBtn = null;
            this._cbSort = null;
            super(param1, param2);
            _selectSortId = param3;
            TextControl.setIdText(_mcBase.sortTextMc.textDt, _aSortTextId[_selectSortId]);
            changePickupStatus();
            TextControl.setIdText(_mcBase.warriorNumTitleMc.textDt, MessageId.FORMATION_BELONG_COUNT);
            TextControl.setText(_mcBase.WarriorNumMc.textDt, UserDataManager.getInstance().getCurrentPlayerNum() + "/" + (UserDataManager.getInstance().getReserveMax() + UserDataManager.getInstance().userData.warriorIncrease));
            if (_balloonStatus == null)
            {
                _balloonStatus = this.createBalloonStatus();
                _balloonStatus.hide();
            }
            return;
        }// end function

        public function get bFrontSelect() : Boolean
        {
            return this._bFrontSelect;
        }// end function

        public function setFrontSelect(param1:Boolean) : void
        {
            this._bFrontSelect = param1;
            return;
        }// end function

        override protected function onMouseOutPlayer(param1:int, param2:ListPlayerDisplay, param3:Boolean) : void
        {
            if (_selectedPlayer == null)
            {
                hideBalloonStatus();
            }
            if (!param3)
            {
                param2.playerActionController.resetAction();
            }
            if (_cbPlayerMouseOutFunc != null)
            {
                _cbPlayerMouseOutFunc(param1, param2.playerData);
            }
            return;
        }// end function

        override protected function onSelectPlayer(param1:int, param2:ListPlayerDisplay, param3:ListPlayerDisplay) : void
        {
            super.onSelectPlayer(param1, param2, param3);
            if (_bEnableBalloonStatus && !this._bFrontSelect)
            {
                if (_balloonStatus == null || !_balloonStatus.isShow() || param2.playerDisplay.uniqueId != _balloonStatus.uniqueId)
                {
                    showBalloonStatus(param1, param2);
                }
            }
            return;
        }// end function

        override protected function createBalloonStatus() : PlayerSimpleStatus
        {
            var _loc_1:* = new PlayerSimpleStatus(Main.GetProcess(), PlayerSimpleStatus.LABEL_MAIN);
            _loc_1.setEnablePlayerDetail(this.cbDetailBtn, null, false);
            return _loc_1;
        }// end function

        override protected function isEnableBalloonStatus() : Boolean
        {
            return super.isEnableBalloonStatus() && !this._bFrontSelect && (_selectedPlayer == null || !_balloonStatus.isShow());
        }// end function

        override protected function onClickOutside() : void
        {
            var _loc_1:* = _selectedPlayer != null;
            resetSelect();
            if (_loc_1)
            {
                SoundManager.getInstance().playSe(SoundId.SE_CANCEL);
            }
            if (_loc_1 && _cbPlayerUnselectFunc != null)
            {
                _cbPlayerUnselectFunc();
            }
            return;
        }// end function

        override protected function sortList(param1:int) : void
        {
            super.sortList(param1);
            if (this._cbSort != null)
            {
                this._cbSort(param1);
            }
            return;
        }// end function

        public function updatePlayerUseFacilityStatus() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_1:* = _page.pageIndex * listCount;
            var _loc_2:* = 0;
            while (_loc_2 < _aListPlayerDisplay.length)
            {
                
                _loc_3 = _aListPlayerDisplay[_loc_2];
                _loc_4 = _loc_1 + _loc_2;
                if (_loc_4 < _aListShowPlayerData.length)
                {
                    if (_loc_3.playerActionController.state == ListPlayerActionController.STATE_RESTING)
                    {
                        _loc_3.status.updateGauge();
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function setDetailBtnCallback(param1:Function) : void
        {
            this._cbDetailBtn = param1;
            return;
        }// end function

        public function setChangeSortCallback(param1:Function) : void
        {
            this._cbSort = param1;
            return;
        }// end function

        public function setPageDisable(param1:Boolean) : void
        {
            _page.btnDisable(param1);
            return;
        }// end function

        private function cbDetailBtn(param1:int) : void
        {
            if (this._cbDetailBtn != null)
            {
                this._cbDetailBtn(_balloonStatus.uniqueId);
            }
            resetSelect();
            return;
        }// end function

        public static function loadResource() : void
        {
            loadSoundResourceBase();
            PlayerSimpleStatus.loadResource();
            StatusManager.getInstance().loadResource();
            SoundManager.getInstance().loadSoundArray([SoundId.SE_CANCEL]);
            return;
        }// end function

    }
}
