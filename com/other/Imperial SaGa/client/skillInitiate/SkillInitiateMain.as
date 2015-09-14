package skillInitiate
{
    import button.*;
    import facility.*;
    import flash.display.*;
    import flash.filters.*;
    import item.*;
    import message.*;
    import network.*;
    import player.*;
    import playerList.*;
    import popup.*;
    import resource.*;
    import skill.*;
    import sound.*;
    import tradingPost.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class SkillInitiateMain extends Object
    {
        private const _PHASE_OPEN:int = 2;
        private const _PHASE_CHARACTER_SELECT:int = 10;
        private const _PHASE_CHARACTER_SELECT_END:int = 11;
        private const _PHASE_CHARACTER_IGNORE:int = 12;
        private const _PHASE_SKILL_SELECT:int = 20;
        private const _PHASE_TEACHER_SELECT:int = 25;
        private const _PHASE_PROBABILITY_SELECT:int = 30;
        private const _PHASE_INITIATE_CONFIRM:int = 40;
        private const _PHASE_INITIATE_CONNECTION:int = 41;
        private const _PHASE_INITIATE_START:int = 42;
        private const _PHASE_INITIATE_RESULT:int = 43;
        private const _PHASE_CROWN_BUY:int = 50;
        private const _PHASE_WAIT:int = 100;
        private const _PHASE_MAINTENANCE:int = 90;
        private const _PHASE_CLOSE:int = 99;
        private const _FRAME_LABEL_STOP:String = "stop";
        private const _FRAME_LABEL_IN:String = "in";
        private const _FRAME_LABEL_STAY:String = "stay";
        private const _FRAME_LABEL_OUT1:String = "out1";
        private const _FRAME_LABEL_STAY2:String = "stay2";
        private const _FRAME_LABEL_BACK:String = "back";
        private const _FRAME_LABEL_STAY3:String = "stay3";
        private const _FRAME_LABEL_OUT2:String = "out2";
        private const _FRAME_LABEL_END:String = "end";
        private const _BUTTON_ID_RETURN:int = 0;
        private const _BUTTON_ID_SKILL:int = 1;
        private const _BUTTON_ID_PROBABILITY:int = 2;
        private const _BUTTON_ID_DECIDE:int = 3;
        private const _BUTTON_ID_RESET:int = 4;
        private var _baseMc:MovieClip;
        private var _characterListFilter:int;
        private var _characterListMc:SICharacterList;
        private var _initiateConfMc:SkillInitiateConfig;
        private var _skillInitiateMc:SkillInitiateView;
        private var _skillSelectPopup:SISelectSkillPopup;
        private var _probabilityPopup:SISelectProbabiliryPopup;
        private var _resultMc:SIResultView;
        private var _isoBase:InStayOut;
        private var _isoCharaList:InStayOut;
        private var _isoConf:InStayOut;
        private var _itemIcon:Bitmap;
        private var _resourceBox:SIResourceBox;
        private var _aButton:Array;
        private var _phase:int;
        private var _siManager:SkillInitiateManager;
        private var _confirmPopup:SIConfirmPopup;
        private var _bSuccess:Boolean;
        private var _addParameter:int;
        private var _bNotAutoEquip:Boolean;
        private var _bEnd:Boolean;
        private var _upgradeDisabled:FacilityUpgradeDisabled;
        private var _bAnimetion:Boolean;
        private var _bButtonEnable:Boolean;
        private var _bGoTradingPost:Boolean;
        private var _tPI:PlayerInformation;

        public function SkillInitiateMain(param1:MovieClip, param2:SkillInitiateManager)
        {
            Main.GetProcess().topBar.cbConfigWindow(this.cbConfigWindowOpen, this.cbConfigWindowClose);
            this._baseMc = param1;
            this._siManager = param2;
            this._skillInitiateMc = new SkillInitiateView(this._baseMc.skillInitiateMc, this._siManager);
            this._characterListFilter = SkillInitiateUtility.CHARA_LIST_FILTER_LEARNABLE;
            this._characterListMc = new SICharacterList(this._baseMc.charaList1Mc.reserveListMc, this._siManager);
            this._characterListMc.checkEmptyInformation(MessageManager.getInstance().getMessage(MessageId.SKILL_INITIATE_PLAYER_LIST_INFORMATION_01));
            this._characterListMc.setRemainPlayerNumCallback(this.cbRemainPlayerNumFunc);
            this._isoBase = new InStayOut(this._baseMc);
            this._isoCharaList = new InStayOut(this._baseMc.charaList1Mc);
            this._initiateConfMc = new SkillInitiateConfig(this._baseMc.initiateConfTopMc, this._siManager);
            this._isoConf = new InStayOut(this._baseMc.initiateConfTopMc);
            TextControl.setIdText(this._baseMc.initiateConfTopMc.initiateConfMc.setSkillMc.selectSkillMc.probabilityMc.textMc.textDt, MessageId.SKILL_INITIATE_INITIATE_MODULUS);
            TextControl.setIdText(this._baseMc.initiateConfTopMc.initiateConfMc.setProbabilityMc.selectProbabilityMc.probabilityUpText1Mc.textDt, MessageId.SKILL_INITIATE_SUCCESSRATE);
            TextControl.setIdText(this._baseMc.initiateConfTopMc.initiateConfMc.setProbabilityMc.selectProbabilityMc.probabilityUpText2Mc.textDt, MessageId.SKILL_INITIATE_UP);
            this._itemIcon = ResourceManager.getInstance().createBitmap(ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_REVISION_PROBABILITY));
            this._itemIcon.smoothing = true;
            this._baseMc.initiateConfTopMc.initiateConfMc.setProbabilityMc.selectProbabilityMc.itemNull.addChild(this._itemIcon);
            this._resourceBox = new SIResourceBox(this._baseMc.ItemIconBox);
            this.createButton();
            this._bEnd = true;
            this._bAnimetion = true;
            this._bButtonEnable = true;
            this._bGoTradingPost = false;
            this._upgradeDisabled = new FacilityUpgradeDisabled(this._baseMc);
            this.setButtonEnable(false);
            this.setGuideText("");
            TutorialManager.getInstance().stepReset();
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function get bAnimetion() : Boolean
        {
            return this._bAnimetion;
        }// end function

        public function get bButtonEnable() : Boolean
        {
            return this._bButtonEnable;
        }// end function

        public function get bGoTradingPost() : Boolean
        {
            return this._bGoTradingPost;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._aButton)
            {
                for each (_loc_1 in this._aButton)
                {
                    
                    ButtonManager.getInstance().removeButton(_loc_1);
                }
            }
            this._aButton = null;
            if (this._resourceBox)
            {
                this._resourceBox.release();
            }
            this._resourceBox = null;
            if (this._itemIcon && this._itemIcon.parent)
            {
                this._itemIcon.parent.removeChild(this._itemIcon);
            }
            this._itemIcon = null;
            if (this._characterListMc)
            {
                this._characterListMc.release();
            }
            if (this._probabilityPopup)
            {
                this._probabilityPopup.release();
            }
            if (this._skillSelectPopup)
            {
                this._skillSelectPopup.release();
            }
            if (this._skillInitiateMc)
            {
                this._skillInitiateMc.release();
            }
            if (this._initiateConfMc)
            {
                this._initiateConfMc.release();
            }
            if (this._isoCharaList)
            {
                this._isoCharaList.release();
            }
            if (this._isoConf)
            {
                this._isoConf.release();
            }
            if (this._resultMc)
            {
                this._resultMc.release();
            }
            this._baseMc = null;
            this._upgradeDisabled.release();
            return;
        }// end function

        private function createButton() : void
        {
            var _loc_3:* = null;
            this._aButton = [];
            var _loc_1:* = [{mc:this._baseMc.returnBtnMc, textId:MessageId.COMMON_BUTTON_RETURN, callback:this.cbReturnBtn, soundId:ButtonBase.SE_CANCEL_ID}, {mc:this._baseMc.initiateConfTopMc.initiateConfMc.selectBtn1Mc, textId:MessageId.SKILL_INITIATE_BUTTON_SKILL_SELECT, callback:this.cbOpenSkill, soundId:ButtonBase.SE_CURSOR_ID}, {mc:this._baseMc.initiateConfTopMc.initiateConfMc.selectBtn2Mc, textId:MessageId.SKILL_INITIATE_BUTTON_PROBABILITY_SELECT, callback:this.cbOpenProbability, soundId:ButtonBase.SE_CURSOR_ID}, {mc:this._baseMc.initiateConfTopMc.decisionBtnMc, textId:MessageId.SKILL_INITIATE_BUTTON_START_INITIATE, callback:this.cbStartInitiate, soundId:ButtonBase.SE_DECIDE_ID}, {mc:this._baseMc.initiateConfTopMc.resetBtnMc, textId:MessageId.SKILL_INITIATE_BUTTON_RESET, callback:this.cbClearSetting, soundId:ButtonBase.SE_CANCEL_ID}];
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = ButtonManager.getInstance().addButton(_loc_1[_loc_2].mc, _loc_1[_loc_2].callback);
                _loc_3.enterSeId = _loc_1[_loc_2].soundId;
                TextControl.setIdText(_loc_1[_loc_2].mc.textMc.textDt, _loc_1[_loc_2].textId);
                this._aButton.push(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = 0;
            if (this._skillInitiateMc.releaseId != Constant.EMPTY_ID)
            {
                if (this._skillInitiateMc.releaseId == this._siManager.studentId)
                {
                    this.setStudent(Constant.EMPTY_ID);
                    this.setPhase(this._PHASE_CHARACTER_SELECT);
                }
                if (this._skillInitiateMc.releaseId == this._siManager.teacherId)
                {
                    _loc_2 = this._siManager.studentId;
                    this.resetCharacter();
                    this.setStudent(_loc_2);
                    this.setPhase(this._PHASE_SKILL_SELECT);
                }
                if (this._siManager.aSupportId.indexOf(this._skillInitiateMc.releaseId) != -1)
                {
                    this.changeSupport(this._skillInitiateMc.releaseId, true);
                    this.setPhase(this._PHASE_WAIT);
                }
                this._skillInitiateMc.resetReleaseId();
            }
            if (this._upgradeDisabled)
            {
                this._upgradeDisabled.countControl(param1);
            }
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_CHARACTER_SELECT:
                {
                    this.controlCharacterSelect();
                    break;
                }
                case this._PHASE_CHARACTER_SELECT_END:
                {
                    this.controlCharacterSelectEnd();
                    break;
                }
                case this._PHASE_CHARACTER_IGNORE:
                {
                    this.controlCharacterIgnore();
                    break;
                }
                case this._PHASE_SKILL_SELECT:
                {
                    this.controlSkillSelect();
                    break;
                }
                case this._PHASE_TEACHER_SELECT:
                {
                    this.controlTeacherSelect();
                    break;
                }
                case this._PHASE_PROBABILITY_SELECT:
                {
                    this.controlProbabilitySelect();
                    break;
                }
                case this._PHASE_INITIATE_CONFIRM:
                {
                    this.controlInitiateConfirm(param1);
                    break;
                }
                case this._PHASE_INITIATE_CONNECTION:
                {
                    this.controlInitiateConnect(param1);
                    break;
                }
                case this._PHASE_INITIATE_START:
                {
                    this.controlInitiateStart(param1);
                    break;
                }
                case this._PHASE_INITIATE_RESULT:
                {
                    this.controlInitiateResult(param1);
                    break;
                }
                case this._PHASE_CROWN_BUY:
                {
                    this.controlCrownBuy(param1);
                    break;
                }
                case this._PHASE_MAINTENANCE:
                {
                    this.controlPhaseMaintenance();
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(param1)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_CHARACTER_SELECT:
                    {
                        this.phaseCharacterSelect();
                        break;
                    }
                    case this._PHASE_CHARACTER_SELECT_END:
                    {
                        this.phaseCharacterSelectEnd();
                        break;
                    }
                    case this._PHASE_CHARACTER_IGNORE:
                    {
                        this.phaseCharacterIgnore();
                        break;
                    }
                    case this._PHASE_SKILL_SELECT:
                    {
                        this.phaseSkillSelect();
                        break;
                    }
                    case this._PHASE_TEACHER_SELECT:
                    {
                        this.phaseTeacherSelect();
                        break;
                    }
                    case this._PHASE_PROBABILITY_SELECT:
                    {
                        this.phaseProbabilitySelect();
                        break;
                    }
                    case this._PHASE_INITIATE_CONFIRM:
                    {
                        this.phaseInitiateConfirm();
                        break;
                    }
                    case this._PHASE_INITIATE_CONNECTION:
                    {
                        this.phaseInitiateConnect();
                        break;
                    }
                    case this._PHASE_INITIATE_START:
                    {
                        this.phaseInitiateStart();
                        break;
                    }
                    case this._PHASE_INITIATE_RESULT:
                    {
                        this.phaseInitiateResult();
                        break;
                    }
                    case this._PHASE_CROWN_BUY:
                    {
                        this.phaseCrownBuy();
                        break;
                    }
                    case this._PHASE_MAINTENANCE:
                    {
                        this.initPhaseMaintenance();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function openMain() : void
        {
            if (this._bEnd)
            {
                this.setPhase(this._PHASE_OPEN);
                this._skillInitiateMc.resetReleaseId();
            }
            return;
        }// end function

        public function closeMain() : void
        {
            this.setButtonEnable(false);
            this._characterListMc.setSelectEnable(false);
            this._skillInitiateMc.setButtonEnable(false);
            this._resourceBox.setMouseOverEnable(false);
            this.setPhase(this._PHASE_CLOSE);
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._bAnimetion = true;
            this._bEnd = false;
            this._characterListFilter = SkillInitiateUtility.CHARA_LIST_FILTER_LEARNABLE;
            this._characterListMc.setListData(SkillInitiateUtility.getLearnablePlayerList());
            this._isoCharaList.setIn(this.cbCharaListIn);
            this._isoBase.setInLabel(this._FRAME_LABEL_IN);
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_MAINTENANCE);
            }
            return;
        }// end function

        private function phaseCharacterSelect() : void
        {
            this.resetCharacter();
            this._characterListFilter = SkillInitiateUtility.CHARA_LIST_FILTER_LEARNABLE;
            this._characterListMc.setListData(SkillInitiateUtility.getLearnablePlayerList());
            this._characterListMc.checkEmptyInformation(MessageManager.getInstance().getMessage(MessageId.SKILL_INITIATE_PLAYER_LIST_INFORMATION_01));
            this.setSkillId(Constant.EMPTY_ID);
            this.setDarkFilter(false);
            this._isoConf.setOut();
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.SKILL_INITIATE_MESSAGE_SELECT_CHARACTER));
            this._characterListMc.setSelectEnable(false);
            if (!this._isoCharaList.bOpened)
            {
                this._isoCharaList.setIn(this.cbInPaseCharacterSelect);
            }
            else
            {
                this.cbInPaseCharacterSelect();
            }
            return;
        }// end function

        private function cbInPaseCharacterSelect() : void
        {
            this._resourceBox.setMouseOverEnable(true);
            this.setButtonEnable(true);
            if (this._upgradeDisabled.facilityUpgrade(CommonConstant.FACILITY_ID_SKILL_INITIATE))
            {
                this._characterListMc.setSelectEnable(false);
                this._characterListMc.overlayVisible(true);
                this.setGuideText(MessageManager.getInstance().getMessage(MessageId.FACILITY_UPGRADENOW_GUIDE_MESSAGE));
            }
            else
            {
                this._characterListMc.setSelectEnable(true);
                this._characterListMc.overlayVisible(false);
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_1))
                {
                    this._characterListMc.setPlayerSelectEnable(false);
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_1, function () : void
            {
                _characterListMc.setPlayerSelectEnable(true);
                return;
            }// end function
            );
                }
                else if (TutorialManager.getInstance().isStepChange() && TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_5))
                {
                    this._characterListMc.setPlayerSelectEnable(false);
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_5, function () : void
            {
                _characterListMc.setPlayerSelectEnable(true);
                return;
            }// end function
            );
                }
            }
            return;
        }// end function

        private function controlCharacterSelect() : void
        {
            if (this._characterListMc.getSelectedPlayerData() != null)
            {
                this.setStudent(this._characterListMc.getSelectedPlayerData().personal.uniqueId, this._characterListMc.getSelectedPlayerData());
                this._characterListMc.resetSelect();
                this.setPhase(this._PHASE_SKILL_SELECT);
            }
            return;
        }// end function

        private function phaseCharacterSelectEnd() : void
        {
            this._isoCharaList.setOut();
            return;
        }// end function

        private function controlCharacterSelectEnd() : void
        {
            if (this._isoCharaList.bClosed)
            {
                if (this._skillSelectPopup.bInitiatable)
                {
                    this.setPhase(this._PHASE_SKILL_SELECT);
                }
                else
                {
                    this.setPhase(this._PHASE_CHARACTER_IGNORE);
                }
            }
            return;
        }// end function

        private function phaseCharacterIgnore() : void
        {
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.SKILL_INITIATE_NO_INITIATE_SKILL), this.cbCheckNoSkill);
            return;
        }// end function

        private function controlCharacterIgnore() : void
        {
            if (!CommonPopup.isUse())
            {
                this.setPhase(this._PHASE_CHARACTER_SELECT);
            }
            return;
        }// end function

        private function phaseSkillSelect() : void
        {
            this._characterListMc.setPlayerSelectEnable(false);
            this._resourceBox.setMouseOverEnable(false);
            this.setButtonEnable(false);
            this._characterListMc.setSelectEnable(false);
            this._characterListMc.overlayVisible(false);
            this._isoCharaList.setOut();
            this._skillInitiateMc.setButtonEnable(false);
            this._siManager.resetSupportId();
            this._skillInitiateMc.resetSupporter();
            this.setTeacher(Constant.EMPTY_ID);
            this._skillInitiateMc.setSkillId(Constant.EMPTY_ID);
            this._skillSelectPopup = new SISelectSkillPopup(this._baseMc.parent, this._siManager.studentId, this._siManager.skillId);
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.SKILL_INITIATE_MESSAGE_SELECT_SKILL));
            return;
        }// end function

        private function controlSkillSelect() : void
        {
            if (this._skillSelectPopup && this._skillSelectPopup.bClosed)
            {
                this._siManager.skillId = this._skillSelectPopup.selectedSkillId;
                this._initiateConfMc.setSelectedSkill(this._siManager.skillId);
                this._skillSelectPopup.release();
                this._skillSelectPopup = null;
                if (this._siManager.skillId == Constant.EMPTY_ID)
                {
                    this.setPhase(this._PHASE_CHARACTER_SELECT);
                }
                else
                {
                    this._siManager.bonusId = 0;
                    this.setPhase(this._PHASE_TEACHER_SELECT);
                }
            }
            return;
        }// end function

        private function phaseTeacherSelect() : void
        {
            this.setDarkFilter(false);
            if (this._isoConf.bClosed)
            {
                this._isoConf.setIn();
            }
            this._resourceBox.setMouseOverEnable(true);
            this.setButtonEnable(true);
            this._characterListFilter = SkillInitiateUtility.CHARA_LIST_FILTER_TEACHABLE;
            this._characterListMc.setListData(SkillInitiateUtility.getTeachablePlayerList(this._siManager.skillId));
            this._characterListMc.checkEmptyInformation(MessageManager.getInstance().getMessage(MessageId.SKILL_INITIATE_PLAYER_LIST_INFORMATION_01));
            this._characterListMc.setNotDisplayPlayer(this._siManager.aSelectedId);
            this._characterListMc.setPlayerMouseOverCallback(this.cbOver);
            this._characterListMc.setPlayerMouseOutCallback(this.cbOut);
            this._initiateConfMc.updateView(this._siManager);
            this._skillInitiateMc.setSkillId(this._siManager.skillId);
            this._skillInitiateMc.setButtonEnable(true);
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.SKILL_INITIATE_MESSAGE_SELECT_TEACHER));
            if (!this._isoCharaList.bOpened)
            {
                this._isoCharaList.setIn(this.cbCharaListIn);
            }
            else
            {
                this.cbCharaListIn();
            }
            return;
        }// end function

        private function cbOver(param1:int, param2:ListPlayerData) : void
        {
            if (this._phase != this._PHASE_TEACHER_SELECT)
            {
                return;
            }
            if (param2 == null)
            {
                return;
            }
            this._skillInitiateMc.setInitiateSkillPanel(param2.personal.getOwnSkillData(this._siManager.skillId));
            return;
        }// end function

        private function cbOut(param1:int, param2:ListPlayerData) : void
        {
            if (this._phase != this._PHASE_TEACHER_SELECT || this._siManager.studentId == Constant.EMPTY_ID)
            {
                return;
            }
            this._skillInitiateMc.setInitiateSkillPanel();
            return;
        }// end function

        private function controlTeacherSelect() : void
        {
            if (this._characterListMc.getSelectedPlayerData() != null)
            {
                this._characterListMc.setPlayerSelectEnable(false);
                this.setTeacher(this._characterListMc.getSelectedPlayerData().personal.uniqueId, this._characterListMc.getSelectedPlayerData());
                this._characterListMc.resetSelect();
                this._isoCharaList.setOut();
            }
            if (this._isoCharaList.bClosed)
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            this._characterListMc.setNotDisplayPlayer(this._siManager.aSelectedId);
            this._characterListFilter = SkillInitiateUtility.CHARA_LIST_FILTER_SUPPORTABLE;
            this._characterListMc.setListData(SkillInitiateUtility.getSupportablePlayerList());
            this._characterListMc.checkEmptyInformation(MessageManager.getInstance().getMessage(MessageId.SKILL_INITIATE_PLAYER_LIST_INFORMATION_02));
            this.setDarkFilter(false);
            this._characterListMc.setSelectEnable(false);
            if (!this._isoCharaList.bOpened)
            {
                this._isoCharaList.setIn(this.cbInPhaseWait);
            }
            else
            {
                this.cbInPhaseWait();
            }
            return;
        }// end function

        private function cbInPhaseWait() : void
        {
            this._characterListMc.setSelectEnable(true);
            this._skillInitiateMc.setButtonEnable(true);
            this._resourceBox.setMouseOverEnable(true);
            this.setButtonEnable(true);
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.SKILL_INITIATE_MESSAGE_SELECT_SUPPORT));
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_4))
            {
                this._characterListMc.setPlayerSelectEnable(false);
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_4, function () : void
            {
                _characterListMc.setPlayerSelectEnable(true);
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function controlWait() : void
        {
            if (this._characterListMc.getSelectedPlayerData() != null)
            {
                if (this._siManager.canAddSupport())
                {
                    this.changeSupport(this._characterListMc.getSelectedPlayerData().personal.uniqueId);
                }
            }
            return;
        }// end function

        private function phaseProbabilitySelect() : void
        {
            this.setDarkFilter(true);
            this.setButtonEnable(false);
            this._characterListMc.setSelectEnable(false);
            this._skillInitiateMc.setButtonEnable(false);
            this._resourceBox.setMouseOverEnable(false);
            this._probabilityPopup = new SISelectProbabiliryPopup(this._baseMc.parent, this._siManager.studentId, this._siManager.bonusId, int(this._siManager.calcBaseProbability()));
            return;
        }// end function

        private function controlProbabilitySelect() : void
        {
            if (this._probabilityPopup && this._probabilityPopup.bClosed)
            {
                this.setDarkFilter(false);
                this._siManager.bonusId = this._probabilityPopup.bonusId;
                this._initiateConfMc.updateView(this._siManager);
                this._probabilityPopup.release();
                this._probabilityPopup = null;
                this.correctionSupport();
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseInitiateConfirm() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this.setDarkFilter(true);
            this.setButtonEnable(false);
            this._characterListMc.setSelectEnable(false);
            this._skillInitiateMc.setButtonEnable(false);
            this._resourceBox.setMouseOverEnable(false);
            var _loc_1:* = SkillInitiateUtility.getItemCost(this._siManager.studentId, this._siManager.bonusId);
            var _loc_2:* = UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_REVISION_PROBABILITY);
            if (_loc_1 > _loc_2)
            {
                _loc_3 = ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_REVISION_PROBABILITY);
                CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.SKILL_INITIATE_POPUP_MESSAGE_PAYMENTITEM_NOT_ENOUGH, _loc_3), this.cbGetItem);
            }
            else
            {
                _loc_4 = UserDataManager.getInstance().userData.getPlayerPersonal(this._siManager.studentId);
                _loc_5 = PlayerManager.getInstance().getPlayerInformation(_loc_4.playerId);
                _loc_6 = SkillManager.getInstance().getSkillInformation(this._siManager.skillId);
                this._confirmPopup = new SIConfirmPopup(this._baseMc.parent, this._siManager);
            }
            return;
        }// end function

        private function controlInitiateConfirm(param1:Number) : void
        {
            var bContainRare:Boolean;
            var userData:UserDataPersonal;
            var personal:PlayerPersonal;
            var pInfo:PlayerInformation;
            var id:int;
            var t:* = param1;
            if (this._confirmPopup)
            {
                this._confirmPopup.control(t);
                if (this._confirmPopup.bEnd)
                {
                    if (this._confirmPopup.bConfirm)
                    {
                        bContainRare;
                        userData = UserDataManager.getInstance().userData;
                        personal = UserDataManager.getInstance().userData.getPlayerPersonal(this._siManager.teacherId);
                        pInfo = PlayerManager.getInstance().getPlayerInformation(personal.playerId);
                        if (pInfo && PlayerManager.getInstance().needDeleteCheckRarity(pInfo.rarity))
                        {
                            bContainRare;
                        }
                        if (!bContainRare)
                        {
                            var _loc_3:* = 0;
                            var _loc_4:* = this._siManager.aSupportId;
                            while (_loc_4 in _loc_3)
                            {
                                
                                id = _loc_4[_loc_3];
                                personal = userData.getPlayerPersonal(id);
                                if (personal)
                                {
                                    pInfo = PlayerManager.getInstance().getPlayerInformation(personal.playerId);
                                    if (pInfo && PlayerManager.getInstance().needDeleteCheckRarity(pInfo.rarity))
                                    {
                                        bContainRare;
                                        break;
                                    }
                                }
                                if (bContainRare)
                                {
                                    break;
                                }
                            }
                        }
                        if (bContainRare)
                        {
                            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.SKILL_INITIATE_POPUP_MESSAGE_CONFIRM_RARE), function (param1:Boolean) : void
            {
                if (param1)
                {
                    setPhase(_PHASE_INITIATE_CONNECTION);
                }
                else
                {
                    setPhase(_PHASE_WAIT);
                }
                return;
            }// end function
            );
                        }
                        else
                        {
                            this.setPhase(this._PHASE_INITIATE_CONNECTION);
                        }
                    }
                    else
                    {
                        this.setPhase(this._PHASE_WAIT);
                    }
                    this._confirmPopup.release();
                    this._confirmPopup = null;
                }
            }
            return;
        }// end function

        private function phaseInitiateConnect() : void
        {
            this.setDarkFilter(false);
            this._isoConf.setOut();
            this._isoCharaList.setOut();
            this._aButton[this._BUTTON_ID_RETURN].getMoveClip().visible = false;
            this._baseMc.captionMc.visible = false;
            var _loc_1:* = UserDataManager.getInstance().userData.getPlayerPersonal(this._siManager.teacherId);
            this._tPI = PlayerManager.getInstance().getPlayerInformation(_loc_1.playerId);
            NetManager.getInstance().request(new NetTaskSkillInitiate(this._siManager.studentId, this._siManager.skillId, SkillInitiateUtility.getBonusProbability(this._siManager.bonusId), this._siManager.teacherId, this._siManager.aSupportId, this.cbSkillInitiate));
            return;
        }// end function

        private function controlInitiateConnect(param1:Number) : void
        {
            return;
        }// end function

        private function phaseInitiateStart() : void
        {
            this._bAnimetion = true;
            this._isoBase.setInLabel(this._FRAME_LABEL_OUT1);
            TutorialManager.getInstance().stepChange(0);
            return;
        }// end function

        private function controlInitiateStart(param1:Number) : void
        {
            if (this._isoBase.bOpened)
            {
                if (this._skillInitiateMc.bEnd == true)
                {
                    this._skillInitiateMc.startAnimation(this._bSuccess);
                }
                this._skillInitiateMc.control(param1);
                if (this._skillInitiateMc.bEnd)
                {
                    this.setPhase(this._PHASE_INITIATE_RESULT);
                }
            }
            return;
        }// end function

        private function phaseInitiateResult() : void
        {
            var _loc_1:* = SkillManager.getInstance().getSkillInformation(this._siManager.skillId);
            this._bAnimetion = true;
            this._resourceBox.setMouseOverEnable(false);
            this.setButtonEnable(false);
            this.setDarkFilter(true);
            var _loc_2:* = UserDataManager.getInstance().userData.getPlayerPersonal(this._siManager.studentId);
            var _loc_3:* = PlayerManager.getInstance().getPlayerInformation(_loc_2.playerId);
            this._resultMc = new SIResultView(this._baseMc.parent, this._bSuccess, _loc_3, this._tPI, _loc_1.name, this._addParameter, this._siManager.isHaveSkill);
            return;
        }// end function

        private function controlInitiateResult(param1:Number) : void
        {
            var t:* = param1;
            if (this._resultMc && this._resultMc.bEnd)
            {
                this._isoBase.setInLabel(this._FRAME_LABEL_BACK);
                this._aButton[this._BUTTON_ID_RETURN].getMoveClip().visible = true;
                this._baseMc.captionMc.visible = true;
                this._resultMc.release();
                this._resultMc = null;
                if (this._bNotAutoEquip)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.SKILL_INITIATE_MESSAGE_EQUIPMENT_NOT), function () : void
            {
                setPhase(_PHASE_CHARACTER_SELECT);
                return;
            }// end function
            );
                }
                else
                {
                    this.setPhase(this._PHASE_CHARACTER_SELECT);
                }
            }
            return;
        }// end function

        private function phaseCrownBuy() : void
        {
            Main.GetProcess().createCrownUpdateWindow();
            return;
        }// end function

        private function controlCrownBuy(param1:Number) : void
        {
            if (Main.GetProcess().isCrownUpdateing() == false)
            {
                this.closeCrownWindow();
            }
            return;
        }// end function

        private function initPhaseMaintenance() : void
        {
            if (Main.GetApplicationData().maintenanceData.isMaintenanceTime())
            {
                Main.GetProcess().createMaintenanceWindow();
            }
            else
            {
                this.setPhase(this._PHASE_CHARACTER_SELECT);
            }
            return;
        }// end function

        private function controlPhaseMaintenance() : void
        {
            if (Main.GetProcess().maintenance == null)
            {
                this.setPhase(this._PHASE_CHARACTER_SELECT);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this.setButtonEnable(false);
            Main.GetProcess().topBar.cbConfigWindow(null, null);
            this._resourceBox.setMouseOverEnable(false);
            this._upgradeDisabled.close();
            this._bAnimetion = true;
            this._isoBase.setOutLabel(this._FRAME_LABEL_OUT2);
            this._isoCharaList.setOut();
            this._isoConf.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoBase.bEnd && this._isoConf.bEnd)
            {
                this._bEnd = true;
            }
            return;
        }// end function

        private function cbReturnBtn(param1:int) : void
        {
            this.setPhase(this._PHASE_CLOSE);
            return;
        }// end function

        private function cbOpenProbability(param1:int) : void
        {
            this.setPhase(this._PHASE_PROBABILITY_SELECT);
            return;
        }// end function

        private function cbOpenSkill(param1:int) : void
        {
            this.setPhase(this._PHASE_SKILL_SELECT);
            return;
        }// end function

        private function cbStartInitiate(param1:int) : void
        {
            this.setPhase(this._PHASE_INITIATE_CONFIRM);
            return;
        }// end function

        private function cbClearSetting(param1:int) : void
        {
            this.setPhase(this._PHASE_CHARACTER_SELECT);
            return;
        }// end function

        private function cbRemainPlayerNumFunc(param1:int, param2:ListPlayerData) : void
        {
            var listIndex:* = param1;
            var listPLayerData:* = param2;
            SoundManager.getInstance().playSe(SoundId.SE_GACHA_DISABLE);
            this.cbConfigWindowOpen();
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.MINIMUM_NUMBER_CHECK_MESSAGE), function () : void
            {
                cbConfigWindowClose();
                return;
            }// end function
            );
            return;
        }// end function

        private function cbSkillInitiate(param1:NetResult) : void
        {
            var _loc_6:* = 0;
            var _loc_10:* = null;
            this._bSuccess = param1.data.skillId != 0;
            var _loc_2:* = UserDataManager.getInstance().userData;
            var _loc_3:* = new PlayerPersonal();
            _loc_3.setParameter(param1.data.playerPersonal);
            var _loc_4:* = _loc_2.getPlayerPersonal(this._siManager.studentId);
            this._addParameter = SIConstant.INITIATE_STATUS_NONE;
            if (_loc_3.attack > _loc_4.attack)
            {
                this._addParameter = SIConstant.INITIATE_STATUS_ATTACK;
            }
            if (_loc_3.defense > _loc_4.defense)
            {
                this._addParameter = SIConstant.INITIATE_STATUS_DEFENCE;
            }
            if (_loc_3.speed > _loc_4.speed)
            {
                this._addParameter = SIConstant.INITIATE_STATUS_SPEED;
            }
            this._bNotAutoEquip = false;
            var _loc_5:* = false;
            for each (_loc_6 in _loc_4.aSetSkillId)
            {
                
                if (param1.data.skillId == _loc_6)
                {
                    _loc_5 = true;
                    break;
                }
            }
            if (!_loc_5)
            {
                if (_loc_3.getNotSetSkillNum() == _loc_4.getNotSetSkillNum())
                {
                    this._bNotAutoEquip = true;
                }
            }
            var _loc_7:* = _loc_2.aPlayerPersonal;
            var _loc_8:* = _loc_2.aPlayerPersonal.length;
            var _loc_9:* = 0;
            while (_loc_9 < _loc_8)
            {
                
                _loc_10 = _loc_7[_loc_9];
                if (_loc_10.uniqueId == _loc_3.uniqueId)
                {
                    _loc_7[_loc_9] = _loc_3;
                    break;
                }
                _loc_9++;
            }
            _loc_2.setOwnPlayer(_loc_7);
            this._resourceBox.updateNum();
            this._skillInitiateMc.setResult(this._bSuccess);
            this.setPhase(this._PHASE_INITIATE_START);
            this.setButtonEnable(false);
            return;
        }// end function

        private function cbFinishInitiate(param1:int) : void
        {
            return;
        }// end function

        private function cbCheckInitiate(param1:Boolean) : void
        {
            if (param1)
            {
                this.setPhase(this._PHASE_INITIATE_CONNECTION);
            }
            else
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function cbGetItem(param1:Boolean) : void
        {
            if (param1)
            {
                this._bGoTradingPost = true;
                TradingPostStartPageRequest.getInstance().setRequestRevisionProbability();
                this.setDarkFilter(false);
                this.closeMain();
            }
            else
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function cbCheckGetCrown(param1:Boolean) : void
        {
            if (param1)
            {
                this.setPhase(this._PHASE_CROWN_BUY);
            }
            else
            {
                this.closeCrownWindow();
            }
            return;
        }// end function

        private function cbCheckNoSkill() : void
        {
            this.setPhase(this._PHASE_CHARACTER_SELECT);
            return;
        }// end function

        public function cbCharaListIn() : void
        {
            this._characterListMc.setSelectEnable(true);
            this._bAnimetion = false;
            if (this._phase == this._PHASE_TEACHER_SELECT && TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_3))
            {
                this._characterListMc.setPlayerSelectEnable(false);
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_3, function () : void
            {
                _characterListMc.setPlayerSelectEnable(true);
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function cbConfigWindowOpen() : void
        {
            if (this._characterListMc)
            {
                this._characterListMc.setSelectEnable(false);
            }
            return;
        }// end function

        public function cbConfigWindowClose() : void
        {
            if (this._characterListMc)
            {
                this._characterListMc.setSelectEnable(true);
            }
            return;
        }// end function

        private function cbRestEnd(param1:PlayerPersonal) : void
        {
            var _loc_2:* = null;
            if (this._characterListFilter == SkillInitiateUtility.CHARA_LIST_FILTER_LEARNABLE)
            {
                this._characterListMc.setListData(SkillInitiateUtility.getLearnablePlayerList());
                this._characterListMc.checkEmptyInformation();
                this._characterListMc.setRestEndAction(param1.uniqueId);
            }
            else if (SkillInitiateUtility.checkFilterPlayer(param1, this._characterListFilter, this._siManager.skillId))
            {
                if (this._characterListMc)
                {
                    _loc_2 = new ListPlayerData(param1);
                    this._characterListMc.removePlayer(param1.uniqueId);
                    this._characterListMc.addPlayer(_loc_2);
                    this._characterListMc.removeNotDisplayPlayer(param1.uniqueId);
                    this._characterListMc.updateList();
                    this._characterListMc.checkEmptyInformation();
                    this._characterListMc.setRestEndAction(param1.uniqueId);
                }
            }
            return;
        }// end function

        private function setButtonEnable(param1:Boolean) : void
        {
            this._aButton[this._BUTTON_ID_RETURN].setDisable(!param1);
            this._aButton[this._BUTTON_ID_SKILL].setDisable(!param1 || this._siManager.studentId == Constant.EMPTY_ID);
            this._aButton[this._BUTTON_ID_PROBABILITY].setDisable(!param1 || this._siManager.teacherId == Constant.EMPTY_ID);
            this._aButton[this._BUTTON_ID_DECIDE].setDisable(!param1 || this._siManager.studentId == Constant.EMPTY_ID || this._siManager.teacherId == Constant.EMPTY_ID || this._siManager.skillId == Constant.EMPTY_ID);
            this._aButton[this._BUTTON_ID_RESET].setDisable(!param1 || this._siManager.studentId == Constant.EMPTY_ID);
            this._bButtonEnable = param1;
            return;
        }// end function

        private function setDarkFilter(param1:Boolean) : void
        {
            this._baseMc.filters = param1 ? ([new ColorMatrixFilter([0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 1, 0])]) : ([]);
            return;
        }// end function

        private function setGuideText(param1:String) : void
        {
            TextControl.setText(this._baseMc.captionMc.textMc.textDt, param1);
            var _loc_2:* = param1.split("\n");
            this._baseMc.captionMc.gotoAndStop("linage" + (_loc_2.length > 1 ? ("2") : ("1")));
            return;
        }// end function

        private function setStudent(param1:int, param2:ListPlayerData = null) : void
        {
            this._siManager.studentId = param1;
            this._siManager.studentData = param2;
            this._skillInitiateMc.setStudent(param1);
            this._initiateConfMc.updateView(this._siManager);
            this._characterListMc.setNotDisplayPlayer(this._siManager.aSelectedId);
            this._characterListMc.updateList();
            return;
        }// end function

        private function setTeacher(param1:int, param2:ListPlayerData = null) : void
        {
            this._siManager.teacherId = param1;
            this._siManager.teacherData = param2;
            this._skillInitiateMc.setTeacher(param1);
            this._skillInitiateMc.setInitiateSkillPanel(param2 == null || this._siManager.skillId == Constant.EMPTY_ID ? (null) : (param2.personal.getOwnSkillData(this._siManager.skillId)));
            this._initiateConfMc.updateView(this._siManager);
            this._characterListMc.setNotDisplayPlayer(this._siManager.aSelectedId);
            this._characterListMc.updateList();
            return;
        }// end function

        private function changeSupport(param1:int, param2:Boolean = false) : void
        {
            if (param2)
            {
                this._siManager.removeSupportId(param1);
                this._skillInitiateMc.removeSupporter(param1);
            }
            else
            {
                this._siManager.addSupportId(param1);
                this._skillInitiateMc.addSupporter(param1);
            }
            this.updateCharacter();
            return;
        }// end function

        private function correctionSupport() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            var _loc_1:* = this._siManager.aSupportId;
            var _loc_2:* = _loc_1.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = _loc_1[_loc_2];
                this._siManager.removeSupportId(_loc_3);
                _loc_4 = this._siManager.calcCurProbability();
                if (_loc_4 < 100)
                {
                    this._siManager.addSupportId(_loc_3);
                    break;
                }
                this._skillInitiateMc.removeSupporter(_loc_3);
                _loc_2 = _loc_2 - 1;
            }
            this.updateCharacter();
            return;
        }// end function

        private function updateCharacter() : void
        {
            this._characterListMc.resetSelect();
            this._characterListMc.setNotDisplayPlayer(this._siManager.aSelectedId);
            this._initiateConfMc.updateView(this._siManager);
            this._characterListMc.filterCharacter();
            this._characterListMc.updateList();
            this._characterListMc.setSelectEnable(this._siManager.canAddSupport());
            this._characterListMc.overlayVisible(!this._siManager.canAddSupport());
            this._characterListMc.checkEmptyInformation();
            return;
        }// end function

        private function resetCharacter() : void
        {
            this._siManager.resetSupportId();
            this._skillInitiateMc.resetSupporter();
            this.setStudent(Constant.EMPTY_ID);
            this.setTeacher(Constant.EMPTY_ID);
            this._characterListMc.filterCharacter();
            this._characterListMc.setSelectEnable(this._siManager.canAddSupport());
            this._characterListMc.overlayVisible(!this._siManager.canAddSupport());
            return;
        }// end function

        private function setSkillId(param1:int) : void
        {
            this._siManager.skillId = param1;
            this._skillInitiateMc.setSkillId(param1);
            return;
        }// end function

        private function closeCrownWindow() : void
        {
            this.setPhase(this._PHASE_WAIT);
            return;
        }// end function

    }
}
