package trainingRoom
{
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import player.*;
    import playerList.*;
    import sound.*;

    public class KumitePlayerList extends PlayerListBase
    {
        private var _balloonEmperor:KumitePlayerListBalloon;
        private var _selectSkillData:OwnSkillData;
        private var _aPartnerChara:Array;

        public function KumitePlayerList(param1:MovieClip, param2:Array)
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            this._balloonEmperor = null;
            this._selectSkillData = null;
            super(param1, param2, 2);
            _bEnableBalloonStatus = true;
            for each (_loc_3 in _aListPlayerDisplay)
            {
                
                _loc_3.playerDisplay.setReverse(true);
            }
            _loc_4 = CommonConstant.KUMITE_LIST_UPDATE_TIME_1 / 3600;
            _loc_5 = CommonConstant.KUMITE_LIST_UPDATE_TIME_2 / 3600;
            TextControl.setText(_mcBase.infoTextMc.textDt, TextControl.formatIdText(MessageId.TRAINING_ROOM_KUMITE_LIST_TIPS, _loc_4, _loc_5));
            return;
        }// end function

        override public function release() : void
        {
            if (this._balloonEmperor)
            {
                this._balloonEmperor.release();
            }
            this._balloonEmperor = null;
            this._selectSkillData = null;
            this._aPartnerChara = null;
            super.release();
            return;
        }// end function

        override protected function initCharacterNull() : void
        {
            var _loc_2:* = null;
            this._aPartnerChara = [];
            _aPlayerNull = [];
            var _loc_1:* = 0;
            while (_loc_1 < listCount)
            {
                
                _loc_2 = _mcBase["PartnerChara" + (_loc_1 + 1)];
                if (_loc_2)
                {
                    this._aPartnerChara.push(_loc_2);
                    _aPlayerNull.push(_loc_2.charaNull);
                }
                _loc_1++;
            }
            return;
        }// end function

        override protected function onMouseOutPlayer(param1:int, param2:ListPlayerDisplay, param3:Boolean) : void
        {
            if (this._balloonEmperor && this._balloonEmperor.isShow())
            {
                this._balloonEmperor.hide();
            }
            super.onMouseOutPlayer(param1, param2, param3);
            return;
        }// end function

        override protected function onSelectPlayer(param1:int, param2:ListPlayerDisplay, param3:ListPlayerDisplay) : void
        {
            if (param3 && param3 != param2)
            {
                param3.playerDisplay.setSelect(false);
                param3.playerActionController.resetAction();
            }
            var _loc_4:* = param2.playerData as KumiteListPlayerData;
            if ((param2.playerData as KumiteListPlayerData).kumitePlayerData.isDone)
            {
                resetSelect();
                SoundManager.getInstance().playSe(SoundId.SE_GACHA_DISABLE);
                return;
            }
            SoundManager.getInstance().playSe(SoundId.SE_CHARA_SELECT);
            if (_cbPlayerSelectFunc != null)
            {
                _cbPlayerSelectFunc(param1, param2.playerData);
            }
            return;
        }// end function

        override protected function showBalloonStatus(param1:int, param2:ListPlayerDisplay) : void
        {
            var _loc_3:* = new Point();
            var _loc_4:* = param1 / _listRowCount >= 1;
            _loc_3.x = _mcBase.localToGlobal(new Point()).x + _BALLOON_STATUS_DISPLAY_POSITION_X;
            _loc_3.y = getPlayerPosition(param1).y;
            _loc_3.y = _loc_3.y + (_loc_4 ? (_BALLOON_STATUS_DISPLAY_POSITION_TOP) : (_BALLOON_STATUS_DISPLAY_POSITION_UNDER));
            var _loc_5:* = param2.playerData as KumiteListPlayerData;
            if (this._balloonEmperor == null)
            {
                this._balloonEmperor = new KumitePlayerListBalloon(Main.GetProcess());
            }
            this._balloonEmperor.setKumitePlayerData(_loc_5, this._selectSkillData);
            this._balloonEmperor.setPosition(_loc_3);
            this._balloonEmperor.setArrowTargetPosition(getPlayerPosition(param1));
            this._balloonEmperor.show();
            return;
        }// end function

        override protected function hideBalloonStatus() : void
        {
            if (this._balloonEmperor && this._balloonEmperor.isShow())
            {
                this._balloonEmperor.hide();
            }
            return;
        }// end function

        override public function isBalloonHit() : Boolean
        {
            return false;
        }// end function

        override public function removePlayer(param1:int) : void
        {
            return;
        }// end function

        override public function createPlayerList() : void
        {
            var _loc_1:* = null;
            _aListShowPlayerData = [];
            for each (_loc_1 in _aListPlayerData)
            {
                
                _aListShowPlayerData.push(_loc_1);
            }
            _aListShowPlayerData.sort(this.sortCompareKumite);
            return;
        }// end function

        private function sortCompareKumite(param1:KumiteListPlayerData, param2:KumiteListPlayerData) : int
        {
            var _loc_3:* = param2.kumitePlayerData.userId - param1.kumitePlayerData.userId;
            if (_loc_3 == 0)
            {
                _loc_3 = param2.info.id - param1.info.id;
            }
            return _bAscend ? (-_loc_3) : (_loc_3);
        }// end function

        override public function updateList() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aPartnerChara)
            {
                
                _loc_1.SpentIcon.visible = false;
                _loc_1.SuccessIcon.visible = false;
            }
            super.updateList();
            return;
        }// end function

        override protected function onUpdatePlayer(param1:int, param2:ListPlayerDisplay, param3:Boolean) : void
        {
            var _loc_5:* = null;
            super.onUpdatePlayer(param1, param2, param3);
            var _loc_4:* = this._aPartnerChara[param1];
            if (this._aPartnerChara[param1])
            {
                _loc_5 = param2.playerData as KumiteListPlayerData;
                _loc_4.SpentIcon.visible = _loc_5.kumitePlayerData.isDone;
                _loc_4.SuccessIcon.visible = TrainingRoomTable.getTrainingKumiteGreatSuccessProbabilityBonus(this._selectSkillData, _loc_5.kumitePlayerData) > 0;
            }
            return;
        }// end function

        public function removePlayerCustom(param1:int, param2:int) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = _aListPlayerData.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = _aListPlayerData[_loc_3] as KumiteListPlayerData;
                if (_loc_4.kumitePlayerData.userId == param1 && _loc_4.kumitePlayerData.playerId == param2)
                {
                    _aListPlayerData.splice(_loc_3, 1);
                }
                _loc_3 = _loc_3 - 1;
            }
            this.createPlayerList();
            return;
        }// end function

        public function setSelectSkill(param1:OwnSkillData) : void
        {
            this._selectSkillData = param1;
            return;
        }// end function

        public static function loadResource() : void
        {
            loadSoundResourceBase();
            SoundManager.getInstance().loadSoundArray([SoundId.SE_GACHA_DISABLE]);
            KumitePlayerListBalloon.loadResource();
            return;
        }// end function

    }
}
