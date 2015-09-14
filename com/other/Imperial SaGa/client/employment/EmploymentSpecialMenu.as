package employment
{
    import button.*;
    import character.*;
    import develop.*;
    import flash.display.*;
    import item.*;
    import layer.*;
    import message.*;
    import network.*;
    import player.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import user.*;
    import utility.*;

    public class EmploymentSpecialMenu extends EmploymentMenuBase
    {
        private const _EMPLOYMENT_SPECIAL_NUM:int = 1;
        private const _EMPLOYMENT_LIMITED_NUM:int = 1;
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _aBtn:Array;
        private var _playerNumBox:EmploymentPlayerNumBox;
        private var _cbClose:Function;
        private var _layer:LayerEmployment;
        private var _type:int;
        private var _employAnimation:EmploymentSpecialAnimation;
        private var _aProbabilityContentTable:Array;
        private var _employPlayerInfo:PlayerInformation;
        private var _aCandidatePlayerId:Array;
        private var _price:int;
        private var _numericTicketItem:NumericNumberMc;
        private var _limitedData:EmploymentLimitedData;
        private var _bGoTradingPost:Boolean;
        private var _bGoRetire:Boolean;
        private var _summonSpeed:Number;
        private static const _PHASE_INIT:int = 0;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_INPUT_WAIT:int = 2;
        private static const _PHASE_CONNECTING:int = 3;
        private static const _PHASE_RESOURCE_LOADING:int = 4;
        private static const _PHASE_ANIMATION:int = 5;
        private static const _PHASE_POPUP:int = 6;
        private static const _PHASE_CLOSE:int = 7;
        private static const _PHASE_CLOWN_UPDATE:int = 9001;
        private static const _BUTTON_RETURN:int = 0;
        private static const _BUTTON_EMPLOY_HIGH:int = 1;
        private static const _BUTTON_EMPLOY_SPECIAL:int = 2;
        private static const _BUTTON_PROBABILITY_LIST:int = 3;

        public function EmploymentSpecialMenu(param1:LayerEmployment, param2:int, param3:int, param4:Array, param5:Function, param6:EmploymentLimitedData = null)
        {
            var _loc_7:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this._summonSpeed = 1;
            this._layer = param1;
            this._cbClose = param5;
            this._price = param3;
            this._employAnimation = null;
            this._employPlayerInfo = null;
            this._aCandidatePlayerId = null;
            this._limitedData = param6;
            this._bGoTradingPost = false;
            this._bGoRetire = false;
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonProduction.swf", "summonBtnMc");
            this._layer.getLayer(LayerEmployment.MAIN).addChild(this._mcBase);
            this._isoMain = new InStayOut(this._mcBase);
            TextControl.setText(this._mcBase.warriorBtnMc.PriceMc.textDt, param3.toString());
            this._numericTicketItem = new NumericNumberMc(this._mcBase.haveTicketMc.numMc, 0, 1, false);
            this.updateTicketNum();
            var _loc_8:* = [{mc:this._mcBase.returnBtnMc, cbFunc:this.cbReturnBtn, id:_BUTTON_RETURN, soundId:ButtonBase.SE_CANCEL_ID}, {mc:this._mcBase.warriorBtnMc, cbFunc:this.cbEmploymentBtn, id:_BUTTON_EMPLOY_HIGH, soundId:SoundId.SE_DECIDE}, {mc:this._mcBase.specialBtnMc, cbFunc:this.cbEmploymentBtn, id:_BUTTON_EMPLOY_SPECIAL, soundId:SoundId.SE_DECIDE}];
            this._aBtn = [];
            for each (_loc_7 in _loc_8)
            {
                
                _loc_10 = ButtonManager.getInstance().addButton(_loc_7.mc, _loc_7.cbFunc, _loc_7.id);
                _loc_10.enterSeId = _loc_7.soundId;
                this._aBtn.push(_loc_10);
            }
            this._playerNumBox = new EmploymentPlayerNumBox(this._mcBase.VassalNumMc, this.cbRetireButton);
            TextControl.setIdText(this._mcBase.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            TextControl.setIdText(this._mcBase.warriorBtnMc.textMc.textDt, MessageId.EMPLOYMENT_HIGH_EMPLOY_BUTTON);
            TextControl.setIdText(this._mcBase.specialBtnMc.textMc.textDt, MessageId.EMPLOYMENT_HIGH_EMPLOY_BUTTON);
            this._mcBase.itiranBtnMc.visible = false;
            _loc_9 = ItemManager.getInstance().getPaymentItemInformation(PaymentItemId.ITEM_TICKET_GACHA_001);
            TextControl.setText(this._mcBase.haveTicketMc.textMc.textDt, _loc_9.name);
            TextControl.setText(this._mcBase.specialBtnMc.ticketTextMc.textDt, _loc_9.name);
            TextControl.setText(this._mcBase.warriorBtnMc.PriceMc.textDt, this._price.toString());
            TextControl.setText(this._mcBase.specialBtnMc.PriceMc.textDt, this._price.toString());
            this._type = Constant.UNDECIDED;
            this.setEmploymentType(param2, param4);
            this.setPhase(_PHASE_INIT);
            return;
        }// end function

        public function get bGoTradingPost() : Boolean
        {
            return this._bGoTradingPost;
        }// end function

        public function get bGoRetire() : Boolean
        {
            return this._bGoRetire;
        }// end function

        public function get bStay() : Boolean
        {
            return this._phase == _PHASE_INPUT_WAIT && (this._isoMain && this._isoMain.bAnimetion == false);
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBtn)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aBtn = null;
            if (this._playerNumBox)
            {
                this._playerNumBox.release();
            }
            this._playerNumBox = null;
            if (this._employAnimation)
            {
                this._employAnimation.release();
            }
            this._employAnimation = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            super.release();
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_INIT:
                {
                    this.initPhaseInit();
                    break;
                }
                case _PHASE_OPEN:
                {
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_INPUT_WAIT:
                {
                    this.initPhaseInputWait();
                    break;
                }
                case _PHASE_CONNECTING:
                {
                    this.initPhaseConnecting();
                    break;
                }
                case _PHASE_RESOURCE_LOADING:
                {
                    this.initPhaseResourceLoading();
                    break;
                }
                case _PHASE_ANIMATION:
                {
                    this.initPhaseAnimation();
                    break;
                }
                case _PHASE_POPUP:
                {
                    this.initPhasePopup();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
                    break;
                }
                case _PHASE_CLOWN_UPDATE:
                {
                    this.initPhaseCrownUpdate();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            param1 = param1 * this._summonSpeed;
            switch(this._phase)
            {
                case _PHASE_RESOURCE_LOADING:
                {
                    this.controlPhaseResourceLoading();
                    break;
                }
                case _PHASE_CLOWN_UPDATE:
                {
                    this.controlPhaseCrownUpdate(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._employAnimation)
            {
                this._employAnimation.control(param1);
            }
            return;
        }// end function

        private function initPhaseInit() : void
        {
            this.btnDisableFlag();
            if (this._employAnimation == null)
            {
                this._employAnimation = new EmploymentSpecialAnimation(this._layer.getLayer(LayerEmployment.ANIMATION), this._type, this._limitedData, this.cbEmployAnimationOpen, this.cbEmployAnimationRetry);
            }
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            this.btnDisableFlag();
            this._playerNumBox.updatePlayerNum();
            this._isoMain.setIn(function () : void
            {
                setPhase(_PHASE_INPUT_WAIT);
                return;
            }// end function
            );
            this._employAnimation.openBanner();
            return;
        }// end function

        private function initPhaseInputWait() : void
        {
            this.btnEnable(true);
            return;
        }// end function

        private function initPhaseConnecting() : void
        {
            this.btnEnable(false);
            return;
        }// end function

        private function initPhaseResourceLoading() : void
        {
            this.btnEnable(false);
            this._isoMain.setOut();
            return;
        }// end function

        private function controlPhaseResourceLoading() : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(_PHASE_ANIMATION);
            }
            return;
        }// end function

        private function initPhaseAnimation() : void
        {
            var _loc_1:* = Main.GetApplicationData().userConfigData;
            this._summonSpeed = _loc_1.setSummonSpeed();
            DebugLog.print("召喚演出スピード設定:" + this._summonSpeed + "倍");
            this.btnEnable(false);
            this._employAnimation.playAnimation(this._employPlayerInfo, this._aCandidatePlayerId);
            return;
        }// end function

        private function initPhasePopup() : void
        {
            this.btnDisableFlag();
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this.btnEnable(false);
            this._isoMain.setOut();
            this._employAnimation.close(this._cbClose);
            return;
        }// end function

        private function initPhaseCrownUpdate() : void
        {
            this.btnEnable(false);
            return;
        }// end function

        public function controlPhaseCrownUpdate(param1:Number) : void
        {
            if (!Main.GetProcess().isCrownUpdateing())
            {
                this.setPhase(_PHASE_INPUT_WAIT);
            }
            return;
        }// end function

        private function setEmploymentType(param1:int, param2:Array) : void
        {
            if (this._type == param1)
            {
                return;
            }
            this._type = param1;
            if (this._type == CommonConstant.EMPLOYMENT_TYPE_LIMITED)
            {
                (this._aBtn[_BUTTON_EMPLOY_HIGH] as ButtonBase).setDisable(true);
                this._mcBase.specialBtnMc.visible = false;
                this._mcBase.haveTicketMc.visible = false;
            }
            else
            {
                (this._aBtn[_BUTTON_EMPLOY_SPECIAL] as ButtonBase).setDisable(true);
                this._mcBase.warriorBtnMc.visible = false;
                this._mcBase.haveTicketMc.visible = true;
            }
            this._aProbabilityContentTable = param2;
            return;
        }// end function

        private function capacityNotEnohgh() : void
        {
            if (UserDataManager.getInstance().checkWarriorExtendable())
            {
                CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_COMFIRM_GOTO_TRADE), function (param1:Boolean) : void
            {
                if (param1)
                {
                    _bGoTradingPost = true;
                    setPhase(_PHASE_CLOSE);
                }
                else
                {
                    setPhase(_PHASE_INPUT_WAIT);
                }
                return;
            }// end function
            );
            }
            else
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_COMFIRM_NOT_GOTO_TRADE), function () : void
            {
                setPhase(_PHASE_INPUT_WAIT);
                return;
            }// end function
            );
            }
            this.setPhase(_PHASE_POPUP);
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBtn)
            {
                
                if (!param1 || _loc_2.id == _BUTTON_EMPLOY_HIGH && this._type != CommonConstant.EMPLOYMENT_TYPE_LIMITED || _loc_2.id == _BUTTON_EMPLOY_SPECIAL && this._type != CommonConstant.EMPLOYMENT_TYPE_SPECIAL)
                {
                    _loc_2.setDisable(true);
                    continue;
                }
                _loc_2.setDisable(!param1);
            }
            this._playerNumBox.setDisable(!param1);
            return;
        }// end function

        private function btnDisableFlag() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBtn)
            {
                
                _loc_1.setDisable(false);
                _loc_1.setDisableFlag(true);
            }
            this._playerNumBox.setDisable(false);
            this._playerNumBox.setDisableFlag(true);
            return;
        }// end function

        private function updateTicketNum() : void
        {
            this._numericTicketItem.setNum(UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_TICKET_GACHA_001));
            return;
        }// end function

        private function employmentSpecial() : void
        {
            this.setPhase(_PHASE_POPUP);
            var paymentItemInfo:* = ItemManager.getInstance().getPaymentItemInformation(PaymentItemId.ITEM_TICKET_GACHA_001);
            var confirmPopup:* = new EmploymentConfirmPopup(EmploymentConfirmPopup.COST_TYPE_SPECIAL_TICKET, TextControl.formatIdText(MessageId.EMPLOYMENT_SPECIAL_EMPLOY_MESSAGE, paymentItemInfo.name, this._EMPLOYMENT_SPECIAL_NUM, this._EMPLOYMENT_SPECIAL_NUM), this._EMPLOYMENT_SPECIAL_NUM, this._EMPLOYMENT_SPECIAL_NUM, false, function (param1:int) : void
            {
                switch(param1)
                {
                    case EmploymentConfirmPopup.RESULT_NONE:
                    {
                    }
                    default:
                    {
                        setPhase(_PHASE_INPUT_WAIT);
                        ;
                    }
                    case EmploymentConfirmPopup.RESULT_GOTO_TRADING_POST:
                    {
                        Main.GetProcess().createCrownUpdateWindow();
                        setPhase(_PHASE_INPUT_WAIT);
                        ;
                    }
                    case EmploymentConfirmPopup.RESULT_EMPLOYMENT:
                    {
                        _bGoTradingPost = true;
                        setPhase(_PHASE_CLOSE);
                        ;
                    }
                    case :
                    {
                        NetManager.getInstance().request(new NetTaskEmploymentSpecial(cbConnectEmployment));
                        setPhase(_PHASE_CONNECTING);
                        ;
                        ;
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function employmentLimited() : void
        {
            this.setPhase(_PHASE_POPUP);
            var confirmPopup:* = new EmploymentConfirmPopup(EmploymentConfirmPopup.COST_TYPE_CROWN, TextControl.formatIdText(MessageId.EMPLOYMENT_LIMITED_EMPLOY_MESSAGE, this._price, this._EMPLOYMENT_LIMITED_NUM), this._price, this._EMPLOYMENT_LIMITED_NUM, false, function (param1:int) : void
            {
                switch(param1)
                {
                    case EmploymentConfirmPopup.RESULT_NONE:
                    {
                    }
                    default:
                    {
                        setPhase(_PHASE_INPUT_WAIT);
                        ;
                    }
                    case EmploymentConfirmPopup.RESULT_GOTO_TRADING_POST:
                    {
                        Main.GetProcess().createCrownUpdateWindow();
                        setPhase(_PHASE_INPUT_WAIT);
                        ;
                    }
                    case EmploymentConfirmPopup.RESULT_EMPLOYMENT:
                    {
                        _bGoTradingPost = true;
                        setPhase(_PHASE_CLOSE);
                        ;
                    }
                    case :
                    {
                        NetManager.getInstance().request(new NetTaskEmploymentLimited(_price, cbConnectEmployment));
                        setPhase(_PHASE_CONNECTING);
                        ;
                        ;
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function cbReturnBtn(param1:int) : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbRetireButton(param1:int) : void
        {
            this._bGoRetire = true;
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbEmploymentBtn(param1:int) : void
        {
            if (param1 == _BUTTON_EMPLOY_SPECIAL)
            {
                this.employmentSpecial();
            }
            else if (param1 == _BUTTON_EMPLOY_HIGH && this._type == CommonConstant.EMPLOYMENT_TYPE_LIMITED)
            {
                this.employmentLimited();
            }
            return;
        }// end function

        private function cbConnectEmployment(param1:NetResult) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            super.checkConnectCommon(param1, this.expirationPopupWindowClose, this.updateCostDraw);
            if (bReset)
            {
                return;
            }
            this._employPlayerInfo = PlayerManager.getInstance().getPlayerInformation(aWinnerId[0]);
            this._aCandidatePlayerId = [];
            for each (_loc_3 in aWinnerId)
            {
                
                _loc_2 = PlayerManager.getInstance().getPlayerInformation(_loc_3);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_2.swf);
                ResourceManager.getInstance().loadResource(ResourcePath.CARD_BIG_PATH + CharacterConstant.ID_CARD + _loc_2.cardFileName);
                this._aCandidatePlayerId.push(_loc_3);
            }
            for each (_loc_4 in aOutId)
            {
                
                _loc_2 = PlayerManager.getInstance().getPlayerInformation(_loc_4);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_2.swf);
                this._aCandidatePlayerId.push(_loc_4);
            }
            this.setPhase(_PHASE_RESOURCE_LOADING);
            return;
        }// end function

        private function expirationPopupWindowClose() : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function updateCostDraw() : void
        {
            this.updateTicketNum();
            return;
        }// end function

        private function cbEmployAnimationOpen() : void
        {
            var _loc_1:* = Main.GetApplicationData().userConfigData;
            _loc_1.resetSummonSpeed();
            this._summonSpeed = 1;
            DebugLog.print("召喚演出スピードをリセット");
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        private function cbEmployAnimationRetry() : void
        {
            checkWarehouse(this._employAnimation.open);
            return;
        }// end function

        private function cbClosePopup() : void
        {
            this.setPhase(_PHASE_INPUT_WAIT);
            return;
        }// end function

    }
}
