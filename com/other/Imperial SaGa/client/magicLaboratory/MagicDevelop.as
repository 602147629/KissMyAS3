package magicLaboratory
{
    import asset.*;
    import button.*;
    import facility.*;
    import flash.display.*;
    import home.*;
    import item.*;
    import layer.*;
    import message.*;
    import network.*;
    import notice.*;
    import popup.*;
    import sound.*;
    import tradingPost.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class MagicDevelop extends Object
    {
        private const _MAGIC_DEVELOP_OPEN:int = 1;
        private const _MAGIC_DEVELOP_STAY:int = 10;
        private const _MAGIC_DEVELOP_CLOSE_START:int = 11;
        private const _MAGIC_DEVELOP_CLOSE_END:int = 12;
        private const _MAGIC_DEVELOP_END:int = 13;
        private const _MAGIC_DEVELOP_EFFECT_START:int = 20;
        private const _MAGIC_DEVELOP_RESULT:int = 30;
        private const _MAGIC_DEVELOP_DEVELOPING:int = 40;
        private const _MAGIC_DEVELOP_END_CONNECTION:int = 50;
        private var _baseMc:MovieClip;
        private var _isoDevelop:InStayOut;
        private var _isoPayBtn:InStayOut;
        private var _isoDevelopEffect:InStayOut;
        private var _resourceBox:MagicResourceBox;
        private var _magicDevelopList:MagicDevelopList;
        private var _result:MagicDevelopResult;
        private var _developReturnBtn:ButtonBase;
        private var _payBtn:ButtonBase;
        private var _instantBtn:InstantButton;
        private var _assetIcon:AssetIcon;
        private var _skillId:int;
        private var _bNewSkill:Boolean;
        private var _bInstantTutorialEnd:Boolean;
        private var _upgradeDisabled:FacilityUpgradeDisabled;
        private var _developWait:MagicDevelopWaitTimer;
        private var _phase:int;
        private var _developLock:Boolean;
        private var _bEnd:Boolean;
        private var _bGoTradingPost:Boolean;
        private var _errorMessageId:int;
        private var _layer:LayerMagicLaboratory;
        private static const _MAGIC_DEVELOP_ERROR_MESSAGE:int = 90;

        public function MagicDevelop(param1:MovieClip, param2:LayerMagicLaboratory)
        {
            this._layer = param2;
            this._baseMc = param1;
            this._developWait = new MagicDevelopWaitTimer(this._baseMc.magicDevelopMainMc.developTimeInfoMc, false);
            this._isoDevelop = new InStayOut(this._baseMc.magicDevelopMainMc, true);
            this._isoPayBtn = new InStayOut(this._baseMc.magicDevelopMainMc.startBtnTopMc, true);
            this._isoPayBtn.setEnd();
            this._isoDevelopEffect = new InStayOut(this._baseMc.magicDevelopMainMc.magicLearningMc, true);
            this._resourceBox = new MagicResourceBox(this._baseMc.magicDevelopMainMc.ItemIconBox);
            this._magicDevelopList = new MagicDevelopList(this._baseMc.magicDevelopMainMc.devMagicListMc);
            this._developReturnBtn = ButtonManager.getInstance().addButton(this._baseMc.magicDevelopMainMc.returnBtnMc, this.cbReturnClick);
            this._developReturnBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._baseMc.magicDevelopMainMc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._payBtn = ButtonManager.getInstance().addButton(this._baseMc.magicDevelopMainMc.startBtnTopMc.btnMc, this.cbDevelopConfirmClick);
            this._payBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._baseMc.magicDevelopMainMc.startBtnTopMc.btnMc.textMc.textDt, MessageId.MAGIC_DEVELOP_BUTTON_START);
            this._payBtn.setDisable(!MagicLabolatoryManager.getInstance().bDevelopable);
            this._instantBtn = new InstantButton(this._baseMc.magicDevelopMainMc.developTimeInfoMc.btnMc, MessageId.MAGIC_DEVELOP_BUTTON_FAST_FINISH, this.cbDevelopConfirmClick);
            this._instantBtn.setDisable(MagicLabolatoryManager.getInstance().isDeveloping() == false);
            var _loc_3:* = this._baseMc.magicDevelopMainMc.startBtnTopMc.developCost;
            this._assetIcon = new AssetIcon(_loc_3.dsNull, AssetId.ASSET_MAGIC_DEVELOP);
            TextControl.setText(_loc_3.infoTextMc.textDt, TextControl.formatIdText(MessageId.MAGIC_DEVELOP_USE_RESOURCE, AssetListManager.getInstance().getAssetName(AssetId.ASSET_MAGIC_DEVELOP)));
            this.updateResourceNum();
            this._upgradeDisabled = new FacilityUpgradeDisabled(this._layer.getLayer(LayerMagicLaboratory.POPUP));
            this._developLock = false;
            this._bNewSkill = false;
            this._bInstantTutorialEnd = false;
            this._bGoTradingPost = false;
            this.setCaptionText(MessageId.MAGIC_DEVELOP_INFO_ACTION_SELECT);
            this.setPhase(this._MAGIC_DEVELOP_OPEN);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function get bGoTradingPost() : Boolean
        {
            return this._bGoTradingPost;
        }// end function

        public function get bAnimetion() : Boolean
        {
            return !this._developReturnBtn.isEnable();
        }// end function

        public function release() : void
        {
            if (this._result != null)
            {
                this._result.release();
            }
            this._result = null;
            if (this._assetIcon)
            {
                this._assetIcon.release();
            }
            this._assetIcon = null;
            this.removeButton();
            if (this._magicDevelopList)
            {
                this._magicDevelopList.release();
            }
            this._magicDevelopList = null;
            if (this._resourceBox)
            {
                this._resourceBox.release();
            }
            this._resourceBox = null;
            if (this._isoDevelop)
            {
                this._isoDevelop.release();
            }
            this._isoDevelop = null;
            if (this._isoPayBtn)
            {
                this._isoPayBtn.release();
            }
            this._isoPayBtn = null;
            if (this._isoDevelopEffect)
            {
                this._isoDevelopEffect.release();
            }
            this._isoDevelopEffect = null;
            if (this._developWait)
            {
                this._developWait.release();
            }
            this._developWait = null;
            if (this._upgradeDisabled)
            {
                this._upgradeDisabled.release();
            }
            this._upgradeDisabled = null;
            this._baseMc = null;
            return;
        }// end function

        private function removeButton() : void
        {
            if (this._developReturnBtn != null)
            {
                ButtonManager.getInstance().removeButton(this._developReturnBtn);
            }
            this._developReturnBtn = null;
            if (this._payBtn != null)
            {
                ButtonManager.getInstance().removeButton(this._payBtn);
            }
            this._payBtn = null;
            if (this._instantBtn)
            {
                this._instantBtn.release();
            }
            this._instantBtn = null;
            this._upgradeDisabled.close();
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(param1)
                {
                    case this._MAGIC_DEVELOP_OPEN:
                    {
                        this.phaseDevelopOpen();
                        break;
                    }
                    case this._MAGIC_DEVELOP_STAY:
                    {
                        this.phaseDevelopStay();
                        break;
                    }
                    case this._MAGIC_DEVELOP_CLOSE_START:
                    {
                        this.phaseClose();
                        break;
                    }
                    case this._MAGIC_DEVELOP_DEVELOPING:
                    {
                        this.phaseDevelopDeveloping();
                        break;
                    }
                    case this._MAGIC_DEVELOP_END_CONNECTION:
                    {
                        this.phaseDevelopEndConnection();
                        break;
                    }
                    case this._MAGIC_DEVELOP_EFFECT_START:
                    {
                        this.phaseDevelopEffectStart();
                        break;
                    }
                    case this._MAGIC_DEVELOP_RESULT:
                    {
                        this.phaseResult();
                        break;
                    }
                    case _MAGIC_DEVELOP_ERROR_MESSAGE:
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

        public function control(param1:Number) : void
        {
            if (this._result)
            {
                this._result.control(param1);
            }
            if (this._magicDevelopList)
            {
                this._magicDevelopList.control(param1);
            }
            if (this._developWait && this._developWait.bOpened)
            {
                this._developWait.control(param1);
                if (this._developWait.bTimeOut && this._phase == this._MAGIC_DEVELOP_DEVELOPING && this._developLock == false)
                {
                    this._developWait.close();
                    this.setPhase(this._MAGIC_DEVELOP_END_CONNECTION);
                }
            }
            if (this._upgradeDisabled)
            {
                this._upgradeDisabled.countControl(param1);
            }
            switch(this._phase)
            {
                case this._MAGIC_DEVELOP_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._MAGIC_DEVELOP_STAY:
                {
                    break;
                }
                case this._MAGIC_DEVELOP_CLOSE_START:
                {
                    this.controlClose();
                    break;
                }
                case this._MAGIC_DEVELOP_CLOSE_END:
                {
                    this._bEnd = true;
                    this.setPhase(this._MAGIC_DEVELOP_END);
                    break;
                }
                case this._MAGIC_DEVELOP_DEVELOPING:
                {
                    this.controlDeveloping(param1);
                    break;
                }
                case this._MAGIC_DEVELOP_END:
                {
                    break;
                }
                case this._MAGIC_DEVELOP_EFFECT_START:
                {
                    this.controlDevelopEffectStart();
                    break;
                }
                case this._MAGIC_DEVELOP_RESULT:
                {
                    this.controlResult();
                    break;
                }
                case _MAGIC_DEVELOP_ERROR_MESSAGE:
                {
                    this.controlErrorMessage();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._instantBtn)
            {
                this._instantBtn.control(param1);
            }
            return;
        }// end function

        public function developClose() : void
        {
            this.setPhase(this._MAGIC_DEVELOP_CLOSE_START);
            return;
        }// end function

        private function setCaptionText(param1:int) : void
        {
            var _loc_2:* = MessageManager.getInstance().getMessage(param1);
            TextControl.setText(this._baseMc.magicDevelopMainMc.captionMc.textMc.textDt, _loc_2);
            var _loc_3:* = _loc_2.split("\n");
            this._baseMc.magicDevelopMainMc.captionMc.gotoAndStop("linage" + (_loc_3.length > 1 ? ("2") : ("1")));
            return;
        }// end function

        private function setButtonEnable(param1:Boolean) : void
        {
            var _loc_2:* = UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_MAGIC_DEVELOP);
            var _loc_3:* = MagicLabolatoryManager.getInstance();
            this._instantBtn.setDisable(!param1 || _loc_3.isDeveloping() == false);
            this._payBtn.setDisable(!param1 || _loc_2.upgradeEnd != 0 || _loc_3.isDeveloping() || !_loc_3.bDevelopable);
            this._developReturnBtn.setDisable(!param1);
            this._resourceBox.setMouseOverEnable(param1 && _loc_2.upgradeEnd == 0);
            this._magicDevelopList.setButtonEnable(param1 && _loc_2.upgradeEnd == 0);
            return;
        }// end function

        private function phaseDevelopOpen() : void
        {
            this._isoDevelop.setIn();
            this._bEnd = false;
            this._magicDevelopList.open();
            if (this._upgradeDisabled.facilityUpgrade(CommonConstant.FACILITY_ID_MAGIC_DEVELOP))
            {
                this.setCaptionText(MessageId.FACILITY_UPGRADENOW_GUIDE_MESSAGE);
            }
            this.setButtonEnable(false);
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoDevelop.bOpened)
            {
                if (MagicLabolatoryManager.getInstance().isDeveloping() == false)
                {
                    this.setPhase(this._MAGIC_DEVELOP_STAY);
                }
                else if (MagicLabolatoryManager.getInstance().isDevelopTimeOut())
                {
                    this.setPhase(this._MAGIC_DEVELOP_END_CONNECTION);
                }
                else
                {
                    this.setPhase(this._MAGIC_DEVELOP_DEVELOPING);
                }
            }
            return;
        }// end function

        private function phaseDevelopStay() : void
        {
            if (this._developWait.bOpened)
            {
                this._developWait.close();
            }
            if (!this._isoPayBtn.bOpened)
            {
                this._isoPayBtn.setIn();
            }
            this.setButtonEnable(true);
            this.setCaptionText(MessageId.MAGIC_DEVELOP_INFO_START);
            if (this._bInstantTutorialEnd && TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_3))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_3);
            }
            this._bInstantTutorialEnd = false;
            return;
        }// end function

        private function phaseDevelopDeveloping() : void
        {
            if (!this._developWait.bOpened)
            {
                this._developWait.open();
            }
            if (this._isoPayBtn.bOpened)
            {
                this._isoPayBtn.setOut();
            }
            this.setButtonEnable(true);
            this.setCaptionText(MessageId.MAGIC_DEVELOP_INFO_DEVELOP);
            this._instantBtn.setLearning(MagicLearnUtility.getDevelopInstantLearningNum(MagicLabolatoryManager.getInstance().developCompleteTime, TimeClock.getNowTime()));
            this._instantBtn.setEndTime(MagicLabolatoryManager.getInstance().developCompleteTime);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_2))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_2, function () : void
            {
                TutorialManager.getInstance().setTutorialArrow(_instantBtn.getBtn().getMoveClip());
                setButtonEnable(false);
                _instantBtn.setDisable(false);
                return;
            }// end function
            );
            }
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_3))
            {
                this._instantBtn.setLearning(0);
                this._instantBtn.setEndTime(uint.MAX_VALUE);
            }
            return;
        }// end function

        private function controlDeveloping(param1:Number) : void
        {
            if (this._instantBtn)
            {
                this._instantBtn.setLearning(MagicLearnUtility.getDevelopInstantLearningNum(MagicLabolatoryManager.getInstance().developCompleteTime, TimeClock.getNowTime()));
            }
            return;
        }// end function

        private function phaseDevelopEffectStart() : void
        {
            this._isoDevelopEffect.setIn();
            this.setButtonEnable(false);
            this._magicDevelopList.setButtonEnable(false);
            SoundManager.getInstance().playSe(SoundId.SE_REV_LAB_DEVFINISH);
            return;
        }// end function

        private function controlDevelopEffectStart() : void
        {
            if (this._isoDevelopEffect.bOpened)
            {
                this._isoDevelopEffect.setOut();
            }
            if (this._isoDevelopEffect.bEnd)
            {
                this.setPhase(this._MAGIC_DEVELOP_RESULT);
            }
            return;
        }// end function

        private function phaseDevelopEndConnection() : void
        {
            NetManager.getInstance().request(new NetTaskMagicDevelopEnd(false, 0, this.cbReceiveDevelopEnd));
            return;
        }// end function

        private function controlDevelopEndConnection() : void
        {
            return;
        }// end function

        private function phaseResult() : void
        {
            this._result = new MagicDevelopResult(this._baseMc, this._skillId);
            return;
        }// end function

        private function controlResult() : void
        {
            if (this._result != null && this._result.bEnd)
            {
                this._result.release();
                this._result = null;
                if (this._bNewSkill)
                {
                    this._magicDevelopList.updateList(this._skillId);
                    this._bNewSkill = false;
                }
                this.setPhase(this._MAGIC_DEVELOP_STAY);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this.setButtonEnable(false);
            this._isoDevelop.setOut();
            this._isoPayBtn.setOut();
            this._magicDevelopList.close();
            if (this._developWait.bOpened)
            {
                this._developWait.close();
            }
            this._upgradeDisabled.close();
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoDevelop.bEnd && this._isoPayBtn.bEnd && this._magicDevelopList.bEnd)
            {
                this.setPhase(this._MAGIC_DEVELOP_CLOSE_END);
            }
            return;
        }// end function

        private function phaseErrorMessage() : void
        {
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(this._errorMessageId), this.cbPopupClose);
            return;
        }// end function

        private function controlErrorMessage() : void
        {
            return;
        }// end function

        private function cbReturnClick(param1:int) : void
        {
            this.developClose();
            return;
        }// end function

        private function cbPopupClose() : void
        {
            ButtonManager.getInstance().pop();
            this._upgradeDisabled.close();
            this.setPhase(this._MAGIC_DEVELOP_STAY);
            return;
        }// end function

        private function cbDevelopConfirmClick(param1:int) : void
        {
            var numLearning:int;
            var resourceNum:int;
            var developSec:uint;
            var sec:int;
            var min:int;
            var hour:int;
            var id:* = param1;
            this._bNewSkill = false;
            this._developLock = true;
            this.setButtonEnable(false);
            if (this._developWait && this._developWait.bOpened)
            {
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_3))
                {
                    TutorialManager.getInstance().hideTutorial();
                    this.cbFastDevelopConfirm(true);
                }
                else
                {
                    numLearning = MagicLearnUtility.getDevelopInstantLearningNum(MagicLabolatoryManager.getInstance().developCompleteTime, TimeClock.getNowTime());
                    if (UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_INSTANT_LEARNING) >= numLearning)
                    {
                        CommonPopup.getInstance().openPaymentPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.MAGIC_DEVELOP_CONFIRM_USE_ITEM, UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_INSTANT_LEARNING), numLearning), this.cbFastDevelopConfirm);
                    }
                    else
                    {
                        CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_CONFIRM_GET_ITEM), this.cbGetFastDevelop);
                    }
                }
            }
            else
            {
                resourceNum = MagicLearnUtility.getDevelopResourceNum(MagicLabolatoryManager.getInstance().developCount);
                if (UserDataManager.getInstance().userData.magicResource < resourceNum)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, AssetListManager.getInstance().getAssetLackMessage(AssetId.ASSET_MAGIC_DEVELOP), function () : void
            {
                _developLock = false;
                setButtonEnable(true);
                return;
            }// end function
            );
                }
                else
                {
                    developSec = MagicLearnUtility.getDevelopSecond(MagicLabolatoryManager.getInstance().developCount);
                    sec = developSec % 60;
                    min = developSec / 60 % 60;
                    hour = developSec / 60 / 60;
                    CommonPopup.getInstance().openConsumePopup(CommonPopup.POPUP_TYPE_NORMAL, AssetId.ASSET_MAGIC_DEVELOP, TextControl.formatIdText(MessageId.MAGIC_DEVELOP_START_CONFIRM, resourceNum.toString(), hour < 10 ? ("0" + hour.toString()) : (hour), min < 10 ? ("0" + min.toString()) : (min), sec < 10 ? ("0" + sec.toString()) : (sec)), function (param1:Boolean) : void
            {
                if (param1)
                {
                    NetManager.getInstance().request(new NetTaskMagicDevelop(MagicLearnUtility.getDevelopResourceNum(MagicLabolatoryManager.getInstance().developCount), cbReceiveDevelopStart));
                }
                else
                {
                    _developLock = false;
                    setButtonEnable(true);
                }
                return;
            }// end function
            );
                }
            }
            return;
        }// end function

        private function cbReceiveDevelopStart(param1:NetResult) : void
        {
            MagicLabolatoryManager.getInstance().developCompleteTime = param1.data.endTime;
            NoticeManager.getInstance().addMiniNoticeByObject(param1.data.institutionNotice);
            this._developLock = false;
            this._resourceBox.updateNum();
            if (param1.resultCode == NetId.RESULT_OK)
            {
                MagicLabolatoryManager.getInstance().setDevelopCount((MagicLabolatoryManager.getInstance().developCount + 1));
                this.updateResourceNum();
            }
            this.setPhase(this._MAGIC_DEVELOP_DEVELOPING);
            return;
        }// end function

        private function cbReceiveDevelopEnd(param1:NetResult) : void
        {
            this._developLock = false;
            this._skillId = param1.data.skillId;
            this._bNewSkill = MagicLabolatoryManager.getInstance().skillDeveloped(this._skillId);
            this._bInstantTutorialEnd = true;
            MagicLabolatoryManager.getInstance().developCompleteTime = 0;
            this.setPhase(this._MAGIC_DEVELOP_EFFECT_START);
            return;
        }// end function

        private function cbFastDevelopConfirm(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            if (param1)
            {
                if (this._developWait.bTimeOut)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_CONFIRM_ALREADY_COMPLETE), this.cbClosePopup);
                }
                else
                {
                    _loc_2 = MagicLearnUtility.getDevelopInstantLearningNum(MagicLabolatoryManager.getInstance().developCompleteTime, TimeClock.getNowTime());
                    MagicLabolatoryManager.getInstance().developCompleteTime = 0;
                    this._developWait.close();
                    NetManager.getInstance().request(new NetTaskMagicDevelopEnd(true, _loc_2, this.cbReceiveDevelopEnd));
                }
            }
            else
            {
                this._developLock = false;
                this.setButtonEnable(true);
                this.setPhase(this._MAGIC_DEVELOP_DEVELOPING);
            }
            return;
        }// end function

        private function cbGetFastDevelop(param1:Boolean) : void
        {
            if (param1)
            {
                this._bGoTradingPost = true;
                TradingPostStartPageRequest.getInstance().setRequestInstantLearning();
                this.developClose();
            }
            else
            {
                this._developLock = false;
                this.setPhase(this._MAGIC_DEVELOP_DEVELOPING);
                this.setButtonEnable(true);
            }
            this._result = null;
            return;
        }// end function

        private function cbClosePopup() : void
        {
            this.setPhase(this._MAGIC_DEVELOP_DEVELOPING);
            this.setButtonEnable(true);
            this._result = null;
            this._developLock = false;
            return;
        }// end function

        private function updateResourceNum() : void
        {
            var _loc_1:* = this._baseMc.magicDevelopMainMc.startBtnTopMc.developCost;
            var _loc_2:* = MagicLearnUtility.getDevelopResourceNum(MagicLabolatoryManager.getInstance().developCount);
            TextControl.setText(_loc_1.NumTextMc.textDt, _loc_2.toString());
            return;
        }// end function

    }
}
