package magicLaboratory
{
    import button.*;
    import facility.*;
    import flash.display.*;
    import home.*;
    import item.*;
    import layer.*;
    import message.*;
    import network.*;
    import notice.*;
    import player.*;
    import popup.*;
    import resource.*;
    import skill.*;
    import tradingPost.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class MagicLearn extends Object
    {
        private const _PHASE_RESOURCE:int = 1;
        private const _PHASE_OPEN:int = 2;
        private const _PHASE_WAIT:int = 10;
        private const _PHASE_CONSOLE:int = 20;
        private const _PHASE_SKILL_SELECT:int = 30;
        private const _PHASE_LEARN_START:int = 40;
        private const _PHASE_IMMIDIATE_FINISH:int = 41;
        private const _PHASE_GET_ITEM:int = 42;
        private const _PHASE_ALREADY_FINISH:int = 43;
        private const _PHASE_LEARN_FINISH_CONNECT:int = 50;
        private const _PHASE_LEARN_FINISH:int = 51;
        private const _PHASE_CLOSE:int = 99;
        private const _PHASE_ERROR_MESSAGE:int = 100;
        private var _baseMc:MovieClip;
        private var _isoBase:InStayOut;
        private var _backButton:ButtonBase;
        private var _resourceBox:MagicResourceBox;
        private var _reserveList:MLearnReserveList;
        private var _console:MLearnConsole;
        private var _labolatory:MLearnLaboratory;
        private var _skillSelect:MLearnSkillSelect;
        private var _learnResult:MLearnResult;
        private var _phase:int;
        private var _selectedData:MagicLearningData;
        private var _bConnecting:Boolean;
        private var _bNotAutoEquip:Boolean;
        private var _upgradeDisabled:FacilityUpgradeDisabled;
        private var _bGoTradingPost:Boolean;
        private var _layer:LayerMagicLaboratory;

        public function MagicLearn(param1:MovieClip, param2:LayerMagicLaboratory)
        {
            Main.GetProcess().topBar.cbConfigWindow(this.cbConfigWindowOpen, this.cbConfigWindowClose);
            this._layer = param2;
            this._baseMc = param1;
            this._isoBase = new InStayOut(this._baseMc);
            this._bGoTradingPost = false;
            this._backButton = ButtonManager.getInstance().addButton(this._baseMc.returnBtnMc, this.cbReturnBtn);
            this._backButton.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._baseMc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN, true);
            this._backButton.setDisable(true);
            this._resourceBox = new MagicResourceBox(this._baseMc.ItemIconBox);
            this.setPhase(this._PHASE_RESOURCE);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoBase.bEnd && this._reserveList.bEnd && this._console.bClosed;
        }// end function

        public function get bAnimetion() : Boolean
        {
            return !this._backButton.isEnable();
        }// end function

        public function get bGoTradingPost() : Boolean
        {
            return this._bGoTradingPost;
        }// end function

        public function release() : void
        {
            if (this._isoBase)
            {
                this._isoBase.release();
            }
            this._isoBase = null;
            if (this._backButton)
            {
                ButtonManager.getInstance().removeButton(this._backButton);
            }
            this._backButton = null;
            if (this._resourceBox)
            {
                this._resourceBox.release();
            }
            this._resourceBox = null;
            if (this._reserveList)
            {
                this._reserveList.release();
            }
            this._reserveList = null;
            if (this._console)
            {
                this._console.release();
            }
            this._console = null;
            if (this._labolatory)
            {
                this._labolatory.release();
            }
            this._labolatory = null;
            if (this._skillSelect)
            {
                this._skillSelect.release();
            }
            this._skillSelect = null;
            this._upgradeDisabled.release();
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._reserveList != null)
            {
                this._reserveList.control(param1);
            }
            if (this._skillSelect != null)
            {
                this._skillSelect.control(param1);
            }
            if (this._labolatory != null)
            {
                this._labolatory.control(param1);
            }
            if (this._upgradeDisabled)
            {
                this._upgradeDisabled.countControl(param1);
            }
            switch(this._phase)
            {
                case this._PHASE_RESOURCE:
                {
                    this.controlResource();
                    break;
                }
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_CONSOLE:
                {
                    this.controlConsole(param1);
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait();
                    break;
                }
                case this._PHASE_SKILL_SELECT:
                {
                    this.controlSkillSelect();
                    break;
                }
                case this._PHASE_LEARN_START:
                {
                    this.controlLearnStart();
                    break;
                }
                case this._PHASE_IMMIDIATE_FINISH:
                {
                    this.controlImmidiateFinish();
                    break;
                }
                case this._PHASE_GET_ITEM:
                {
                    this.controlGetItem();
                    break;
                }
                case this._PHASE_ALREADY_FINISH:
                {
                    this.controlAlreadyFinish();
                    break;
                }
                case this._PHASE_LEARN_FINISH_CONNECT:
                {
                    this.controlLearnFinishConnect();
                    break;
                }
                case this._PHASE_LEARN_FINISH:
                {
                    this.controlLearnFinish(param1);
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                case this._PHASE_ERROR_MESSAGE:
                {
                    this.controlErrorMessage();
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
                switch(this._phase)
                {
                    case this._PHASE_RESOURCE:
                    {
                        this.phaseResource();
                        break;
                    }
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
                        break;
                    }
                    case this._PHASE_CONSOLE:
                    {
                        this.phaseConsole();
                        break;
                    }
                    case this._PHASE_SKILL_SELECT:
                    {
                        this.phaseSkillSelect();
                        break;
                    }
                    case this._PHASE_LEARN_START:
                    {
                        this.phaseLearnStart();
                        break;
                    }
                    case this._PHASE_IMMIDIATE_FINISH:
                    {
                        this.phaseImmidiateFinish();
                        break;
                    }
                    case this._PHASE_GET_ITEM:
                    {
                        this.phaseGetItem();
                        break;
                    }
                    case this._PHASE_ALREADY_FINISH:
                    {
                        this.phaseAlreadyFinish();
                        break;
                    }
                    case this._PHASE_LEARN_FINISH_CONNECT:
                    {
                        this.phaseLearnFinishConnect();
                        break;
                    }
                    case this._PHASE_LEARN_FINISH:
                    {
                        this.phaseLearnFinish();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    case this._PHASE_ERROR_MESSAGE:
                    {
                        this.phaseErrorMessage();
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

        public function setLv(param1:int) : void
        {
            this._baseMc.gotoAndStop(param1);
            return;
        }// end function

        public function close() : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            return;
        }// end function

        private function setCaptionText(param1:int) : void
        {
            if (param1 == Constant.UNDECIDED)
            {
                TextControl.setText(this._baseMc.captionMc.textMc.textDt, "");
            }
            else
            {
                TextControl.setIdText(this._baseMc.captionMc.textMc.textDt, param1);
            }
            return;
        }// end function

        private function phaseResource() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = UserDataManager.getInstance().userData;
            for each (_loc_2 in _loc_1.aPlayerPersonal)
            {
                
                ResourceManager.getInstance().loadArray(PlayerManager.getInstance().getPlayerResourcePath(_loc_2.playerId));
            }
            this.setCaptionText(Constant.UNDECIDED);
            return;
        }// end function

        private function controlResource() : void
        {
            if (ResourceManager.getInstance().isLoaded() == false)
            {
                return;
            }
            this._reserveList = new MLearnReserveList(this._baseMc.charaListMc);
            this._console = new MLearnConsole(this._baseMc.labolatroyConfTopMc);
            this._labolatory = new MLearnLaboratory(this._baseMc.magicDevelopMc);
            this._reserveList.setSelectEnable(false);
            this._upgradeDisabled = new FacilityUpgradeDisabled(this._layer.getLayer(LayerMagicLaboratory.POPUP));
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._isoBase.setIn();
            this._reserveList.open();
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            this._selectedData = MagicLabolatoryManager.getInstance().getSelectedLearningData();
            this._labolatory.hideSimpleStatus();
            this._console.closeList();
            this.setButtonEnable(true);
            if (this._selectedData == null)
            {
                this._reserveList.setSelectEnable(false);
            }
            else
            {
                this._reserveList.setSelectEnable(this._selectedData.uniqueId == Constant.EMPTY_ID);
                this._selectedData.resetData();
                this._reserveList.resetSelectPlayer();
            }
            this.setCaptionText(MessageId.MAGIC_LEARN_CAPTION_MESSAGE_CHARACTER);
            this.facilityTutorialCheck();
            if (this._upgradeDisabled.facilityUpgrade(CommonConstant.FACILITY_ID_MAGIC_DEVELOP))
            {
                this._reserveList.setSelectEnable(false);
                this._resourceBox.setMouseOverEnable(false);
                this.setCaptionText(MessageId.FACILITY_UPGRADENOW_GUIDE_MESSAGE);
            }
            return;
        }// end function

        private function controlWait() : void
        {
            var _loc_1:* = MagicLabolatoryManager.getInstance().checkFastFinishAlert();
            if (_loc_1 != Constant.UNDECIDED)
            {
                this._selectedData = MagicLabolatoryManager.getInstance().getLearningData(_loc_1);
                this.setPhase(this._PHASE_IMMIDIATE_FINISH);
                return;
            }
            _loc_1 = MagicLabolatoryManager.getInstance().checkFinishAlert();
            if (_loc_1 != Constant.UNDECIDED)
            {
                this._selectedData = MagicLabolatoryManager.getInstance().getLearningData(_loc_1);
                this.setPhase(this._PHASE_LEARN_FINISH_CONNECT);
                return;
            }
            if (this._selectedData == null)
            {
                return;
            }
            if (this._reserveList.selectedUniqueId != Constant.EMPTY_ID)
            {
                this._selectedData.uniqueId = this._reserveList.selectedUniqueId;
                this._reserveList.fixSelectPlayer();
                this.setPhase(this._PHASE_SKILL_SELECT);
            }
            return;
        }// end function

        private function phaseConsole() : void
        {
            if (this._console.bClosed)
            {
                this._console.openList();
            }
            this._labolatory.setButtonEnable(false);
            this.setCaptionText(MessageId.MAGIC_LEARN_CAPTION_MESSAGE_SKILL);
            return;
        }// end function

        private function controlConsole(param1:Number) : void
        {
            if (this._console != null)
            {
                if (this._console.bLearnStart)
                {
                    this.setPhase(this._PHASE_LEARN_START);
                }
                if (this._console.bOpenSkillSelect)
                {
                    this._console.checkOpenSkillList();
                    this.setPhase(this._PHASE_SKILL_SELECT);
                }
                if (this._console.bEnd)
                {
                    if (this._console.bReset)
                    {
                        this._selectedData.resetData();
                        this._reserveList.resetSelectPlayer();
                    }
                    this.setPhase(this._PHASE_WAIT);
                }
            }
            if (this._selectedData.uniqueId == Constant.EMPTY_ID)
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseSkillSelect() : void
        {
            this.setButtonEnable(false);
            var _loc_1:* = MagicLabolatoryManager.getInstance().getIndex(this._selectedData);
            this._labolatory.showSimpleStatus(_loc_1);
            this._skillSelect = new MLearnSkillSelect(this._baseMc.parent, this._selectedData);
            this._skillSelect.openList();
            this.setCaptionText(MessageId.MAGIC_LEARN_CAPTION_MESSAGE_SKILL);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_2))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_2);
            }
            return;
        }// end function

        private function controlSkillSelect() : void
        {
            if (this._skillSelect.bEnd)
            {
                this._selectedData.skillId = this._skillSelect.selectSkillId;
                this._console.setSkill(this._skillSelect.selectSkillId);
                this._skillSelect.release();
                this._skillSelect = null;
                if (this._selectedData.skillId != Constant.EMPTY_ID)
                {
                    this._reserveList.fixSelectPlayer();
                    this.setPhase(this._PHASE_LEARN_START);
                }
                else
                {
                    this._reserveList.resetSelectPlayer();
                    this.setPhase(this._PHASE_WAIT);
                }
            }
            return;
        }// end function

        private function phaseLearnStart() : void
        {
            var _loc_1:* = MagicLabolatoryManager.getInstance().getIndex(this._selectedData);
            var _loc_2:* = SkillManager.getInstance().getSkillInformation(this._selectedData.skillId);
            NetManager.getInstance().request(new NetTaskMagicDevelopLearning(false, this._selectedData.uniqueId, this._selectedData.skillId, _loc_1, MagicLearnUtility.getLearnResourceNum(_loc_2), this.cbReceiveStart));
            return;
        }// end function

        private function controlLearnStart() : void
        {
            return;
        }// end function

        private function phaseImmidiateFinish() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            this.setButtonEnable(false);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_4))
            {
                TutorialManager.getInstance().hideTutorial();
                _loc_1 = MagicLabolatoryManager.getInstance().getIndex(this._selectedData);
                NetManager.getInstance().request(new NetTaskMagicDevelopLearningEnd(_loc_1, true, _loc_2, this.cbReceiveHighSpeed));
            }
            else
            {
                _loc_2 = MagicLearnUtility.getLearnInstantLearningNum(this._selectedData.endTime, TimeClock.getNowTime());
                if (UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_INSTANT_LEARNING) >= _loc_2)
                {
                    CommonPopup.getInstance().openPaymentPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.MAGIC_LEARN_POPUP_MESSAGE_IMMIDIATE, UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_INSTANT_LEARNING), _loc_2), this.cbLearnStart);
                }
                else
                {
                    this.setPhase(this._PHASE_GET_ITEM);
                }
            }
            return;
        }// end function

        private function controlImmidiateFinish() : void
        {
            return;
        }// end function

        private function phaseGetItem() : void
        {
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.MAGIC_LEARN_POPUP_MESSAGE_GET_ITEM), this.cbGetItem);
            return;
        }// end function

        private function controlGetItem() : void
        {
            return;
        }// end function

        private function phaseAlreadyFinish() : void
        {
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.MAGIC_LEARN_POPUP_MESSAGE_ALREADY_COMPLETE), this.cbClosePopup);
            return;
        }// end function

        private function controlAlreadyFinish() : void
        {
            return;
        }// end function

        private function phaseLearnFinishConnect() : void
        {
            this.setButtonEnable(false);
            var _loc_1:* = MagicLabolatoryManager.getInstance().getIndex(this._selectedData);
            NetManager.getInstance().request(new NetTaskMagicDevelopLearningEnd(_loc_1, false, 0, this.cbReceiveHighSpeed));
            return;
        }// end function

        private function controlLearnFinishConnect() : void
        {
            return;
        }// end function

        private function phaseLearnFinish() : void
        {
            this.setButtonEnable(false);
            this._learnResult = new MLearnResult(Main.GetProcess());
            this._learnResult.setData(this._selectedData.uniqueId, this._selectedData.skillId);
            this._learnResult.open();
            return;
        }// end function

        private function controlLearnFinish(param1:Number) : void
        {
            var t:* = param1;
            this._learnResult.control(t);
            if (this._learnResult.bEnd && this._bConnecting == false)
            {
                this._learnResult.release();
                this._learnResult = null;
                this._selectedData.resetData();
                this.setPhase(this._PHASE_WAIT);
                if (this._bNotAutoEquip)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.MAGIC_LEARN_CAPTION_MESSAGE_EQUIPMENT_NOT), function () : void
            {
                checkTutorial();
                return;
            }// end function
            );
                }
                else
                {
                    this.checkTutorial();
                }
            }
            return;
        }// end function

        private function checkTutorial() : void
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_4))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_4, function () : void
            {
                ButtonManager.getInstance().unseal();
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._resourceBox.setMouseOverEnable(false);
            this._reserveList.close();
            this._console.closeList();
            this._isoBase.setOut();
            Main.GetProcess().topBar.cbConfigWindow(null, null);
            this._upgradeDisabled.close();
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function phaseErrorMessage() : void
        {
            this._resourceBox.setMouseOverEnable(false);
            this._labolatory.setButtonEnable(false);
            ButtonManager.getInstance().push();
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.MAGIC_LEARN_CAPTION_MESSAGE_NOT_SKILL), this.cbErrorMessage);
            return;
        }// end function

        private function controlErrorMessage() : void
        {
            return;
        }// end function

        private function setButtonEnable(param1:Boolean) : void
        {
            var _loc_2:* = UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_MAGIC_DEVELOP);
            if (this._backButton)
            {
                this._backButton.setDisable(!param1);
            }
            if (this._resourceBox)
            {
                this._resourceBox.setMouseOverEnable(param1 && _loc_2.upgradeEnd == 0);
            }
            if (this._labolatory)
            {
                this._labolatory.setButtonEnable(param1);
            }
            if (this._reserveList)
            {
                if (param1)
                {
                    this._reserveList.setSelectEnable(this._selectedData && this._selectedData.uniqueId == Constant.EMPTY_ID && _loc_2.upgradeEnd == 0);
                }
                else
                {
                    this._reserveList.setSelectEnable(false);
                }
            }
            return;
        }// end function

        private function facilityTutorialCheck() : void
        {
            var charaView:MLearningCharacterView;
            var idx:int;
            var aCharaView:Array;
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_1))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_1);
            }
            else if (!TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_3) && TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_INSTANT))
            {
                aCharaView = this._labolatory.aCharaView;
                idx;
                while (idx < aCharaView.length)
                {
                    
                    charaView = aCharaView[idx];
                    if (charaView.getPlayerDisplay().uniqueId != Constant.EMPTY_ID)
                    {
                        break;
                    }
                    idx = (idx + 1);
                }
                if (idx >= aCharaView.length)
                {
                    charaView;
                    idx;
                }
                if (charaView)
                {
                    this.setButtonEnable(false);
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_INSTANT, function () : void
            {
                var _loc_1:* = charaView.instantBtn.getBtn();
                TutorialManager.getInstance().setTutorialArrow(_loc_1.getMoveClip());
                ButtonManager.getInstance().seal([_loc_1], true);
                return;
            }// end function
            );
                }
            }
            return;
        }// end function

        private function cbReturnBtn(param1:int) : void
        {
            this.close();
            return;
        }// end function

        private function cbLearnStart(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (param1)
            {
                _loc_2 = MagicLearnUtility.getLearnInstantLearningNum(this._selectedData.endTime, TimeClock.getNowTime());
                if (UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_INSTANT_LEARNING) >= _loc_2)
                {
                    if (this._selectedData.endTime <= TimeClock.getNowTime())
                    {
                        this.setPhase(this._PHASE_ALREADY_FINISH);
                    }
                    else
                    {
                        _loc_3 = MagicLabolatoryManager.getInstance().getIndex(this._selectedData);
                        NetManager.getInstance().request(new NetTaskMagicDevelopLearningEnd(_loc_3, true, _loc_2, this.cbReceiveHighSpeed));
                    }
                }
                else
                {
                    this.setPhase(this._PHASE_GET_ITEM);
                }
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
                TradingPostStartPageRequest.getInstance().setRequestInstantLearning();
                this.close();
            }
            else
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function cbClosePopup() : void
        {
            this.setPhase(this._PHASE_WAIT);
            return;
        }// end function

        private function cbReceiveStart(param1:NetResult) : void
        {
            if (param1.resultCode == NetId.RESULT_ERROR_MAGIC_DEVELOP_LEARNING_CANT_HAVE)
            {
                this.setPhase(this._PHASE_ERROR_MESSAGE);
                return;
            }
            this._selectedData.endTime = param1.data.institutionNotice.time;
            if (this._selectedData.endTime <= TimeClock.getNowTime())
            {
                this._selectedData.alertFinish();
            }
            this._selectedData.noticeId = param1.data.institutionNotice.uniqueId;
            var _loc_2:* = UserDataManager.getInstance().userData;
            var _loc_3:* = _loc_2.aPlayerPersonal;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                if (_loc_3[_loc_4].uniqueId == this._selectedData.uniqueId)
                {
                    (_loc_3[_loc_4] as PlayerPersonal).setUseFacility(CommonConstant.FACILITY_ID_MAGIC_DEVELOP, 0, param1.data.institutionNotice.time);
                    break;
                }
                _loc_4++;
            }
            _loc_2.setOwnPlayer(_loc_3);
            NoticeManager.getInstance().addMiniNoticeByObject(param1.data.institutionNotice);
            this._resourceBox.updateNum();
            if (this._labolatory != null)
            {
                this._labolatory.control(0);
            }
            this.setPhase(this._PHASE_WAIT);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_3))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_3, this.facilityTutorialCheck);
            }
            return;
        }// end function

        private function cbReceiveHighSpeed(param1:NetResult) : void
        {
            var _loc_7:* = null;
            var _loc_2:* = UserDataManager.getInstance().userData;
            var _loc_3:* = new PlayerPersonal();
            _loc_3.setParameter(param1.data.playerPersonal);
            _loc_3.setUseFacility(Constant.EMPTY_ID, 0, 0);
            var _loc_4:* = _loc_2.aPlayerPersonal;
            var _loc_5:* = _loc_2.aPlayerPersonal.length;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = _loc_4[_loc_6];
                if (_loc_7.uniqueId == _loc_3.uniqueId)
                {
                    this._bNotAutoEquip = false;
                    if (_loc_7.getNotSetSkillNum() == _loc_3.getNotSetSkillNum())
                    {
                        this._bNotAutoEquip = true;
                    }
                    _loc_4[_loc_6] = _loc_3;
                    break;
                }
                _loc_6++;
            }
            _loc_2.setOwnPlayer(_loc_4);
            this._bConnecting = false;
            this._selectedData.noticeId = Constant.EMPTY_ID;
            this._reserveList.resetPlayerListData();
            this.setPhase(this._PHASE_LEARN_FINISH);
            return;
        }// end function

        private function cbErrorMessage() : void
        {
            ButtonManager.getInstance().pop();
            this.setPhase(this._PHASE_WAIT);
            return;
        }// end function

        public function cbConfigWindowOpen() : void
        {
            this.setButtonEnable(false);
            return;
        }// end function

        public function cbConfigWindowClose() : void
        {
            this.setButtonEnable(true);
            return;
        }// end function

    }
}
