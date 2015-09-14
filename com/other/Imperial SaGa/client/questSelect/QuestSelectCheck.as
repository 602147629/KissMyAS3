package questSelect
{
    import area.*;
    import button.*;
    import flash.display.*;
    import formation.*;
    import input.*;
    import item.*;
    import layer.*;
    import message.*;
    import player.*;
    import playerList.*;
    import popup.*;
    import resource.*;
    import status.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class QuestSelectCheck extends Object
    {
        private var _layer:LayerQuestSelect;
        private var _baseMc:MovieClip;
        private var _questInfo:AreaQuest;
        private var _aButton:Array;
        private var _aListPlayerDisplay:Array;
        private var _commanderListPlayer:ListPlayerDisplay;
        private var _aStatusNull:Array;
        private var _aHitTarget:Array;
        private var _isoMain:InStayOut;
        private var _bSelect:Boolean;
        private var _simpleStatus:QuestSelectSimpleStatus;
        private var _useItemSelect:UseItemSelect;
        private var _fade:Fade;
        private var _cbStart:Function;
        private var _cbStop:Function;
        private var _cbFormation:Function;
        private var _cbTrading:Function;
        private var _cbReload:Function;

        public function QuestSelectCheck(param1:LayerQuestSelect, param2:Function, param3:Function, param4:Function, param5:Function, param6:Function)
        {
            this._layer = param1;
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "UI_QuestSelect.swf", "QuestConfirmationPopup");
            this._isoMain = new InStayOut(this._baseMc);
            this._cbStart = param2;
            this._cbStop = param3;
            this._cbFormation = param4;
            this._cbTrading = param5;
            this._cbReload = param6;
            this._bSelect = false;
            TextControl.setIdText(this._baseMc.infoPopupBGMc.infoTitleMc.textDt, MessageId.QUEST_START_CHECK);
            TextControl.setIdText(this._baseMc.confirmationTextMc.textDt, MessageId.QUEST_SELECT_CHECK);
            this._simpleStatus = new QuestSelectSimpleStatus(this._layer.getLayer(LayerQuestSelect.POP));
            this.setPartyCharacter();
            var _loc_7:* = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
            if (ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH) != null)
            {
                this._baseMc.infoPopupNaviCharaMc.naviCharaNull.addChild(_loc_7);
                _loc_7.smoothing = true;
                _loc_7.x = _loc_7.x - _loc_7.width / 2;
                _loc_7.y = _loc_7.y - _loc_7.height;
                ;
            }
            this._useItemSelect = new UseItemSelect(this._baseMc.ItemSelectWindow, this.cbItemSelect);
            this.createButton();
            return;
        }// end function

        public function relase() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._bSelect = false;
            if (this._useItemSelect)
            {
                this._useItemSelect.release();
            }
            this._useItemSelect = null;
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_1);
                _loc_1.release();
            }
            this._aButton = null;
            for each (_loc_2 in this._aListPlayerDisplay)
            {
                
                _loc_2.release();
            }
            this._aListPlayerDisplay = null;
            this._commanderListPlayer = null;
            this._aStatusNull = null;
            for each (_loc_3 in this._aHitTarget)
            {
                
                _loc_3.release();
            }
            this._aHitTarget = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            if (this._baseMc)
            {
                if (this._baseMc.infoPopupNaviCharaMc.naviCharaNull.numChildren > 0)
                {
                    this._baseMc.infoPopupNaviCharaMc.naviCharaNull.removeChildAt(0);
                }
                if (this._baseMc.parent)
                {
                    this._baseMc.parent.removeChild(this._baseMc);
                }
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = null;
            if (this._isoMain.bOpened)
            {
                _loc_3 = 0;
                while (_loc_3 < this._aListPlayerDisplay.length)
                {
                    
                    _loc_4 = this._aListPlayerDisplay[_loc_3];
                    _loc_5 = _loc_4.playerDisplay;
                    _loc_6 = this._aHitTarget[_loc_3];
                    _loc_5.control(param1);
                    if (InputManager.getInstance().isHitTest(_loc_6.target) && this._bSelect)
                    {
                        _loc_2 = _loc_5;
                        _loc_5.setSelect(true);
                        this._simpleStatus.setOpen(_loc_5, this._aStatusNull[_loc_3]);
                    }
                    else
                    {
                        _loc_5.setSelect(false);
                    }
                    _loc_3++;
                }
            }
            if (_loc_2 == null)
            {
                this._simpleStatus.setClose();
            }
            if (this._useItemSelect)
            {
                this._useItemSelect.control(param1);
            }
            if (this._fade)
            {
                this._fade.control(param1);
            }
            return;
        }// end function

        public function open(param1:AreaQuest) : void
        {
            ButtonManager.getInstance().push();
            this._bSelect = true;
            this._layer.getLayer(LayerQuestSelect.POP).addChild(this._baseMc);
            this._questInfo = param1;
            this._baseMc.visible = true;
            this.setQuestInfo();
            if (this._useItemSelect)
            {
                this._useItemSelect.resetSelect();
            }
            this._fade = new Fade(this._layer.getLayer(LayerQuestSelect.MAIN), 0.5);
            this._fade.setFadeOut(Constant.FADE_OUT_TIME);
            this._isoMain.setIn(this.cbIn);
            return;
        }// end function

        public function close() : void
        {
            var _loc_1:* = null;
            this._bSelect = false;
            for each (_loc_1 in this._aButton)
            {
                
                _loc_1.setMouseOut();
                ButtonManager.getInstance().removeArray(_loc_1);
            }
            this._useItemSelect.removeButton();
            this._fade.setFadeIn(Constant.FADE_IN_TIME, this.cbFadeOut);
            ButtonManager.getInstance().pop();
            this._isoMain.setOut(this.cbOut);
            return;
        }// end function

        public function getUseItemId() : Array
        {
            return this._useItemSelect.getSelectItemId();
        }// end function

        public function getUseFreeItemId() : Array
        {
            return this._useItemSelect.getSelectItemId(true);
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain.bClosed && this._isoMain.bAnimetion == false;
        }// end function

        private function setQuestInfo() : void
        {
            var _loc_1:* = [MessageId.QUEST_OPERATION_EASY, MessageId.QUEST_OPERATION_NORMAL, MessageId.QUEST_OPERATION_HARD, MessageId.QUEST_OPERATION_HARDEST];
            var _loc_2:* = String("no：" + this._questInfo.no);
            var _loc_3:* = String(this._questInfo.maxMember + "人");
            TextControl.setText(this._baseMc.infoPopupNaviCharaMc.infoBalloonTextMc.textDt, "");
            if (this._baseMc.questConfirmationInfoMc.questNumMc != null)
            {
                this._baseMc.questConfirmationInfoMc.questNumMc.visible = false;
            }
            TextControl.setText(this._baseMc.questConfirmationInfoMc.questTitleMc.textDt, this._questInfo.questTitle);
            TextControl.setIdText(this._baseMc.questConfirmationInfoMc.questLvTitleMc.textDt, MessageId.QUEST_SELECT_LEVEL);
            this._baseMc.questConfirmationInfoMc.questLvStarMc.gotoAndStop(QuestSelectManager.getLabelNameQuestLv(this._questInfo));
            TextControl.setIdText(this._baseMc.questConfirmationInfoMc.sortieSoldierNumTitleMc.textDt, MessageId.QUEST_SELECT_MAX_MEMBER);
            TextControl.setText(this._baseMc.questConfirmationInfoMc.sortieSoldierNumMc.textDt, _loc_3);
            return;
        }// end function

        private function createButton() : void
        {
            this._aButton = [];
            var _loc_1:* = new ButtonBase(this._baseMc.sortieBtnMc, this.cbQuestStart);
            _loc_1.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aButton.push(_loc_1);
            _loc_1 = new ButtonBase(this._baseMc.cancelBtnMc, this.cbQuestStop);
            _loc_1.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._aButton.push(_loc_1);
            _loc_1 = new ButtonBase(this._baseMc.formationBtnMc, this.cbFormation);
            _loc_1.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aButton.push(_loc_1);
            _loc_1 = new ButtonBase(this._baseMc.ItemSelectWindow.ShopBtnMc, this.cbTrading);
            _loc_1.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aButton.push(_loc_1);
            TextControl.setIdText(this._baseMc.sortieBtnMc.textMc.textDt, MessageId.QUEST_SELECT_START);
            TextControl.setIdText(this._baseMc.cancelBtnMc.textMc.textDt, MessageId.QUEST_SELECT_STOP);
            TextControl.setIdText(this._baseMc.formationBtnMc.textMc.textDt, MessageId.QUEST_SELECT_FORMATION);
            TextControl.setIdText(this._baseMc.ItemSelectWindow.ShopBtnMc.textMc.textDt, MessageId.QUEST_SELECT_SHOP);
            return;
        }// end function

        private function addButton() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().addButtonBase(_loc_1);
            }
            this._useItemSelect.addButton();
            return;
        }// end function

        private function setPartyCharacter() : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_1:* = CommanderSkillUtility.isUnlockCommander();
            if (_loc_1)
            {
                this._baseMc.questConfirmationInfoMc.gotoAndStop("commander");
            }
            else
            {
                this._baseMc.questConfirmationInfoMc.gotoAndStop("normal");
            }
            var _loc_2:* = [this._baseMc.questConfirmationInfoMc.MiniCharaMc1, this._baseMc.questConfirmationInfoMc.MiniCharaMc2, this._baseMc.questConfirmationInfoMc.MiniCharaMc3, this._baseMc.questConfirmationInfoMc.MiniCharaMc4, this._baseMc.questConfirmationInfoMc.MiniCharaMc5];
            var _loc_3:* = [this._baseMc.questConfirmationInfoMc.StatusNull1, this._baseMc.questConfirmationInfoMc.StatusNull2, this._baseMc.questConfirmationInfoMc.StatusNull3, this._baseMc.questConfirmationInfoMc.StatusNull4, this._baseMc.questConfirmationInfoMc.StatusNull5];
            if (_loc_1)
            {
                _loc_2.push(this._baseMc.questConfirmationInfoMc.MiniCharaMc6);
                _loc_3.push(this._baseMc.questConfirmationInfoMc.StatusNull6);
            }
            for each (_loc_5 in _loc_2)
            {
                
                _loc_5.visible = false;
            }
            this._aListPlayerDisplay = [];
            this._commanderListPlayer = null;
            this._aStatusNull = [];
            this._aHitTarget = [];
            _loc_6 = UserDataManager.getInstance().userData.aFormationPlayerUniqueId;
            _loc_7 = 0;
            _loc_4 = 0;
            while (_loc_4 < _loc_6.length)
            {
                
                if (_loc_7 == FormationSetData.FORMATION_INDEX_COMMANDER)
                {
                    _loc_4 = FormationSetData.FORMATION_INDEX_COMMANDER;
                }
                _loc_8 = _loc_2[_loc_4];
                _loc_9 = _loc_6[_loc_7];
                if (_loc_8 == null)
                {
                    break;
                }
                _loc_7++;
                if (_loc_9 != 0)
                {
                    _loc_10 = UserDataManager.getInstance().userData.getPlayerPersonal(_loc_9);
                    if (_loc_10 == null)
                    {
                        continue;
                    }
                    _loc_10.updateSp();
                    _loc_11 = new PlayerMiniStatus(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", _loc_8);
                    _loc_11.setInvisible(PlayerMiniStatus.INVISIBLE_FLAG_NAME);
                    _loc_12 = new ListPlayerDisplay(_loc_11);
                    _loc_12.setPlayerData(new ListPlayerData(_loc_10));
                    _loc_12.playerDisplay.setAnimSelected();
                    this._aListPlayerDisplay.push(_loc_12);
                    this._aStatusNull.push(_loc_3[_loc_4]);
                    if (_loc_4 == FormationSetData.FORMATION_INDEX_COMMANDER)
                    {
                        this._commanderListPlayer = _loc_12;
                        if (_loc_10.isUseFacility())
                        {
                            _loc_12.playerActionController.resetAction();
                        }
                    }
                    _loc_13 = new HitTarget();
                    _loc_13.resetMc(_loc_12.playerDisplay.mc);
                    this._aHitTarget.push(_loc_13);
                    _loc_4++;
                    _loc_8.visible = true;
                }
                if (_loc_7 >= _loc_6.length)
                {
                    break;
                }
            }
            CommanderSkillUtility.setupCommanderSkillField(this._baseMc.questConfirmationInfoMc.commanderSkillTextMc, this._baseMc.questConfirmationInfoMc.warningTextMc, this._commanderListPlayer ? (this._commanderListPlayer.playerDisplay.info) : (null), this._aListPlayerDisplay.length, this._commanderListPlayer ? (this._commanderListPlayer.status) : (null));
            return;
        }// end function

        private function setTutorialArrow() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (TutorialManager.getInstance().isTutorial())
            {
                TutorialManager.getInstance().hideTutorialArrow();
                _loc_1 = this._aButton[0] as ButtonBase;
                _loc_2 = this._useItemSelect.getUseItemButton(PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT);
                if (!CommonPopup.isUse())
                {
                    if (_loc_2.bSelect)
                    {
                        _loc_1.setDisable(false);
                        _loc_2.setDisable(true);
                        TutorialManager.getInstance().setTutorialArrow(_loc_1.getMoveClip(), TutorialManager.TUTORIAL_ARROW_DIRECTION_UP);
                    }
                    else
                    {
                        _loc_1.setDisable(true);
                        _loc_2.setDisable(false);
                        TutorialManager.getInstance().setTutorialArrow(_loc_2.mcBase, TutorialManager.TUTORIAL_ARROW_DIRECTION_RIGHT);
                    }
                }
                else
                {
                    _loc_1.setDisable(true);
                    _loc_2.setDisable(true);
                }
            }
            return;
        }// end function

        private function cbIn() : void
        {
            this.addButton();
            if (TutorialManager.getInstance().isTutorial())
            {
                (this._aButton[1] as ButtonBase).setDisable(true);
                (this._aButton[2] as ButtonBase).setDisable(true);
                (this._aButton[3] as ButtonBase).setDisable(true);
                this._useItemSelect.setDisable(true);
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT, TutorialManager.BASIC_TUTORIAL_FLAG_FEVER_ITEM))
                {
                    TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT, TutorialManager.BASIC_TUTORIAL_FLAG_FEVER_ITEM, this.setTutorialArrow);
                }
                this.setTutorialArrow();
            }
            return;
        }// end function

        private function cbOut() : void
        {
            this._baseMc.visible = false;
            return;
        }// end function

        private function cbQuestStart(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._questInfo == null)
            {
                return;
            }
            if (this._questInfo.eventId > 0 && this._questInfo.endTime < TimeClock.getNowTime())
            {
                this.close();
                _loc_2 = MessageManager.getInstance().getMessage(MessageId.QUEST_DAILYQUEST_ERROR);
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NAVI, _loc_2, this._cbReload);
                return;
            }
            if (!TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_SELECT_END))
            {
                if (this._useItemSelect && this._useItemSelect.checkAnySelect())
                {
                    CommonPopup.getInstance().openPaymentPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.QUEST_SELECT_CHECK_PAYMENT), this.cbCommonPopup, MessageManager.getInstance().getMessage(MessageId.QUEST_SELECT_START), MessageManager.getInstance().getMessage(MessageId.QUEST_SELECT_STOP));
                    return;
                }
            }
            if (this._cbStart != null)
            {
                this._bSelect = false;
                this._cbStart();
            }
            return;
        }// end function

        private function cbQuestStop(param1:int) : void
        {
            if (this._cbStop != null)
            {
                this._bSelect = false;
                this._cbStop();
            }
            return;
        }// end function

        private function cbFormation(param1:int) : void
        {
            if (this._cbFormation != null)
            {
                this._bSelect = false;
                this._cbFormation();
            }
            return;
        }// end function

        private function cbTrading(param1:int) : void
        {
            if (this._cbTrading != null)
            {
                this._bSelect = false;
                this._cbTrading();
            }
            return;
        }// end function

        private function cbCommonPopup(param1:Boolean) : void
        {
            if (param1)
            {
                if (this._cbStart != null)
                {
                    this._bSelect = false;
                    this._cbStart();
                }
            }
            return;
        }// end function

        private function cbItemSelect() : void
        {
            this.setTutorialArrow();
            return;
        }// end function

        private function cbFadeOut() : void
        {
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            return;
        }// end function

    }
}
