package questSelect
{
    import area.*;
    import balloon.*;
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import layer.*;
    import message.*;
    import quest.*;
    import tradingPost.*;
    import tutorial.*;

    public class AreaQuestDetail extends Object
    {
        private var _mc:MovieClip;
        private var _layer:LayerQuestSelect;
        private var _cbBack:Function;
        private var _selectCheck:QuestSelectCheck;
        private var _returnBtn:ButtonBase;
        private var _setDiffBtn:ButtonBase;
        private var _aDifficultyBtn:Array;
        private var _aBalloonMessageId:Array;
        private var _bInfoOpen:Boolean;
        private var _bInfoClose:Boolean;
        private var _quest:AreaQuest;
        private var _bMouseClick:Boolean;
        private var _bDifficultyOpen:Boolean;
        private var _aBalloon:Array;
        private var _bGotoList:Boolean;
        private var _bGotoQuest:Boolean;
        private var _bGotoFormation:Boolean;
        private var _bGotoTrading:Boolean;
        private static const LABEL_INFOMATION_IN:String = "in";
        private static const LABEL_INFOMATION_STAY:String = "stay";
        private static const LABEL_INFOMATION_OUT:String = "out";
        private static const LABEL_DIFFICULTY_IN:String = "out2";
        private static const LABEL_DIFFICULTY_STAY:String = "stay2";
        private static const LABEL_DIFFICULTY_OUT:String = "out3";
        private static const LABEL_GO_TO_QUEST:String = "out4";
        private static const LABEL_END:String = "end";
        private static const LABEL_GO_TO_QUEST_END:String = "end2";

        public function AreaQuestDetail(param1:MovieClip, param2:LayerQuestSelect, param3:Function, param4:Function)
        {
            var _loc_5:* = null;
            this._mc = param1;
            this._mc.visible = false;
            this._layer = param2;
            this._cbBack = param3;
            this._aBalloon = [];
            this._selectCheck = new QuestSelectCheck(this._layer, this.cbGotoQuest, this.cbGotoDifficultySelect, this.cbGotoFormation, this.cbGotoTrading, param4);
            this._aDifficultyBtn = new Array();
            this._bInfoOpen = false;
            this._bInfoClose = false;
            this._bDifficultyOpen = false;
            this._aBalloonMessageId = [MessageManager.getInstance().getMessage(MessageId.QUEST_DIFFICULTY_EASY), MessageManager.getInstance().getMessage(MessageId.QUEST_DIFFICULTY_NORMAL), MessageManager.getInstance().getMessage(MessageId.QUEST_DIFFICULTY_HARD), MessageManager.getInstance().getMessage(MessageId.QUEST_DIFFICULTY_HARDEST)];
            this._returnBtn = new ButtonBase(this._mc.returnBtnMc, this.cbReturnBtn);
            this._returnBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._setDiffBtn = new ButtonBase(this._mc.sortieBtnMc, this.cbDifficultySelect);
            this._setDiffBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mc.sortieBtnMc.textMc.textDt, MessageId.QUEST_SELECT_OPERATION_LEVEL_SELECT);
            TextControl.setIdText(this._mc.questDetailMc.questExplanationTitleMc.textDt, MessageId.QUEST_DETAIL_NAME);
            if (BuildSwitch.SW_QUEST_DIFFICULTY)
            {
                this.setDifficultyDetail();
            }
            else
            {
                this.hideDifficultyDetailMc();
            }
            this.setDisableFlag(true);
            this.setDisableFlagDifficulty(true);
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_SELECT_END))
            {
                for each (_loc_5 in this._aDifficultyBtn)
                {
                    
                    if (_loc_5.id != CommonConstant.QUEST_OPERATION_EASY)
                    {
                        _loc_5.seal(true);
                    }
                }
                this._returnBtn.seal(true);
            }
            return;
        }// end function

        public function get quest() : AreaQuest
        {
            return this._quest;
        }// end function

        public function get bMouseClick() : Boolean
        {
            return this._bMouseClick;
        }// end function

        public function get bDifficultyOpen() : Boolean
        {
            return this._bDifficultyOpen;
        }// end function

        public function get bGotoList() : Boolean
        {
            return this._bGotoList;
        }// end function

        public function get bGotoQuest() : Boolean
        {
            return this._bGotoQuest;
        }// end function

        public function get bGotoFormation() : Boolean
        {
            return this._bGotoFormation;
        }// end function

        public function get bGotoTrading() : Boolean
        {
            return this._bGotoTrading;
        }// end function

        public function get bOpen() : Boolean
        {
            return this._bInfoOpen;
        }// end function

        public function get bClose() : Boolean
        {
            return this._bInfoClose;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            this.releaseQuestSelectBtn();
            if (this._setDiffBtn)
            {
                this._setDiffBtn.release();
            }
            this._setDiffBtn = null;
            if (this._returnBtn)
            {
                this._returnBtn.release();
            }
            this._returnBtn = null;
            this.releaseDifficultyBtn();
            this._aDifficultyBtn = [];
            if (this._selectCheck)
            {
                this._selectCheck.relase();
            }
            this._selectCheck = null;
            for each (_loc_1 in this._aBalloon)
            {
                
                BalloonManager.getInstance().removeBalloon(_loc_1);
            }
            this._aBalloon = [];
            if (this._mc != null)
            {
                this._mc.removeEventListener(Event.ENTER_FRAME, this.enterFrameOpen);
                this._mc.removeEventListener(Event.ENTER_FRAME, this.enterFrameClose);
                this._mc.removeEventListener(Event.ENTER_FRAME, this.enterFrameDifficultyOpen);
                this._mc.removeEventListener(Event.ENTER_FRAME, this.enterFrameDifficultyClose);
                if (this._mc.parent != null)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            this._layer = null;
            this._cbBack = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._selectCheck)
            {
                this._selectCheck.control(param1);
            }
            return;
        }// end function

        public function reset() : void
        {
            this._bInfoOpen = false;
            this._bInfoClose = false;
            this._bGotoList = false;
            this._bGotoQuest = false;
            return;
        }// end function

        public function getUseItemId() : Array
        {
            return this._selectCheck.getUseItemId();
        }// end function

        public function getUseFreeItemId() : Array
        {
            return this._selectCheck.getUseFreeItemId();
        }// end function

        private function addQuestSelectBtn() : void
        {
            ButtonManager.getInstance().addButtonBase(this._returnBtn);
            if (this._quest && this._quest.bSelect)
            {
                ButtonManager.getInstance().addButtonBase(this._setDiffBtn);
            }
            return;
        }// end function

        private function releaseQuestSelectBtn() : void
        {
            this._returnBtn.setMouseOut();
            this._setDiffBtn.setMouseOut();
            ButtonManager.getInstance().removeArray(this._returnBtn);
            ButtonManager.getInstance().removeArray(this._setDiffBtn);
            this._returnBtn.reset();
            this._setDiffBtn.reset();
            return;
        }// end function

        private function addDifficultyBtn() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aDifficultyBtn)
            {
                
                ButtonManager.getInstance().addButtonBase(_loc_1);
            }
            return;
        }// end function

        private function releaseDifficultyBtn() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aDifficultyBtn)
            {
                
                _loc_1.setMouseOut();
                ButtonManager.getInstance().removeArray(_loc_1);
            }
            return;
        }// end function

        public function setIn(param1:AreaQuest) : void
        {
            this._mc.visible = true;
            this._quest = param1;
            this._bMouseClick = false;
            this._bInfoOpen = false;
            this._bInfoClose = false;
            this._returnBtn.setDisable(false);
            this._setDiffBtn.setDisable(false);
            if (this._quest.bSelect == false)
            {
                this._setDiffBtn.setDisable(true);
            }
            this.setQuestDetail();
            this._mc.addEventListener(Event.ENTER_FRAME, this.enterFrameOpen);
            this._mc.gotoAndPlay(LABEL_INFOMATION_IN);
            this.setRoll();
            return;
        }// end function

        public function setOut() : void
        {
            this._bGotoList = false;
            this._bInfoOpen = false;
            this._bMouseClick = false;
            this.setDisableFlag(true);
            this.setDisableFlagDifficulty(true);
            this.releaseQuestSelectBtn();
            this.releaseDifficultyBtn();
            this._mc.addEventListener(Event.ENTER_FRAME, this.enterFrameClose);
            if (this._mc.currentLabel == LABEL_DIFFICULTY_STAY)
            {
                this._mc.gotoAndPlay(LABEL_GO_TO_QUEST);
            }
            else
            {
                this._mc.gotoAndPlay(LABEL_INFOMATION_OUT);
            }
            return;
        }// end function

        public function gotoQuest() : void
        {
            this._bGotoList = false;
            this._bInfoOpen = false;
            this._bMouseClick = false;
            this.setDisableFlag(true);
            this.setDisableFlagDifficulty(true);
            this.releaseQuestSelectBtn();
            this.releaseDifficultyBtn();
            this._mc.addEventListener(Event.ENTER_FRAME, this.enterFrameClose);
            if (BuildSwitch.SW_QUEST_DIFFICULTY)
            {
                this._mc.gotoAndPlay(LABEL_GO_TO_QUEST);
            }
            else
            {
                this._mc.gotoAndPlay(LABEL_GO_TO_QUEST_END);
            }
            return;
        }// end function

        public function setDisableFlag(param1:Boolean) : void
        {
            this._returnBtn.setDisableFlag(param1);
            this._setDiffBtn.setDisableFlag(param1);
            return;
        }// end function

        private function setDisableFlagDifficulty(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in this._aDifficultyBtn)
            {
                
                _loc_2.setDisableFlag(param1);
            }
            for each (_loc_3 in this._aBalloon)
            {
                
                _loc_3.bEnable = !param1;
                if (param1)
                {
                    _loc_3.setClose();
                }
            }
            return;
        }// end function

        public function cbReturnBtn(param1:int) : void
        {
            if (this._cbBack != null)
            {
                this._cbBack();
            }
            return;
        }// end function

        public function cbReturnQuestList(param1:int) : void
        {
            this.setDisableFlagDifficulty(true);
            this.releaseDifficultyBtn();
            this.releaseQuestSelectBtn();
            this._bGotoList = true;
            return;
        }// end function

        public function cbGotoQuest() : void
        {
            this._selectCheck.close();
            this.setDisableFlag(true);
            this.setDisableFlagDifficulty(true);
            this._bGotoList = false;
            this._bGotoQuest = true;
            this._bGotoFormation = false;
            this._bGotoTrading = false;
            return;
        }// end function

        public function cbGotoDifficultySelect() : void
        {
            if (BuildSwitch.SW_QUEST_DIFFICULTY)
            {
                this._bDifficultyOpen = true;
                this._bMouseClick = true;
                this.setDisableFlag(true);
                this.setDisableFlagDifficulty(false);
            }
            else
            {
                this._bDifficultyOpen = false;
                this._bMouseClick = true;
                this._bGotoList = true;
                this.setDisableFlag(false);
                this.setDisableFlagDifficulty(true);
                this._returnBtn.setMouseOut();
                this._setDiffBtn.setMouseOut();
                this.addQuestSelectBtn();
                this.releaseDifficultyBtn();
            }
            this._selectCheck.close();
            return;
        }// end function

        public function cbGotoFormation() : void
        {
            this._selectCheck.close();
            this.setDisableFlag(true);
            this.setDisableFlagDifficulty(true);
            this._bGotoList = false;
            this._bGotoQuest = false;
            this._bGotoFormation = true;
            this._bGotoTrading = false;
            return;
        }// end function

        public function cbGotoTrading() : void
        {
            this._selectCheck.close();
            this.setDisableFlag(true);
            this.setDisableFlagDifficulty(true);
            this._bGotoList = false;
            this._bGotoQuest = false;
            this._bGotoFormation = false;
            this._bGotoTrading = true;
            TradingPostStartPageRequest.getInstance().setRequestQuestItem();
            return;
        }// end function

        public function cbDifficultySelect(param1:int) : void
        {
            if (!BuildSwitch.SW_QUEST_DIFFICULTY)
            {
                this.cbDifficultyBtn(CommonConstant.QUEST_OPERATION_EASY);
                return;
            }
            this._bDifficultyOpen = true;
            this.releaseQuestSelectBtn();
            this._mc.addEventListener(Event.ENTER_FRAME, this.enterFrameDifficultyOpen);
            this._mc.gotoAndPlay(LABEL_DIFFICULTY_IN);
            if (TutorialManager.getInstance().isTutorial())
            {
                TutorialManager.getInstance().hideTutorialArrow();
            }
            return;
        }// end function

        public function cbDifficultyBtn(param1:int) : void
        {
            QuestManager.getInstance().setDifficulty(param1);
            this.setDisableFlagDifficulty(true);
            this._bMouseClick = false;
            if (Main.GetApplicationData().maintenanceData.isMaintenanceTime(true) && Main.GetApplicationData().maintenanceData.getMaintenanceType(true) > 0)
            {
                Main.GetProcess().createMaintenanceWindow(true);
                Main.GetProcess().maintenance.cbCloseFunction(this.cbCloseFunction);
            }
            else
            {
                this.cbCloseFunction();
            }
            return;
        }// end function

        private function cbCloseFunction() : void
        {
            this._bDifficultyOpen = false;
            this._selectCheck.open(this._quest);
            if (TutorialManager.getInstance().isTutorial())
            {
                TutorialManager.getInstance().hideTutorialArrow();
                TutorialManager.getInstance().hideTutorialBalloon();
            }
            return;
        }// end function

        public function cbDifficultyBtnOver(param1:int) : void
        {
            if (this._bMouseClick == false)
            {
                return;
            }
            return;
        }// end function

        public function cbDifficultyButtonOut(param1:int) : void
        {
            return;
        }// end function

        public function cbDifficultyClose(param1:int) : void
        {
            this._mc.addEventListener(Event.ENTER_FRAME, this.enterFrameDifficultyClose);
            this._mc.gotoAndPlay(LABEL_DIFFICULTY_OUT);
            this.setDisableFlagDifficulty(true);
            this.releaseDifficultyBtn();
            return;
        }// end function

        private function enterFrameOpen(event:Event) : void
        {
            if (this._mc.currentLabel == LABEL_INFOMATION_STAY)
            {
                this._bInfoOpen = true;
                this._bInfoClose = false;
                this._bMouseClick = true;
                this._mc.removeEventListener(Event.ENTER_FRAME, this.enterFrameOpen);
                this.addQuestSelectBtn();
                this.setDisableFlag(false);
                if (TutorialManager.getInstance().isTutorial())
                {
                    TutorialManager.getInstance().setTutorialArrow(this._setDiffBtn.getMoveClip());
                    TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_QUEST_SELECT_002), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                }
            }
            return;
        }// end function

        private function enterFrameClose(event:Event) : void
        {
            if (this._mc.currentLabel == LABEL_INFOMATION_STAY)
            {
                this._mc.gotoAndPlay(LABEL_INFOMATION_OUT);
            }
            if (this._mc.currentLabel == LABEL_END || this._mc.currentLabel == LABEL_GO_TO_QUEST_END)
            {
                this._mc.visible = false;
                this._bInfoClose = true;
                this._mc.removeEventListener(Event.ENTER_FRAME, this.enterFrameClose);
            }
            return;
        }// end function

        public function enterFrameDifficultyOpen(event:Event) : void
        {
            if (this._mc.currentLabel == LABEL_DIFFICULTY_STAY)
            {
                this._mc.removeEventListener(Event.ENTER_FRAME, this.enterFrameDifficultyOpen);
                this.addDifficultyBtn();
                this.setDisableFlag(true);
                this.setDisableFlagDifficulty(false);
                if (TutorialManager.getInstance().isTutorial())
                {
                    TutorialManager.getInstance().setTutorialArrow((this._aDifficultyBtn[0] as ButtonBase).getMoveClip(), TutorialManager.TUTORIAL_ARROW_DIRECTION_RIGHT);
                    TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_QUEST_SELECT_003), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                }
            }
            return;
        }// end function

        public function enterFrameDifficultyClose(event:Event) : void
        {
            if (this._mc.currentLabel == LABEL_INFOMATION_STAY)
            {
                this.setDisableFlag(false);
                this.setDisableFlagDifficulty(true);
                this._bDifficultyOpen = false;
                this.addQuestSelectBtn();
                this.releaseDifficultyBtn();
                this._mc.removeEventListener(Event.ENTER_FRAME, this.enterFrameDifficultyClose);
                if (TutorialManager.getInstance().isTutorial())
                {
                    TutorialManager.getInstance().hideTutorialArrow();
                }
            }
            return;
        }// end function

        private function setRoll() : void
        {
            var _loc_1:* = this.getLabel();
            this._mc.questDetailMc.gotoAndStop(_loc_1);
            this._mc.roll.gotoAndStop(_loc_1);
            this._mc.rollb.gotoAndStop(_loc_1);
            return;
        }// end function

        private function getLabel() : String
        {
            var _loc_1:* = QuestConstant.AREA_QUEST_TYPE_NORMAL;
            switch(this._quest.questType)
            {
                case CommonConstant.QUEST_TYPE_DAILY:
                {
                    _loc_1 = QuestConstant.AREA_QUEST_TYPE_WEEKLY;
                    break;
                }
                case CommonConstant.QUEST_TYPE_GUERRILLA:
                {
                    _loc_1 = QuestConstant.AREA_QUEST_TYPE_GUERRILLA;
                    break;
                }
                case CommonConstant.QUEST_TYPE_CHALLENGE:
                {
                    _loc_1 = QuestConstant.AREA_QUEST_TYPE_DAILY;
                    break;
                }
                case CommonConstant.QUEST_TYPE_CAMPAIGN:
                {
                    _loc_1 = QuestConstant.AREA_QUEST_TYPE_CAMPAIGN;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function setQuestDetail() : void
        {
            var _loc_1:* = this._mc;
            var _loc_2:* = this.getLabel();
            _loc_1.soldierLvSelectMc.gotoAndStop(_loc_2);
            _loc_1.questTitleMc.gotoAndStop(_loc_2);
            TextControl.setText(_loc_1.questTitleMc.questTitleMc.textDt, this._quest.questTitle);
            _loc_1.questTitleMc.questLvStarMc.gotoAndStop(QuestSelectManager.getLabelNameQuestLv(this._quest));
            if (_loc_1.questTitleMc.questNumMc != null)
            {
                _loc_1.questTitleMc.questNumMc.visible = false;
            }
            TextControl.setText(_loc_1.questDetailMc.questExplanationTextMc.textDt, this._quest.explanation);
            TextControl.setIdText(_loc_1.questDetailMc.clearNumTitleMc.textDt, MessageId.QUEST_DETAIL_CLEAR_COUNT);
            TextControl.setText(_loc_1.questDetailMc.clearNumMc.textDt, this._quest.totalClearCount.toString());
            TextControl.setIdText(_loc_1.questDetailMc.achievementTitleMc.textDt, MessageId.QUEST_DETAIL_ACHIEVEMENT_RATE);
            TextControl.setText(_loc_1.questDetailMc.achievementNumMc.textDt, this._quest.achievementRate.toString());
            TextControl.setIdText(_loc_1.questDetailMc.achievementNumUnitMc.textDt, MessageId.COMMON_RATE);
            var _loc_3:* = "";
            if (this._quest.endTime > 0)
            {
                _loc_3 = MessageManager.getInstance().getMessage(MessageId.AREA_QUEST_END_TIME);
                _loc_3 = _loc_3.replace("%d", this._quest.endTimeMsg);
            }
            TextControl.setText(_loc_1.questTitleMc.questTimeMc.textDt, _loc_3);
            var _loc_4:* = QuestManager.questClearRankLabel(this._quest.achievementRate, this._quest.bCurrentCycleClear);
            _loc_1.questTitleMc.clearIconMc.gotoAndStop(_loc_4);
            _loc_1.questTitleMc.clearIconMc.visible = this._quest.achievementRate != 0;
            TextControl.setIdText(_loc_1.questDetailMc.conditionTitleMc.textDt, MessageId.QUEST_DETAIL_DISPATCH_COUNT);
            if (this._quest.dispatchCondition == "" || this._quest.dispatchCondition == null)
            {
                TextControl.setIdText(_loc_1.questDetailMc.conditionTextMc.textDt, MessageId.COMMON_EMPTY);
            }
            else
            {
                TextControl.setText(_loc_1.questDetailMc.conditionTextMc.textDt, this._quest.dispatchCondition);
            }
            TextControl.setIdText(_loc_1.questDetailMc.sortieSoldierNumTitleMc.textDt, MessageId.QUEST_DETAIL_MAX_MEMBER);
            TextControl.setText(_loc_1.questDetailMc.sortieSoldierNumMc.textDt, this._quest.maxMember.toString());
            TextControl.setIdText(_loc_1.questDetailMc.sortieSoldierNumUnitMc.textDt, MessageId.COMMON_MEMBER_COUNT);
            return;
        }// end function

        private function setDifficultyDetail() : void
        {
            var _loc_1:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            _loc_1 = new ButtonBase(this._mc.soldierLvSelectMc.soldierLvMc1, this.cbDifficultyBtn, this.cbDifficultyBtnOver, this.cbDifficultyButtonOut);
            _loc_1.setId(CommonConstant.QUEST_OPERATION_EASY);
            _loc_1.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aDifficultyBtn.push(_loc_1);
            _loc_1 = new ButtonBase(this._mc.soldierLvSelectMc.soldierLvMc2, this.cbDifficultyBtn, this.cbDifficultyBtnOver, this.cbDifficultyButtonOut);
            _loc_1.setId(CommonConstant.QUEST_OPERATION_NORMAL);
            _loc_1.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aDifficultyBtn.push(_loc_1);
            _loc_1 = new ButtonBase(this._mc.soldierLvSelectMc.soldierLvMc3, this.cbDifficultyBtn, this.cbDifficultyBtnOver, this.cbDifficultyButtonOut);
            _loc_1.setId(CommonConstant.QUEST_OPERATION_HARD);
            _loc_1.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aDifficultyBtn.push(_loc_1);
            _loc_1 = new ButtonBase(this._mc.soldierLvSelectMc.soldierLvMc4, this.cbDifficultyBtn, this.cbDifficultyBtnOver, this.cbDifficultyButtonOut);
            _loc_1.setId(CommonConstant.QUEST_OPERATION_HARDEST);
            _loc_1.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aDifficultyBtn.push(_loc_1);
            _loc_1 = new ButtonBase(this._mc.returnDetaiBtnMc, this.cbDifficultyClose);
            _loc_1.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._aDifficultyBtn.push(_loc_1);
            TextControl.setIdText(this._mc.soldierLvSelectMc.soldierLvSelectTitleMc.textMc, MessageId.QUEST_SELECT_SORTIE);
            TextControl.setIdText(this._mc.soldierLvSelectMc.soldierLvMc1.soldierLvTextMc.textDt, MessageId.QUEST_OPERATION_SELECT_EASY);
            TextControl.setIdText(this._mc.soldierLvSelectMc.soldierLvMc2.soldierLvTextMc.textDt, MessageId.QUEST_OPERATION_SELECT_NORMAL);
            TextControl.setIdText(this._mc.soldierLvSelectMc.soldierLvMc3.soldierLvTextMc.textDt, MessageId.QUEST_OPERATION_SELECT_HARD);
            TextControl.setIdText(this._mc.soldierLvSelectMc.soldierLvMc4.soldierLvTextMc.textDt, MessageId.QUEST_OPERATION_SELECT_HARDEST);
            TextControl.setIdText(this._mc.returnDetaiBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            var _loc_2:* = [this._mc.soldierLvSelectMc.soldierLvMc1, this._mc.soldierLvSelectMc.soldierLvMc2, this._mc.soldierLvSelectMc.soldierLvMc3, this._mc.soldierLvSelectMc.soldierLvMc4];
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = this._aBalloonMessageId[_loc_3];
                _loc_5 = _loc_2[_loc_3];
                _loc_6 = new BalloonNormal(this._layer.getLayer(LayerQuestSelect.POP), _loc_5, _loc_5.balloonNullMc, _loc_4);
                BalloonManager.getInstance().addBalloon(_loc_6);
                this._aBalloon.push(_loc_6);
                _loc_3++;
            }
            return;
        }// end function

        private function hideDifficultyDetailMc() : void
        {
            this._mc.soldierLvSelectMc.visible = false;
            this._mc.returnDetaiBtnMc.visible = false;
            return;
        }// end function

    }
}
