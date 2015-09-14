package home
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import icon.*;
    import item.*;
    import layer.*;
    import message.*;
    import network.*;
    import player.*;
    import resource.*;
    import storage.*;
    import tutorial.*;
    import utility.*;

    public class CodeInput extends Object
    {
        private const _PHASE_RESOURCE_LOAD:int = 1;
        private const _PHASE_TUTORIAL:int = 2;
        private const _PHASE_OPEN:int = 20;
        private const _PHASE_INPUT_WAIT:int = 21;
        private const _PHASE_INPUT_SUCCESS:int = 30;
        private const _PHASE_ITEM_CHECK:int = 31;
        private const _PHASE_CLOSE:int = 99;
        private const _MODE_CODE:int = 0;
        private const _MODE_PASS:int = 1;
        private const _INPUT_RESTICT_CHARA:String = "a-zA-Z0-9";
        private var _layer:LayerHome;
        private var _baseMc:MovieClip;
        private var _naviCharaGra:Bitmap;
        private var _selecterMc:MovieClip;
        private var _isoBase:InStayOut;
        private var _isoInput:InStayOut;
        private var _isoInputSuccess:InStayOut;
        private var _isoInputFailure:InStayOut;
        private var _isoInputMessageBaloon:InStayOut;
        private var _isoSelecter:InStayOut;
        private var _inputTextField:TextField;
        private var _enterButton:ButtonBase;
        private var _backButton:ButtonBase;
        private var _confirmButton:ButtonBase;
        private var _nextButton:ButtonBase;
        private var _codeButton:ButtonBase;
        private var _passButton:ButtonBase;
        private var _selecterCloseButton:ButtonBase;
        private var _rarityIcon:PlayerRarityIcon;
        private var _phase:int;
        private var _inputMode:int;
        private var _modeText:String;
        private var _aGetItem:Array;
        private var _lastCode:String;
        private var _bEnd:Boolean;

        public function CodeInput(param1:LayerHome)
        {
            this._layer = param1;
            this._bEnd = false;
            this._inputMode = Constant.UNDECIDED;
            this._modeText = MessageManager.getInstance().getMessage(MessageId.CODE_INPUT_TEXT_CODE);
            this._lastCode = "";
            this.setPhase(this._PHASE_RESOURCE_LOAD);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        private function createInput() : void
        {
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Home.swf", "CodeInputSet");
            this._isoBase = new InStayOut(this._baseMc);
            this._layer.getLayer(LayerHome.MAIN).addChild(this._baseMc);
            this._enterButton = ButtonManager.getInstance().addButton(this._baseMc.codeInputMc.decisionBtnMc, this.cbEnterButton);
            this._enterButton.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._enterButton.setDisable(true);
            TextControl.setIdText(this._baseMc.codeInputMc.decisionBtnMc.textMc.textDt, MessageId.CODE_INPUT_BUTTON_INPUT);
            this._backButton = ButtonManager.getInstance().addButton(this._baseMc.codeInputMc.closeBtnMc, this.cbBackButton);
            this._backButton.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._backButton.setDisable(true);
            TextControl.setIdText(this._baseMc.codeInputMc.closeBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._confirmButton = ButtonManager.getInstance().addButton(this._baseMc.codeInput2Mc.closeBtnMc, this.cbConfirmButton);
            this._confirmButton.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._confirmButton.setDisable(true);
            TextControl.setIdText(this._baseMc.codeInput2Mc.closeBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CONFIRM);
            this._nextButton = ButtonManager.getInstance().addButton(this._baseMc.codeInput2Mc.nextBtnMc, this.cbConfirmButton);
            this._nextButton.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._nextButton.setDisable(true);
            TextControl.setIdText(this._baseMc.codeInput2Mc.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_NEXT);
            this._inputTextField = this._baseMc.codeInputMc.InputBoxMc.textMc.textDt;
            this._inputTextField.type = TextFieldType.DYNAMIC;
            this._inputTextField.selectable = true;
            this._inputTextField.embedFonts = false;
            this._inputTextField.text = "";
            this._inputTextField.multiline = false;
            this._inputTextField.addEventListener(KeyboardEvent.KEY_DOWN, this.cbKeyDown);
            this._inputTextField.addEventListener(Event.CHANGE, this.cbInputChange);
            TextControl.setText(this._baseMc.codeInput2Mc.balloon1Mc.TextMc.textDt, "");
            TextControl.setText(this._baseMc.codeInputMc.balloon3Mc.TextMc.textDt, "");
            TextControl.setIdText(this._baseMc.codeInputMc.balloon2Mc.TextMc.textDt, MessageId.CODE_INPUT_MESSAGE);
            TextControl.setText(this._baseMc.codeInputMc.NoteWindowMc.textMc.textDt, TextControl.formatIdText(MessageId.CODE_INPUT_NOTICE, this._modeText));
            this._isoInput = new InStayOut(this._baseMc.codeInputMc);
            this._isoInputSuccess = new InStayOut(this._baseMc.codeInput2Mc);
            this._isoInputFailure = new InStayOut(this._baseMc.codeInputMc.balloon3Mc);
            this._isoInputMessageBaloon = new InStayOut(this._baseMc.codeInputMc.balloon2Mc);
            this._naviCharaGra = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
            this._naviCharaGra.x = -this._naviCharaGra.width / 2;
            this._naviCharaGra.y = -this._naviCharaGra.height;
            this._baseMc.naviCharaNull.addChild(this._naviCharaGra);
            this._rarityIcon = new PlayerRarityIcon(this._baseMc.codeInput2Mc.balloon1Mc.charaNameSetMc.setCharaRankMc);
            return;
        }// end function

        public function release() : void
        {
            this.releaseSelecter();
            this.releaseInput();
            return;
        }// end function

        private function releaseSelecter() : void
        {
            if (this._codeButton)
            {
                ButtonManager.getInstance().removeButton(this._codeButton);
            }
            this._codeButton = null;
            if (this._passButton)
            {
                ButtonManager.getInstance().removeButton(this._passButton);
            }
            this._passButton = null;
            if (this._selecterCloseButton)
            {
                ButtonManager.getInstance().removeButton(this._selecterCloseButton);
            }
            this._selecterCloseButton = null;
            if (this._isoSelecter)
            {
                this._isoSelecter.release();
            }
            this._isoSelecter = null;
            if (this._selecterMc && this._selecterMc.parent)
            {
                this._selecterMc.parent.removeChild(this._selecterMc);
            }
            this._selecterMc = null;
            return;
        }// end function

        private function releaseInput() : void
        {
            if (this._inputTextField)
            {
                this._inputTextField.removeEventListener(KeyboardEvent.KEY_DOWN, this.cbKeyDown);
                this._inputTextField.removeEventListener(Event.CHANGE, this.cbInputChange);
            }
            if (this._isoBase)
            {
                this._isoBase.release();
            }
            if (this._isoInput)
            {
                this._isoInput.release();
            }
            if (this._isoInputFailure)
            {
                this._isoInputFailure.release();
            }
            if (this._isoInputSuccess)
            {
                this._isoInputSuccess.release();
            }
            if (this._isoInputMessageBaloon)
            {
                this._isoInputMessageBaloon.release();
            }
            if (this._enterButton)
            {
                ButtonManager.getInstance().removeButton(this._enterButton);
            }
            if (this._backButton)
            {
                ButtonManager.getInstance().removeButton(this._backButton);
            }
            if (this._confirmButton)
            {
                ButtonManager.getInstance().removeButton(this._confirmButton);
            }
            if (this._nextButton)
            {
                ButtonManager.getInstance().removeButton(this._nextButton);
            }
            if (this._naviCharaGra && this._naviCharaGra.parent)
            {
                this._naviCharaGra.parent.removeChild(this._naviCharaGra);
            }
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            return;
        }// end function

        public function control(param1:int) : void
        {
            switch(this._phase)
            {
                case this._PHASE_RESOURCE_LOAD:
                {
                    this.controlResourceLoad(param1);
                    break;
                }
                case this._PHASE_OPEN:
                {
                    this.controlOpen(param1);
                    break;
                }
                case this._PHASE_INPUT_WAIT:
                {
                    this.controlInputWait(param1);
                    break;
                }
                case this._PHASE_INPUT_SUCCESS:
                {
                    this.controlInputSuccess(param1);
                    break;
                }
                case this._PHASE_ITEM_CHECK:
                {
                    this.controlItemCheck(param1);
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose(param1);
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
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_RESOURCE_LOAD:
                    {
                        this.phaseResourceLoad();
                        break;
                    }
                    case this._PHASE_TUTORIAL:
                    {
                        this.phaseTutorial();
                        break;
                    }
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_INPUT_WAIT:
                    {
                        this.phaseInputWait();
                        break;
                    }
                    case this._PHASE_INPUT_SUCCESS:
                    {
                        this.phaseInputSuccess();
                        break;
                    }
                    case this._PHASE_ITEM_CHECK:
                    {
                        this.phaseItemCheck();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
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

        private function setDisableButton(param1:Boolean) : void
        {
            this._inputTextField.type = param1 || !this._isoInput.bOpened ? (TextFieldType.DYNAMIC) : (TextFieldType.INPUT);
            this._enterButton.setDisable(param1 || !this._isoInput.bOpened || this._inputTextField.length == 0);
            this._backButton.setDisable(param1 || !this._isoInput.bOpened);
            this._confirmButton.setDisable(param1 || !this._isoInputSuccess.bOpened || this._aGetItem.length > 0);
            this._nextButton.setDisable(param1 || !this._isoInputSuccess.bOpened || this._aGetItem.length == 0);
            return;
        }// end function

        private function phaseResourceLoad() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.NAVI_CHARACTER_PATH);
            return;
        }// end function

        private function controlResourceLoad(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_TUTORIAL);
            }
            return;
        }// end function

        private function phaseTutorial() : void
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MYPAGE_CODE_INPUT))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MYPAGE_CODE_INPUT, function () : void
            {
                setPhase(_PHASE_OPEN);
                return;
            }// end function
            );
            }
            else
            {
                this.setPhase(this._PHASE_OPEN);
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            this.createInput();
            this._inputTextField.maxChars = 16;
            this._inputTextField.restrict = this._INPUT_RESTICT_CHARA;
            TextControl.setIdText(this._baseMc.codeInputMc.balloon2Mc.TextMc.textDt, MessageId.CODE_INPUT_MESSAGE);
            this._baseMc.titleTextMc.gotoAndStop("CodeTitle");
            this._isoBase.setIn();
            this._isoInputMessageBaloon.setIn(this.cbMessageOpen);
            return;
        }// end function

        private function controlOpen(param1:Number) : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_INPUT_WAIT);
            }
            return;
        }// end function

        private function phaseInputWait() : void
        {
            if (this._isoInputMessageBaloon.bClosed)
            {
                this._isoInputMessageBaloon.setIn(this.cbMessageOpen);
            }
            else
            {
                this.cbMessageOpen();
            }
            return;
        }// end function

        private function controlInputWait(param1:Number) : void
        {
            return;
        }// end function

        private function phaseInputSuccess() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = new StorageItemData(this._aGetItem.shift());
            if (_loc_1.category == CommonConstant.ITEM_KIND_WARRIOR)
            {
                this._baseMc.codeInput2Mc.balloon1Mc.gotoAndStop(2);
                _loc_2 = PlayerManager.getInstance().getPlayerInformation(_loc_1.itemId);
                this._rarityIcon.setRarity(_loc_2.rarity);
                TextControl.setText(this._baseMc.codeInput2Mc.balloon1Mc.charaNameSetMc.textMc.textDt, _loc_2.name + " x " + _loc_1.num);
                TextControl.setText(this._baseMc.codeInput2Mc.balloon1Mc.TextMc.textDt, TextControl.formatIdText(MessageId.CODE_INPUT_SUCCESS, ""));
            }
            else
            {
                this._baseMc.codeInput2Mc.balloon1Mc.gotoAndStop(1);
                TextControl.setText(this._baseMc.codeInput2Mc.balloon1Mc.TextMc.textDt, TextControl.formatIdText(MessageId.CODE_INPUT_SUCCESS, ItemManager.getInstance().getItemName(_loc_1.category, _loc_1.itemId) + " x " + _loc_1.num));
            }
            this._isoInputSuccess.setIn(this.cbInputEnable);
            return;
        }// end function

        private function controlInputSuccess(param1:Number) : void
        {
            return;
        }// end function

        private function phaseItemCheck() : void
        {
            return;
        }// end function

        private function controlItemCheck(param1:Number) : void
        {
            if (this._aGetItem.length > 0)
            {
                this.setPhase(this._PHASE_INPUT_SUCCESS);
            }
            else
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this.setDisableButton(true);
            if (this._isoBase.bOpened)
            {
                this._isoBase.setOut();
            }
            if (this._isoInputFailure.bOpened)
            {
                this._isoInputFailure.setOut();
            }
            if (this._isoInputSuccess.bOpened)
            {
                this._isoInputSuccess.setOut();
            }
            if (this._isoInput.bOpened)
            {
                this._isoInput.setOut();
            }
            return;
        }// end function

        private function controlClose(param1:Number) : void
        {
            if (this._isoBase.bClosed && this._isoInput.bClosed)
            {
                this._bEnd = true;
            }
            return;
        }// end function

        private function cbKeyDown(event:KeyboardEvent) : void
        {
            if (this._inputTextField.type != TextFieldType.INPUT)
            {
                return;
            }
            if (event.keyCode == Keyboard.ENTER)
            {
                this.cbEnterButton(0);
            }
            return;
        }// end function

        private function cbInputChange(event:Event) : void
        {
            if (this._inputTextField.type != TextFieldType.INPUT)
            {
                return;
            }
            if (this._isoInputFailure.bOpened)
            {
                this._isoInputFailure.setOut();
            }
            if (this._isoInputMessageBaloon.bClosed)
            {
                this._isoInputMessageBaloon.setIn();
            }
            this.setDisableButton(false);
            return;
        }// end function

        private function cbEnterButton(param1:int) : void
        {
            var _loc_2:* = this._inputTextField.text;
            if (_loc_2 == "" || _loc_2 == this._lastCode)
            {
                return;
            }
            this._lastCode = _loc_2;
            if (this._isoInputMessageBaloon.bOpened)
            {
                this._isoInputMessageBaloon.setOut();
            }
            this.setDisableButton(true);
            if (_loc_2.length > 12)
            {
                this._inputMode = this._MODE_PASS;
            }
            else
            {
                this._inputMode = this._MODE_CODE;
            }
            NetManager.getInstance().request(new NetTaskCodeInput(_loc_2, this._inputMode, this.cbRecieve));
            return;
        }// end function

        private function setDummyInputFailure() : void
        {
            TextControl.setIdText(this._baseMc.codeInputMc.balloon3Mc.TextMc.textDt, MessageId.CODE_INPUT_FAILURE);
            this._isoInputFailure.setIn();
            this.setDisableButton(false);
            return;
        }// end function

        private function cbBackButton(param1:int) : void
        {
            this.setDisableButton(true);
            this.setPhase(this._PHASE_CLOSE);
            return;
        }// end function

        private function cbConfirmButton(param1:int) : void
        {
            this.setDisableButton(true);
            if (this._isoInputSuccess.bOpened)
            {
                this._isoInputSuccess.setOut();
            }
            this.setPhase(this._PHASE_ITEM_CHECK);
            return;
        }// end function

        private function cbRecieve(param1:NetResult) : void
        {
            switch(param1.resultCode)
            {
                case NetId.RESULT_OK:
                {
                    if (this._isoInput.bOpened)
                    {
                        this._isoInput.setOut();
                    }
                    this._aGetItem = param1.data.aGiftData;
                    this.setPhase(this._PHASE_INPUT_SUCCESS);
                    break;
                }
                case NetId.RESULT_ERROR_CODE_INPUT_INVALID_CODE:
                {
                    if (this._isoInputMessageBaloon.bOpened)
                    {
                        this._isoInputMessageBaloon.setOut();
                    }
                    TextControl.setText(this._baseMc.codeInputMc.balloon3Mc.TextMc.textDt, TextControl.formatIdText(MessageId.CODE_INPUT_FAILURE, this._modeText, this._modeText));
                    this._isoInputFailure.setIn();
                    this.setDisableButton(false);
                    break;
                }
                case NetId.RESULT_ERROR_CODE_INPUT_EXPIRED_CODE:
                {
                    if (this._isoInputMessageBaloon.bOpened)
                    {
                        this._isoInputMessageBaloon.setOut();
                    }
                    TextControl.setText(this._baseMc.codeInputMc.balloon3Mc.TextMc.textDt, TextControl.formatIdText(MessageId.CODE_INPUT_EXPIRED, this._modeText, this._modeText));
                    this._isoInputFailure.setIn();
                    this.setDisableButton(false);
                    break;
                }
                case NetId.RESULT_ERROR_CODE_INPUT_HAVE_GOTTEN_CODE:
                {
                    if (this._isoInputMessageBaloon.bOpened)
                    {
                        this._isoInputMessageBaloon.setOut();
                    }
                    TextControl.setText(this._baseMc.codeInputMc.balloon3Mc.TextMc.textDt, TextControl.formatIdText(MessageId.CODE_INPUT_HAVE_GOTTEN, this._modeText, this._modeText));
                    this._isoInputFailure.setIn();
                    this.setDisableButton(false);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function cbMessageOpen() : void
        {
            if (this._isoInput.bClosed)
            {
                this._isoInput.setIn(this.cbInputEnable);
            }
            return;
        }// end function

        private function cbInputEnable() : void
        {
            this.setDisableButton(false);
            return;
        }// end function

    }
}
