package history
{
    import button.*;
    import develop.*;
    import flash.display.*;
    import flash.events.*;
    import formation.*;
    import icon.*;
    import input.*;
    import layer.*;
    import message.*;
    import player.*;
    import quest.*;
    import resource.*;
    import sound.*;
    import status.*;
    import utility.*;

    public class HistoryRecord extends Object
    {
        private var _layer:LayerHome;
        private var _baseMc:MovieClip;
        private var _isoMc:InStayOut;
        private var _emperorIsoMc:InStayOut;
        private var _selectPersonal:HistoryPlayerDisplay;
        private var _playerDetail:PlayerDetailStatus;
        private var _emperorPng:Bitmap;
        private var _rarityIcon:PlayerRarityIcon;
        private var _fade:Fade;
        private var _aPlayerDisplay:Array;
        private var _closeBtn:ButtonBase;
        private var _cbStatusClose:Function;

        public function HistoryRecord(param1:LayerHome, param2:HistoryInfomation, param3:int, param4:Function)
        {
            if (param2 == null)
            {
                Assert.print("クエスト情報が選択されていません。");
            }
            this._layer = param1;
            this._cbStatusClose = param4;
            this._fade = new Fade(this._layer.getLayer(LayerHome.MAIN));
            this._fade.maxAlpha = 0.5;
            if (param3 == HistoryList.TYPE_NOW_CYCLE)
            {
                this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Chronology.swf", "chronologicalRecordMc");
                this._isoMc = new InStayOut(this._baseMc);
            }
            else if (param3 == HistoryList.TYPE_PAST_CYCLE)
            {
                this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Chronology.swf", "historyRecordMc");
                this._isoMc = new InStayOut(this._baseMc);
                this.setEmperor(param2);
                this.setNavigation(param2);
            }
            else
            {
                DebugLog.print("TYPE_NOW_CYCLEとTYPE_PAST_CYCLE以外のステータスが送られてきています");
                return;
            }
            this._layer.getLayer(LayerHome.MAIN).addChild(this._baseMc);
            this._aPlayerDisplay = [];
            this.setQuestParameter(param2);
            this.createCharacterDisplay(param2);
            this._closeBtn = ButtonManager.getInstance().addButton(this._baseMc.closeBtnMc, this.cbCloseButton);
            this._closeBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._baseMc.closeBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._fade.setFadeOut(Constant.FADE_OUT_TIME);
            this._isoMc.setIn();
            if (this._emperorIsoMc)
            {
                this._emperorIsoMc.setIn();
            }
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._closeBtn)
            {
                ButtonManager.getInstance().removeButton(this._closeBtn);
            }
            this._closeBtn = null;
            for each (_loc_1 in this._aPlayerDisplay)
            {
                
                _loc_1.mc.removeEventListener(MouseEvent.CLICK, this.cbSelectCharacter);
                _loc_1.release();
            }
            this._aPlayerDisplay = null;
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            if (this._emperorIsoMc)
            {
                this._emperorIsoMc.release();
            }
            this._emperorIsoMc = null;
            this._rarityIcon = null;
            if (this._emperorPng && this._emperorPng.parent)
            {
                this._emperorPng.parent.removeChild(this._emperorPng);
            }
            this._emperorPng = null;
            if (this._isoMc)
            {
                this._isoMc.release();
            }
            this._isoMc = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._isoMc.bOpened && this._isoMc.bAnimetion == false)
            {
                this._selectPersonal = null;
                for each (_loc_2 in this._aPlayerDisplay)
                {
                    
                    if (InputManager.getInstance().isHitTest(_loc_2.mc) && this._selectPersonal == null)
                    {
                        this._selectPersonal = _loc_2;
                        _loc_2.setSelect(true);
                        continue;
                    }
                    _loc_2.setSelect(false);
                }
            }
            if (this._playerDetail)
            {
                this._playerDetail.control(param1);
            }
            if (this._fade)
            {
                this._fade.control(param1);
            }
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoMc.bEnd;
        }// end function

        private function setNavigation(param1:HistoryInfomation) : void
        {
            var _loc_5:* = null;
            if (this._baseMc.popupNaviCharaMc == null)
            {
                return;
            }
            var _loc_2:* = Constant.UNDECIDED;
            var _loc_3:* = QuestManager.questRankLabel(param1.achievementRate);
            var _loc_4:* = [{rank:"rankS", msgId:MessageId.HISTORY_NAVI_RANK_S}, {rank:"rankA", msgId:MessageId.HISTORY_NAVI_RANK_A}, {rank:"rankB", msgId:MessageId.HISTORY_NAVI_RANK_B}, {rank:"rankC", msgId:MessageId.HISTORY_NAVI_RANK_C}, {rank:"rankD", msgId:MessageId.HISTORY_NAVI_RANK_D}];
            for each (_loc_5 in _loc_4)
            {
                
                if (_loc_5.rank == _loc_3)
                {
                    _loc_2 = _loc_5.msgId;
                    break;
                }
            }
            if (_loc_2 == Constant.UNDECIDED)
            {
                return;
            }
            TextControl.setIdText(this._baseMc.popupNaviCharaMc.infoBalloonTextMc.textDt, _loc_2);
            var _loc_6:* = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
            this._baseMc.popupNaviCharaMc.naviCharaNull.addChild(_loc_6);
            _loc_6.x = _loc_6.x - _loc_6.width / 2;
            _loc_6.y = _loc_6.y - _loc_6.height;
            return;
        }// end function

        private function setEmperor(param1:HistoryInfomation) : void
        {
            var _loc_2:* = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Chronology.swf", "chronologicalEmperorIn");
            var _loc_3:* = PlayerManager.getInstance().getPlayerInformation(param1.emperorId);
            if (_loc_3)
            {
                this._emperorPng = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_3.bustUpFileName);
                if (this._emperorPng)
                {
                    _loc_2.charaNull.addChild(this._emperorPng);
                    this._emperorPng.smoothing = true;
                    this._emperorPng.x = this._emperorPng.x - this._emperorPng.width / 2;
                    this._emperorPng.y = this._emperorPng.y - this._emperorPng.height;
                }
                TextControl.setText(_loc_2.emperorNameMc.textMc.textDt, _loc_3.name);
                this._rarityIcon = new PlayerRarityIcon(_loc_2.emperorNameMc.setCharaRankMc, _loc_3.rarity);
                _loc_2.emperorNameMc.visible = true;
            }
            else
            {
                _loc_2.emperorNameMc.visible = false;
            }
            this._emperorIsoMc = new InStayOut(_loc_2);
            this._layer.getLayer(LayerHome.MAIN).addChild(_loc_2);
            return;
        }// end function

        private function setQuestParameter(param1:HistoryInfomation) : void
        {
            var _loc_2:* = this._baseMc.recordSetMc;
            TextControl.setIdText(_loc_2.recordTitleTextMc.textDt, MessageId.HISTORY_RECORD_TITLE);
            TextControl.setIdText(_loc_2.recordRankText1Mc.textDt, MessageId.HISTORY_RECORD_TOP_RANK);
            TextControl.setIdText(_loc_2.recordRankText2Mc.textDt, MessageId.HISTORY_RECORD_PARTY);
            TextControl.setIdText(_loc_2.recordDetailText1Mc.textDt, MessageId.HISTORY_RECORD_PLAY_COUNT);
            TextControl.setIdText(_loc_2.recordDetailText2Mc.textDt, MessageId.HISTORY_RECORD_CLREA_COUNT);
            TextControl.setIdText(_loc_2.recordDetailText3Mc.textDt, MessageId.HISTORY_RECORD_KILL_COUNT);
            TextControl.setIdText(_loc_2.recordDetailText4Mc.textDt, MessageId.HISTORY_RECORD_DEAD_COUNT);
            TextControl.setText(_loc_2.questNameTextMc.textDt, param1.questName);
            TextControl.setText(_loc_2.totalNum1.textDt, param1.playCount.toString());
            TextControl.setText(_loc_2.totalNum2.textDt, param1.clearCount.toString());
            TextControl.setText(_loc_2.totalNum3.textDt, param1.killCount.toString());
            TextControl.setText(_loc_2.totalNum4.textDt, param1.deadCount.toString());
            var _loc_3:* = QuestManager.questRankLabel(param1.achievementRate);
            _loc_2.resultRankMc.gotoAndStop(_loc_3);
            return;
        }// end function

        private function createCharacterDisplay(param1:HistoryInfomation) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = [this._baseMc.recordSetMc.charaNull1, this._baseMc.recordSetMc.charaNull2, this._baseMc.recordSetMc.charaNull3, this._baseMc.recordSetMc.charaNull4, this._baseMc.recordSetMc.charaNull5, this._baseMc.recordSetMc.charaNull6];
            this._aPlayerDisplay = [];
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < param1.aParty.length)
            {
                
                _loc_5 = param1.aParty[_loc_4];
                if (_loc_4 == FormationSetData.FORMATION_INDEX_COMMANDER)
                {
                    _loc_3 = FormationSetData.FORMATION_INDEX_COMMANDER;
                }
                _loc_6 = _loc_2[_loc_3];
                if (_loc_5 == null || _loc_6 == null)
                {
                }
                else
                {
                    _loc_7 = new HistoryPlayerDisplay(_loc_5);
                    _loc_7.setParent(_loc_6);
                    _loc_7.setPlayerClick(this.cbSelectCharacter);
                    _loc_7.setAnimStay();
                    this._aPlayerDisplay.push(_loc_7);
                    _loc_3++;
                }
                _loc_4++;
            }
            return;
        }// end function

        private function cbSelectCharacter(event:MouseEvent) : void
        {
            if (this._isoMc.bOpened && this._isoMc.bAnimetion == false)
            {
                this._closeBtn.setDisableFlag(true);
                StatusManager.getInstance().addStatusDetail(PlayerDetailStatus.STATUS_TYPE_HISTORY, this._layer.getLayer(LayerHome.MAIN), this.cbClosePlayerDetail, this._selectPersonal.personal);
                SoundManager.getInstance().playSe(ButtonBase.SE_DECIDE_ID);
            }
            return;
        }// end function

        private function cbClosePlayerDetail(param1:int, param2:Boolean) : void
        {
            if (param2)
            {
                this._cbStatusClose(param1);
            }
            if (StatusManager.getInstance().aDetailLength == 0)
            {
                this._closeBtn.setDisableFlag(false);
            }
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            this._closeBtn.setDisableFlag(true);
            this._fade.setFadeIn(Constant.FADE_IN_TIME);
            this._isoMc.setOut();
            if (this._emperorIsoMc)
            {
                this._emperorIsoMc.setOut();
            }
            return;
        }// end function

    }
}
