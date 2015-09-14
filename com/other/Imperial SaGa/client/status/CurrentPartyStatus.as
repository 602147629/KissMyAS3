package status
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import formation.*;
    import input.*;
    import message.*;
    import player.*;
    import playerList.*;
    import resource.*;
    import sound.*;
    import user.*;

    public class CurrentPartyStatus extends Object
    {
        private var _baseMc:MovieClip;
        private var _aCharaNull:Array;
        private var _aStatusNull:Array;
        private var _aBtnNull:Array;
        private var _bSelectable:Boolean;
        private var _simpleStatus:PlayerSimpleStatus;
        private var _clickSelectListIndex:int;
        private var _cbClickSelect:Function;
        private var _aListPlayerDisplay:Array;
        private var _aListIndex:Array;
        private var _timer:Timer;

        public function CurrentPartyStatus(param1:MovieClip, param2:DisplayObjectContainer, param3:Function, param4:Boolean)
        {
            this._baseMc = param1;
            this._aCharaNull = [this._baseMc.charaNull1, this._baseMc.charaNull2, this._baseMc.charaNull3, this._baseMc.charaNull4, this._baseMc.charaNull5];
            this._aStatusNull = [this._baseMc.StatusNull1, this._baseMc.StatusNull2, this._baseMc.StatusNull3, this._baseMc.StatusNull4, this._baseMc.StatusNull5];
            this._aBtnNull = [this._baseMc.medicineBtnNull1, this._baseMc.medicineBtnNull2, this._baseMc.medicineBtnNull3, this._baseMc.medicineBtnNull4, this._baseMc.medicineBtnNull5];
            if (param4)
            {
                this._aCharaNull.push(this._baseMc.charaNull6);
                this._aStatusNull.push(this._baseMc.StatusNull6);
                this._aBtnNull.push(this._baseMc.medicineBtnNull6);
            }
            else
            {
                this._baseMc.charaNull6.visible = false;
                this._baseMc.StatusNull6.visible = false;
                this._baseMc.medicineBtnNull6.visible = false;
            }
            this._bSelectable = false;
            this._simpleStatus = new PlayerSimpleStatus(param2, PlayerSimpleStatus.LABEL_MAIN, null, null, false);
            this._aListPlayerDisplay = null;
            this._aListIndex = null;
            this._clickSelectListIndex = -1;
            this._cbClickSelect = param3;
            InputManager.getInstance().addMouseCallback(this, this.cbMouseMove, this.cbMouseClick);
            TextControl.setIdText(this._baseMc.textMc.textDt, MessageId.COMMON_MAIN_PARTY);
            this.setPartyCharacter();
            this._timer = new Timer(60000);
            this._timer.addEventListener(TimerEvent.TIMER, this.updateSPbar);
            this._timer.start();
            return;
        }// end function

        public function getBtnNull(param1:int) : MovieClip
        {
            return this._aBtnNull[this._aListIndex[param1]];
        }// end function

        public function get bSelectable() : Boolean
        {
            return this._bSelectable;
        }// end function

        public function set bSelectable(param1:Boolean) : void
        {
            if (this._bSelectable != param1)
            {
                this._bSelectable = param1;
                if (param1)
                {
                    this.cbMouseMove(null);
                }
                else if (this._simpleStatus)
                {
                    this._simpleStatus.hide();
                }
            }
            return;
        }// end function

        public function get clickSelectIdx() : int
        {
            return this._clickSelectListIndex;
        }// end function

        public function get clickSelectUniqueId() : int
        {
            var _loc_1:* = this._aListPlayerDisplay[this._clickSelectListIndex];
            if (_loc_1 && _loc_1.playerData && _loc_1.playerData.personal)
            {
                return _loc_1.playerData.personal.uniqueId;
            }
            return Constant.EMPTY_ID;
        }// end function

        public function release() : void
        {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.updateSPbar);
            this._timer = null;
            this.clear();
            InputManager.getInstance().delMouseCallback(this);
            this._cbClickSelect = null;
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            this._aBtnNull = null;
            this._aStatusNull = null;
            this._aCharaNull = null;
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

        public function updatePartyCharacter() : void
        {
            this.setPartyCharacter();
            return;
        }// end function

        public function setRestEndAction(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._aListPlayerDisplay)
            {
                for each (_loc_2 in this._aListPlayerDisplay)
                {
                    
                    if (_loc_2.playerData && _loc_2.playerData.personal && _loc_2.playerData.personal.uniqueId == param1)
                    {
                        _loc_2.playerActionController.restEndAction();
                        break;
                    }
                }
            }
            return;
        }// end function

        public function clearClickSelect() : void
        {
            this.onMouseOver(-1, false);
            this._clickSelectListIndex = -1;
            return;
        }// end function

        private function clear() : void
        {
            var _loc_1:* = null;
            this._simpleStatus.hide();
            if (this._aListPlayerDisplay)
            {
                for each (_loc_1 in this._aListPlayerDisplay)
                {
                    
                    _loc_1.release();
                }
                this._aListPlayerDisplay = null;
            }
            this._aListIndex = null;
            return;
        }// end function

        private function setPartyCharacter() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            this.clear();
            for each (_loc_1 in this._aCharaNull)
            {
                
                _loc_1.visible = false;
            }
            this._aListPlayerDisplay = [];
            this._aListIndex = [];
            _loc_2 = null;
            _loc_3 = UserDataManager.getInstance().userData.aFormationPlayerUniqueId;
            _loc_4 = 0;
            _loc_5 = 0;
            while (_loc_5 < _loc_3.length)
            {
                
                if (_loc_4 == FormationSetData.FORMATION_INDEX_COMMANDER)
                {
                    _loc_5 = FormationSetData.FORMATION_INDEX_COMMANDER;
                }
                _loc_6 = this._aCharaNull[_loc_5];
                _loc_7 = _loc_3[_loc_4];
                if (_loc_6 == null)
                {
                    break;
                }
                _loc_4++;
                if (_loc_7 != 0)
                {
                    _loc_8 = UserDataManager.getInstance().userData.getPlayerPersonal(_loc_7);
                    if (_loc_8 == null)
                    {
                        continue;
                    }
                    _loc_8.updateSp();
                    _loc_9 = (this._aListPlayerDisplay.length & 1) == 0 ? (PlayerMiniStatus.NAME_OFFS_1) : (PlayerMiniStatus.NAME_OFFS_2);
                    _loc_10 = new ListPlayerDisplay(new PlayerMiniStatus(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", _loc_6, null, false, _loc_9));
                    _loc_10.setPlayerData(new ListPlayerData(_loc_8));
                    _loc_10.playerActionController.resetAction();
                    this._aListPlayerDisplay.push(_loc_10);
                    this._aListIndex.push(_loc_5);
                    if (_loc_5 == FormationSetData.FORMATION_INDEX_COMMANDER)
                    {
                        _loc_2 = _loc_10;
                    }
                    _loc_5++;
                    _loc_6.visible = true;
                }
                if (_loc_4 >= _loc_3.length)
                {
                    break;
                }
            }
            CommanderSkillUtility.setupCommanderSkillField(this._baseMc.commanderSkillTextMc, this._baseMc.warningTextMc, _loc_2 ? (_loc_2.playerDisplay.info) : (null), this._aListPlayerDisplay.length, _loc_2 ? (_loc_2.status) : (null));
            return;
        }// end function

        private function updateSPbar(event:TimerEvent) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aListPlayerDisplay)
            {
                
                if (_loc_2.bShow)
                {
                    _loc_2.status.updateGauge();
                }
            }
            if (this._simpleStatus.isShow())
            {
                this._simpleStatus.updateHp();
                this._simpleStatus.updateSp();
            }
            return;
        }// end function

        private function cbMouseMove(event:MouseEvent) : void
        {
            if (!this._bSelectable || this._clickSelectListIndex != -1)
            {
                return;
            }
            var _loc_2:* = this.listPlayerHitTest();
            this.onMouseOver(_loc_2, true);
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            if (!this._bSelectable)
            {
                return;
            }
            var _loc_2:* = this.listPlayerHitTest();
            this.onMouseOver(_loc_2, false);
            if (this._clickSelectListIndex != _loc_2)
            {
                this._clickSelectListIndex = _loc_2;
                if (_loc_2 != -1)
                {
                    SoundManager.getInstance().playSe(ButtonBase.SE_DECIDE_ID);
                }
                if (this._cbClickSelect != null)
                {
                    this._cbClickSelect(_loc_2);
                }
            }
            return;
        }// end function

        private function listPlayerHitTest() : int
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._aListPlayerDisplay.length)
            {
                
                _loc_2 = this._aListPlayerDisplay[_loc_1];
                if (_loc_2.bShow && _loc_2.playerDisplay.isHitTest2())
                {
                    return _loc_1;
                }
                _loc_1++;
            }
            return -1;
        }// end function

        private function onMouseOver(param1:int, param2:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_3:* = false;
            var _loc_4:* = 0;
            while (_loc_4 < this._aListPlayerDisplay.length)
            {
                
                _loc_5 = this._aListPlayerDisplay[_loc_4];
                if (_loc_5.bShow)
                {
                    _loc_6 = _loc_4 == param1;
                    if (_loc_5.bMouseOver != _loc_6)
                    {
                        _loc_5.bMouseOver = _loc_6;
                        if (_loc_6 && param2)
                        {
                            SoundManager.getInstance().playSe(ButtonBase.SE_SELECT_ID);
                        }
                        _loc_5.playerDisplay.setSelect(_loc_6);
                        if (_loc_6)
                        {
                            this.onMouseOverPlayer(param1, _loc_5);
                            _loc_3 = true;
                        }
                        else
                        {
                            this.onMouseOutPlayer(param1, _loc_5, _loc_3);
                        }
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        protected function onMouseOverPlayer(param1:int, param2:ListPlayerDisplay) : void
        {
            var listIndex:* = param1;
            var listPlayerDisplay:* = param2;
            if (listPlayerDisplay.playerActionController.bMouseOverAction)
            {
                this.setStatus(listIndex, listPlayerDisplay.playerDisplay);
            }
            else
            {
                listPlayerDisplay.playerActionController.mouseOverAction(function () : void
            {
                setStatus(listIndex, listPlayerDisplay.playerDisplay);
                return;
            }// end function
            );
            }
            return;
        }// end function

        protected function onMouseOutPlayer(param1:int, param2:ListPlayerDisplay, param3:Boolean) : void
        {
            if (!param3)
            {
                this._simpleStatus.hide();
            }
            param2.playerActionController.resetAction();
            return;
        }// end function

        private function setStatus(param1:int, param2:PlayerDisplay) : Boolean
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_3:* = this._aListIndex[param1];
            var _loc_4:* = UserDataManager.getInstance().userData.getPlayerPersonal(param2.uniqueId);
            if (UserDataManager.getInstance().userData.getPlayerPersonal(param2.uniqueId))
            {
                _loc_5 = this._aCharaNull[_loc_3];
                _loc_6 = new Point(_loc_5.x, _loc_5.y);
                _loc_6 = _loc_5.parent.localToGlobal(_loc_6);
                if (param2.mc)
                {
                    _loc_6 = _loc_6.add(new Point(param2.effectNull.x, param2.effectNull.y));
                }
                _loc_7 = _loc_6.clone();
                _loc_5 = this._aStatusNull[_loc_3];
                _loc_6 = new Point(_loc_5.x, _loc_5.y);
                _loc_6 = _loc_5.parent.localToGlobal(_loc_6);
                _loc_8 = _loc_4.clone();
                _loc_8.updateSp();
                this._simpleStatus.setStatus(_loc_8);
                this._simpleStatus.setPosition(_loc_6);
                this._simpleStatus.show();
                this._simpleStatus.setArrowTargetPosition(_loc_7);
                return true;
            }
            return false;
        }// end function

    }
}
