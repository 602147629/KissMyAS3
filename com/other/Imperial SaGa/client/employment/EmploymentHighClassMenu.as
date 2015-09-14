package employment
{
    import button.*;
    import character.*;
    import flash.display.*;
    import layer.*;
    import message.*;
    import network.*;
    import player.*;
    import resource.*;
    import sound.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class EmploymentHighClassMenu extends EmploymentMenuBase
    {
        private const _EMPLOYMENT_ONE_NUM:int = 1;
        private const _EMPLOYMENT_BOX_NUM:int = 11;
        private var _phase:int;
        private var _layer:LayerEmployment;
        private var _type:int;
        private var _mcMenu1:MovieClip;
        private var _mcMenu2:MovieClip;
        private var _mcAnim:MovieClip;
        private var _isoMenu1:InStayOut;
        private var _isoMenu2:InStayOut;
        private var _isoAnim:InStayOut;
        private var _isoFirstPop:InStayOut;
        private var _isoFixPop:InStayOut;
        private var _mcFixPop:MovieClip;
        private var _aBtn:Array;
        private var _playerNumBox:EmploymentPlayerNumBox;
        private var _cbClose:Function;
        private var _employAnimation:EmploymentHighClassAnimation;
        private var _boxAnimation:EmploymentHighClassBoxAnimation;
        private var _probabilityListPopup:EmploymentProbabilityListWindow;
        private var _price:int;
        private var _boxPrice:int;
        private var _bBoxFirstBonus:Boolean;
        private var _aProbabilityContentTable:Array;
        private var _aFirstProbabilityContentTable:Array;
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
        private static const _BUTTON_EMPLOY_1:int = 1;
        private static const _BUTTON_EMPLOY_11:int = 2;
        private static const _BUTTON_PROBABILITY_LIST:int = 3;

        public function EmploymentHighClassMenu(param1:LayerEmployment, param2:int, param3:int, param4:int, param5:Boolean, param6:Array, param7:Array, param8:Function, param9:EmploymentLimitedData = null)
        {
            var _loc_11:* = null;
            var _loc_12:* = false;
            var _loc_13:* = null;
            this._summonSpeed = 1;
            this._layer = param1;
            this._price = param3;
            this._boxPrice = param4;
            this._bBoxFirstBonus = param5;
            this._type = Constant.UNDECIDED;
            this.setEmploymentType(param2, param6, param7);
            this._cbClose = param8;
            this._employAnimation = null;
            this._boxAnimation = null;
            this._probabilityListPopup = null;
            this._limitedData = param9;
            this._bGoTradingPost = false;
            this._bGoRetire = false;
            this._mcMenu1 = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonProduction.swf", "summonBtnMc");
            this._mcAnim = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonProduction.swf", "summonHGFlatSet");
            this._mcMenu2 = this._mcAnim.btnMenuMc;
            this._isoMenu1 = new InStayOut(this._mcMenu1);
            this._isoMenu2 = new InStayOut(this._mcMenu2);
            this._isoAnim = new InStayOut(this._mcAnim);
            this._isoFirstPop = new InStayOut(this._mcMenu2.infoScrollMc);
            this._isoFixPop = null;
            this._mcFixPop = null;
            this._layer.getLayer(LayerEmployment.MAIN).addChild(this._mcMenu1);
            this._layer.getLayer(LayerEmployment.ANIMATION).addChild(this._mcAnim);
            var _loc_10:* = [{mc:this._mcMenu1.returnBtnMc, cbFunc:this.cbReturnBtn, id:_BUTTON_RETURN, soundId:ButtonBase.SE_CANCEL_ID}, {mc:this._mcMenu2.call1BtnMc, cbFunc:this.cbEmploymentOneBtn, id:_BUTTON_EMPLOY_1, soundId:SoundId.SE_DECIDE}, {mc:this._mcMenu2.call11BtnMc, cbFunc:this.cbEmploymentBoxBtn, id:_BUTTON_EMPLOY_11, soundId:SoundId.SE_DECIDE}, {mc:this._mcMenu1.itiranBtnMc, cbFunc:this.cbProbabilityListBtn, id:_BUTTON_PROBABILITY_LIST, soundId:ButtonBase.SE_DECIDE_ID}];
            this._aBtn = [];
            for each (_loc_11 in _loc_10)
            {
                
                _loc_13 = ButtonManager.getInstance().addButton(_loc_11.mc, _loc_11.cbFunc, _loc_11.id);
                _loc_13.enterSeId = _loc_11.soundId;
                this._aBtn.push(_loc_13);
            }
            this._playerNumBox = new EmploymentPlayerNumBox(this._mcMenu1.VassalNumMc, this.cbRetireButton);
            TextControl.setIdText(this._mcMenu1.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            TextControl.setIdText(this._mcMenu1.itiranBtnMc.textMc.textDt, MessageId.EMPLOYMENT_PROBABILITY_LIST_BUTTON);
            TextControl.setIdText(this._mcMenu2.call1BtnMc.textMc.textDt, MessageId.EMPLOYMENT_HIGH_EMPLOY_BUTTON);
            TextControl.setIdText(this._mcMenu2.call11BtnMc.textMc.textDt, MessageId.EMPLOYMENT_HIGH_EMPLOY_BUTTON);
            TextControl.setText(this._mcMenu2.call1BtnMc.NumTextMc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_HIGH_EMPLOY_COUNT, this._EMPLOYMENT_ONE_NUM));
            TextControl.setText(this._mcMenu2.call11BtnMc.NumTextMc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_HIGH_EMPLOY_COUNT, this._EMPLOYMENT_BOX_NUM));
            TextControl.setText(this._mcMenu2.infoScrollMc.textMc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_HIGH_EMPLOY_FIRST_PROBABILITY_UP, PlayerManager.getInstance().getRarityText(CommonConstant.CHARACTER_RARITY_SUPERRARE)));
            _loc_12 = this._type == CommonConstant.EMPLOYMENT_TYPE_HIGH && TutorialManager.getInstance().isUseTutorialProtocol();
            TextControl.setText(this._mcMenu2.call1BtnMc.PriceMc.textDt, _loc_12 ? ("0") : (this._price.toString()));
            TextControl.setText(this._mcMenu2.call11BtnMc.PriceMc.textDt, this._boxPrice.toString());
            this._mcMenu1.haveTicketMc.visible = false;
            this._mcMenu1.warriorBtnMc.visible = false;
            this._mcMenu1.specialBtnMc.visible = false;
            this._mcAnim.startLine.visible = false;
            this._mcAnim.diorama_iwa.visible = false;
            this._mcAnim.diorama_set1.visible = false;
            this._mcAnim.diorama_set2.visible = false;
            this._mcAnim.diorama_set3.visible = false;
            this._mcAnim.summonHGFlat1Mc.visible = false;
            this._mcAnim.summonHGFlat11Mc.visible = false;
            this.setPhase(_PHASE_INIT);
            return;
        }// end function

        public function get bBoxFirstBonus() : Boolean
        {
            return this._bBoxFirstBonus;
        }// end function

        public function isFirstEmployed() : Boolean
        {
            return this._aFirstProbabilityContentTable == null;
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
            return this._phase == _PHASE_INPUT_WAIT;
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
            if (this._boxAnimation)
            {
                this._boxAnimation.release();
            }
            this._boxAnimation = null;
            if (this._probabilityListPopup)
            {
                this._probabilityListPopup.release();
            }
            this._probabilityListPopup = null;
            if (this._isoMenu1)
            {
                this._isoMenu1.release();
            }
            this._isoMenu1 = null;
            if (this._isoMenu2)
            {
                this._isoMenu2.release();
            }
            this._isoMenu2 = null;
            if (this._isoAnim)
            {
                this._isoAnim.release();
            }
            this._isoAnim = null;
            if (this._isoFirstPop)
            {
                this._isoFirstPop.release();
            }
            this._isoFirstPop = null;
            if (this._isoFixPop)
            {
                this._isoFixPop.release();
            }
            this._isoFixPop = null;
            this._mcFixPop = null;
            if (this._mcMenu1 && this._mcMenu1.parent)
            {
                this._mcMenu1.parent.removeChild(this._mcMenu1);
            }
            this._mcMenu1 = null;
            if (this._mcAnim && this._mcAnim.parent)
            {
                this._mcAnim.parent.removeChild(this._mcAnim);
            }
            this._mcAnim = null;
            this._mcMenu2 = null;
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
            if (this._probabilityListPopup)
            {
                this._probabilityListPopup.control(param1);
            }
            param1 = param1 * this._summonSpeed;
            switch(this._phase)
            {
                case _PHASE_RESOURCE_LOADING:
                {
                    this.controlPhaseResourceLoading();
                    break;
                }
                case _PHASE_ANIMATION:
                {
                    this.controlPhaseAnimation(param1);
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
            return;
        }// end function

        private function initPhaseInit() : void
        {
            this.btnDisableFlag();
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            var func:Function;
            var configData:* = Main.GetApplicationData().userConfigData;
            configData.resetSummonSpeed();
            this._summonSpeed = 1;
            this.btnDisableFlag();
            this._playerNumBox.updatePlayerNum();
            this.setupFixPop();
            func = function () : void
            {
                if (_isoMenu1.bOpened && _isoMenu2.bOpened)
                {
                    setPhase(_PHASE_INPUT_WAIT);
                }
                return;
            }// end function
            ;
            this._isoAnim.setIn(function () : void
            {
                _isoMenu1.setIn(func);
                _isoMenu2.setIn(func);
                return;
            }// end function
            );
            this._mcAnim.startLine.visible = true;
            this._mcAnim.diorama_iwa.visible = true;
            this._mcAnim.diorama_set1.visible = true;
            this._mcAnim.diorama_set2.visible = true;
            this._mcAnim.summonHGFlat1Mc.visible = false;
            this._mcAnim.summonHGFlat11Mc.visible = false;
            return;
        }// end function

        private function initPhaseInputWait() : void
        {
            this.btnEnable(true);
            if (this._aFirstProbabilityContentTable && !this._isoFirstPop.bOpened)
            {
                this._isoFirstPop.setIn();
            }
            if (!this._isoFixPop.bOpened)
            {
                this._isoFixPop.setIn();
            }
            if (this._type == CommonConstant.EMPLOYMENT_TYPE_HIGH && TutorialManager.getInstance().isTutorial())
            {
                ButtonManager.getInstance().unseal();
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_EMPLOY_2))
                {
                    ButtonManager.getInstance().seal([this._aBtn[_BUTTON_EMPLOY_1]], true);
                    TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_EMPLOY_2, function () : void
            {
                TutorialManager.getInstance().setTutorialArrow((_aBtn[_BUTTON_EMPLOY_1] as ButtonBase).getMoveClip());
                TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_EMPLOYMENT_002), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                return;
            }// end function
            );
                }
                else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_EMPLOY_3))
                {
                    ButtonManager.getInstance().seal([this._aBtn[_BUTTON_RETURN]], true);
                    TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_EMPLOY_3, function () : void
            {
                TutorialManager.getInstance().setTutorialArrow((_aBtn[_BUTTON_RETURN] as ButtonBase).getMoveClip());
                TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_EMPLOYMENT_003), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                return;
            }// end function
            );
                }
            }
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
            this._isoMenu1.setOut();
            this._isoMenu2.setOut();
            if (!this._isoFirstPop.bClosed)
            {
                this._isoFirstPop.setOut();
            }
            if (!this._isoFixPop.bClosed)
            {
                this._isoFixPop.setOut();
            }
            return;
        }// end function

        private function controlPhaseResourceLoading() : void
        {
            if (this._isoMenu1.bClosed && this._isoMenu2.bClosed && ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(_PHASE_ANIMATION);
            }
            return;
        }// end function

        private function initPhaseAnimation() : void
        {
            var _loc_1:* = Main.GetApplicationData().userConfigData;
            this._summonSpeed = _loc_1.setSummonSpeed();
            this.btnEnable(false);
            if (this._employAnimation)
            {
                this._employAnimation.playAnimation();
            }
            else if (this._boxAnimation)
            {
                this._boxAnimation.playAnimation();
            }
            this._mcAnim.startLine.visible = false;
            this._mcAnim.diorama_iwa.visible = false;
            this._mcAnim.diorama_set1.visible = false;
            this._mcAnim.diorama_set2.visible = false;
            return;
        }// end function

        private function controlPhaseAnimation(param1:Number) : void
        {
            var t:* = param1;
            if (this._employAnimation)
            {
                this._employAnimation.control(t);
                if (this._employAnimation.bEnd)
                {
                    this._employAnimation.release();
                    this._employAnimation = null;
                    checkWarehouse(function () : void
            {
                setPhase(_PHASE_OPEN);
                return;
            }// end function
            );
                }
            }
            else if (this._boxAnimation)
            {
                this._boxAnimation.control(t);
                if (this._boxAnimation.bEnd)
                {
                    this._boxAnimation.release();
                    this._boxAnimation = null;
                    checkWarehouse(function () : void
            {
                setPhase(_PHASE_OPEN);
                return;
            }// end function
            );
                }
            }
            return;
        }// end function

        private function initPhasePopup() : void
        {
            this.btnDisableFlag();
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this.btnDisableFlag();
            var func:* = function () : void
            {
                if (_isoMenu1.bClosed && _isoMenu2.bClosed && _isoAnim.bClosed)
                {
                    _cbClose();
                }
                return;
            }// end function
            ;
            this._isoMenu1.setOut(func);
            this._isoMenu2.setOut(func);
            this._isoAnim.setOut(func);
            if (!this._isoFirstPop.bClosed)
            {
                this._isoFirstPop.setOut();
            }
            if (!this._isoFixPop.bClosed)
            {
                this._isoFixPop.setOut();
            }
            if (this._type == CommonConstant.EMPLOYMENT_TYPE_HIGH && TutorialManager.getInstance().isTutorial())
            {
                ButtonManager.getInstance().unseal();
            }
            return;
        }// end function

        private function initPhaseCrownUpdate() : void
        {
            this.btnEnable(false);
            return;
        }// end function

        private function controlPhaseCrownUpdate(param1:Number) : void
        {
            if (!Main.GetProcess().isCrownUpdateing())
            {
                this.setPhase(_PHASE_INPUT_WAIT);
            }
            return;
        }// end function

        private function setEmploymentType(param1:int, param2:Array, param3:Array) : void
        {
            if (this._type == param1)
            {
                return;
            }
            this._type = param1;
            this._aProbabilityContentTable = param2;
            this._aFirstProbabilityContentTable = param3;
            return;
        }// end function

        private function setupFixPop() : void
        {
            if (this._bBoxFirstBonus)
            {
                if (this._mcFixPop == this._mcMenu2.scroll01)
                {
                    return;
                }
                if (this._isoFixPop)
                {
                    this._isoFixPop.release();
                }
                this._isoFixPop = null;
                this._mcFixPop = null;
                this._mcMenu2.scroll00.visible = false;
                this._mcMenu2.scroll01.visible = true;
                this._isoFixPop = new InStayOut(this._mcMenu2.scroll01);
                TextControl.setText(this._mcMenu2.scroll01.textMc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_HIGH_EMPLOY_MUST_UR, PlayerManager.getInstance().getRarityText(CommonConstant.CHARACTER_RARITY_ULTLARARE)));
            }
            else
            {
                if (this._mcFixPop == this._mcMenu2.scroll00)
                {
                    return;
                }
                if (this._isoFixPop)
                {
                    this._isoFixPop.release();
                }
                this._isoFixPop = null;
                this._mcFixPop = null;
                this._mcMenu2.scroll00.visible = true;
                this._mcMenu2.scroll01.visible = false;
                this._isoFixPop = new InStayOut(this._mcMenu2.scroll00);
                TextControl.setText(this._mcMenu2.scroll00.textMc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_HIGH_EMPLOY_MUST_SR, PlayerManager.getInstance().getRarityText(CommonConstant.CHARACTER_RARITY_SUPERRARE)));
            }
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBtn)
            {
                
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

        private function employmentOne_HighClass() : void
        {
            var bTutorial:Boolean;
            this.setPhase(_PHASE_POPUP);
            bTutorial = TutorialManager.getInstance().isTutorial();
            var confirmPopup:* = new EmploymentConfirmPopup(EmploymentConfirmPopup.COST_TYPE_CROWN, TextControl.formatIdText(MessageId.EMPLOYMENT_HIGH_EMPLOY_MESSAGE, this._price, this._EMPLOYMENT_ONE_NUM), this._price, this._EMPLOYMENT_ONE_NUM, bTutorial, function (param1:int) : void
            {
                var _loc_2:* = undefined;
                switch(param1)
                {
                    case EmploymentConfirmPopup.RESULT_NONE:
                    {
                    }
                    default:
                    {
                        setPhase(_PHASE_INPUT_WAIT);
                        break;
                    }
                    case EmploymentConfirmPopup.RESULT_GOTO_TRADING_POST:
                    {
                        Main.GetProcess().createCrownUpdateWindow();
                        setPhase(_PHASE_INPUT_WAIT);
                        break;
                    }
                    case EmploymentConfirmPopup.RESULT_EMPLOYMENT:
                    {
                        _bGoTradingPost = true;
                        setPhase(_PHASE_CLOSE);
                        break;
                    }
                    case :
                    {
                        _loc_2 = bTutorial ? (0) : (_price);
                        NetManager.getInstance().request(new NetTaskEmploymentHigh(_loc_2, cbConnectEmployment));
                        setPhase(_PHASE_CONNECTING);
                        break;
                        break;
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function employmentBox_HighClass() : void
        {
            this.setPhase(_PHASE_POPUP);
            var confirmPopup:* = new EmploymentConfirmPopup(EmploymentConfirmPopup.COST_TYPE_CROWN, TextControl.formatIdText(MessageId.EMPLOYMENT_HIGH_EMPLOY_MESSAGE, this._boxPrice, this._EMPLOYMENT_BOX_NUM), this._boxPrice, this._EMPLOYMENT_BOX_NUM, false, function (param1:int) : void
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
                        NetManager.getInstance().request(new NetTaskEmploymentHighBox(_boxPrice, cbConnectEmploymentBox));
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

        private function employmentOne_Limited() : void
        {
            this.setPhase(_PHASE_POPUP);
            var confirmPopup:* = new EmploymentConfirmPopup(EmploymentConfirmPopup.COST_TYPE_CROWN, TextControl.formatIdText(MessageId.EMPLOYMENT_LIMITED_EMPLOY_MESSAGE, this._price, this._EMPLOYMENT_ONE_NUM), this._price, this._EMPLOYMENT_ONE_NUM, false, function (param1:int) : void
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

        private function employmentBox_Limited() : void
        {
            this.setPhase(_PHASE_POPUP);
            var confirmPopup:* = new EmploymentConfirmPopup(EmploymentConfirmPopup.COST_TYPE_CROWN, TextControl.formatIdText(MessageId.EMPLOYMENT_LIMITED_EMPLOY_MESSAGE, this._boxPrice, this._EMPLOYMENT_BOX_NUM), this._boxPrice, this._EMPLOYMENT_BOX_NUM, false, function (param1:int) : void
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
                        NetManager.getInstance().request(new NetTaskEmploymentLimitedBox(_boxPrice, cbConnectEmploymentBox));
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
            TutorialManager.getInstance().hideTutorial();
            return;
        }// end function

        private function cbRetireButton(param1:int) : void
        {
            this._bGoRetire = true;
            this.cbReturnBtn(param1);
            return;
        }// end function

        private function cbProbabilityListBtn(param1:int) : void
        {
            var _loc_2:* = EmploymentProbabilityListWindow.checkProbabilityUpRarity(this._aFirstProbabilityContentTable, this._aProbabilityContentTable);
            var _loc_3:* = _loc_2 <= 0 ? (EmploymentProbabilityListWindow.TYPE_TWIN) : (EmploymentProbabilityListWindow.TYPE_TWIN_FIRST);
            if (this._probabilityListPopup == null)
            {
                this._probabilityListPopup = new EmploymentProbabilityListWindow(this._layer.getLayer(LayerEmployment.MAIN), this.cbClosePopup, _loc_3);
            }
            else if (this._probabilityListPopup.type != _loc_3)
            {
                this._probabilityListPopup.release();
                this._probabilityListPopup = new EmploymentProbabilityListWindow(this._layer.getLayer(LayerEmployment.MAIN), this.cbClosePopup, _loc_3);
            }
            this._probabilityListPopup.updateProbabilityList(this._aFirstProbabilityContentTable ? (this._aFirstProbabilityContentTable) : (this._aProbabilityContentTable), false, _loc_2);
            this._probabilityListPopup.updateProbabilityList(this._aProbabilityContentTable, true);
            this._probabilityListPopup.open();
            this.setPhase(_PHASE_POPUP);
            return;
        }// end function

        private function cbEmploymentOneBtn(param1:int) : void
        {
            if (this._type == CommonConstant.EMPLOYMENT_TYPE_LIMITED)
            {
                this.employmentOne_Limited();
            }
            else
            {
                this.employmentOne_HighClass();
            }
            TutorialManager.getInstance().hideTutorial();
            return;
        }// end function

        private function cbEmploymentBoxBtn(param1:int) : void
        {
            if (this._type == CommonConstant.EMPLOYMENT_TYPE_LIMITED)
            {
                this.employmentBox_Limited();
            }
            else
            {
                this.employmentBox_HighClass();
            }
            return;
        }// end function

        private function cbConnectEmployment(param1:NetResult) : void
        {
            var pInfo:PlayerInformation;
            var winnerId:int;
            var outId:int;
            var res:* = param1;
            checkConnectCommon(res, function () : void
            {
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            , null);
            if (bReset)
            {
                return;
            }
            TextControl.setText(this._mcMenu2.call1BtnMc.PriceMc.textDt, this._price.toString());
            var employPlayerInfo:* = PlayerManager.getInstance().getPlayerInformation(aWinnerId[0]);
            var aCandidatePlayerId:Array;
            var _loc_3:* = 0;
            var _loc_4:* = aWinnerId;
            while (_loc_4 in _loc_3)
            {
                
                winnerId = _loc_4[_loc_3];
                pInfo = PlayerManager.getInstance().getPlayerInformation(winnerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + pInfo.swf);
                ResourceManager.getInstance().loadResource(ResourcePath.CARD_BIG_PATH + CharacterConstant.ID_CARD + pInfo.cardFileName);
                aCandidatePlayerId.push(winnerId);
            }
            var _loc_3:* = 0;
            var _loc_4:* = aOutId;
            while (_loc_4 in _loc_3)
            {
                
                outId = _loc_4[_loc_3];
                pInfo = PlayerManager.getInstance().getPlayerInformation(outId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + pInfo.swf);
                aCandidatePlayerId.push(outId);
            }
            if (this._employAnimation == null)
            {
                this._employAnimation = new EmploymentHighClassAnimation(this._mcAnim.summonHGFlat1Mc);
            }
            this._employAnimation.setRunnerId(employPlayerInfo, aCandidatePlayerId);
            this._aFirstProbabilityContentTable = null;
            this.setPhase(_PHASE_RESOURCE_LOADING);
            return;
        }// end function

        private function cbConnectEmploymentBox(param1:NetResult) : void
        {
            var pInfo:PlayerInformation;
            var winnerId:int;
            var outId:int;
            var res:* = param1;
            this._bBoxFirstBonus = false;
            checkConnectCommon(res, function () : void
            {
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            , null);
            if (bReset)
            {
                return;
            }
            var aCandidatePlayerId:Array;
            var _loc_3:* = 0;
            var _loc_4:* = aWinnerId;
            while (_loc_4 in _loc_3)
            {
                
                winnerId = _loc_4[_loc_3];
                pInfo = PlayerManager.getInstance().getPlayerInformation(winnerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + pInfo.swf);
                ResourceManager.getInstance().loadResource(ResourcePath.CARD_SMALL_PATH + CharacterConstant.ID_CARD + pInfo.cardFileName);
                aCandidatePlayerId.push(winnerId);
            }
            var _loc_3:* = 0;
            var _loc_4:* = aOutId;
            while (_loc_4 in _loc_3)
            {
                
                outId = _loc_4[_loc_3];
                pInfo = PlayerManager.getInstance().getPlayerInformation(outId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + pInfo.swf);
                aCandidatePlayerId.push(outId);
            }
            if (this._boxAnimation == null)
            {
                this._boxAnimation = new EmploymentHighClassBoxAnimation(this._mcAnim.summonHGFlat11Mc);
            }
            this._boxAnimation.setRunnerId(aWinnerId, aOutId);
            this.setPhase(_PHASE_RESOURCE_LOADING);
            return;
        }// end function

        private function cbClosePopup() : void
        {
            this.setPhase(_PHASE_INPUT_WAIT);
            return;
        }// end function

    }
}
