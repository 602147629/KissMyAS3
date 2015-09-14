package nameEntry
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import input.*;
    import message.*;
    import network.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import user.*;
    import utility.*;

    public class NameEntry extends Object
    {
        private var _phase:int;
        private const _PHASE_RESOURCE_LOAD:int = 1;
        private const _PHASE_NAME_ENTRY_OPEN:int = 20;
        private const _PHASE_NAME_ENTRY_WAIT:int = 21;
        private const _PHASE_NAME_ENTRY_CONFIRM:int = 22;
        private const _PHASE_CONNECTING:int = 30;
        private const _PHASE_WAIT:int = 31;
        private const _PHASE_SET_CLOSE:int = 110;
        private const _PHASE_CLOSED:int = 111;
        private var _parent:DisplayObjectContainer;
        private var _mcBase:MovieClip;
        private var _backScreen:ColorScreen;
        private var _isoMain:InStayOut;
        private var _isoBard:InStayOut;
        private var _isoBalloon1:InStayOut;
        private var _isoBalloon2:InStayOut;
        private var _isoBalloon3:InStayOut;
        private var _btnDecide:ButtonBase;
        private var _btnTitleReturn:ButtonBase;
        private var _btnYes:ButtonBase;
        private var _btnNo:ButtonBase;
        private var _fade:Fade;
        private var _inputName:String;
        private var _bNameEntryCompleted:Boolean;
        private var _len:int;
        private var _inputTextField:TextField;
        private var _cbNameEntry:Function;
        private var _cbReturn:Function;
        private static const _RESOURCE_PATH:String = ResourcePath.LOGIN_PATH + "UI_Login.swf";

        public function NameEntry(param1:DisplayObjectContainer, param2:Function, param3:Function)
        {
            this._parent = param1;
            this._cbNameEntry = param2;
            this._cbReturn = param3;
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == this._PHASE_CLOSED && (this._isoMain && this._isoMain.bClosed);
        }// end function

        private function resourceLoaded() : void
        {
            if (this._backScreen == null)
            {
                this._backScreen = new ColorScreen(this._parent);
            }
            this._mcBase = ResourceManager.getInstance().createMovieClip(_RESOURCE_PATH, "nameEntryPopup");
            this._parent.addChild(this._mcBase);
            this._isoMain = new InStayOut(this._mcBase);
            this._isoBard = new InStayOut(this._mcBase.nabiCharaInOutMc);
            this._isoBalloon1 = new InStayOut(this._mcBase.NaviBalloon1Mc);
            this._isoBalloon2 = new InStayOut(this._mcBase.NaviBalloon2Mc);
            this._isoBalloon3 = new InStayOut(this._mcBase.NaviBalloon3Mc);
            this._btnDecide = ButtonManager.getInstance().addButton(this._mcBase.NaviBalloon1Mc.decisionBtnMc, this.cbBtnDecide);
            this._btnDecide.setDisable(true);
            this._btnDecide.setDisableFlag(true);
            this._btnDecide.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcBase.NaviBalloon1Mc.decisionBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_DECIDE);
            this._btnTitleReturn = ButtonManager.getInstance().addButton(this._mcBase.NaviBalloon1Mc.returnBtnMc, this.cbBtnTitleReturn);
            this._btnTitleReturn.setDisable(true);
            this._btnTitleReturn.setDisableFlag(true);
            this._btnTitleReturn.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcBase.NaviBalloon1Mc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._btnYes = ButtonManager.getInstance().addButton(this._mcBase.NaviBalloon2Mc.decisionBtnMc, this.cbBtnYes);
            this._btnYes.setDisableFlag(true);
            this._btnYes.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcBase.NaviBalloon2Mc.decisionBtnMc.textMc.textDt, MessageId.OPENING_NAME_ENTRY_CONFIRM_BUTTON_YES);
            this._btnNo = ButtonManager.getInstance().addButton(this._mcBase.NaviBalloon2Mc.returnBtnMc, this.cbBtnNo);
            this._btnNo.setDisableFlag(true);
            this._btnNo.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcBase.NaviBalloon2Mc.returnBtnMc.textMc.textDt, MessageId.OPENING_NAME_ENTRY_CONFIRM_BUTTON_RETURN);
            this._fade = new Fade(this._parent);
            this._fade.setFadeIn(0);
            this._inputName = UserDataManager.getInstance().userData.name;
            this._bNameEntryCompleted = false;
            this._inputTextField = this._mcBase.NaviBalloon1Mc.nameInputBoxMc.textMc.textDt as TextField;
            this._inputTextField.type = TextFieldType.INPUT;
            this._inputTextField.selectable = true;
            this._inputTextField.embedFonts = false;
            this._inputTextField.text = this._inputName;
            this._inputTextField.maxChars = 10;
            this._inputTextField.multiline = false;
            this._inputTextField.addEventListener(KeyboardEvent.KEY_DOWN, this.cbKeyDown);
            TextControl.setText(this._mcBase.NaviBalloon2Mc.balloonMc.nameTextMc.textDt, "");
            TextControl.setIdText(this._mcBase.NaviBalloon1Mc.balloonMc.TextMc.textDt, MessageId.OPENING_NAME_ENTRY_MESSAGE_001);
            TextControl.setIdText(this._mcBase.NaviBalloon1Mc.NoteWindowMc.textMc.textDt, MessageId.OPENING_NAME_ENTRY_MESSAGE_002);
            TextControl.setIdText(this._mcBase.NaviBalloon2Mc.balloonMc.TextMc.textDt, MessageId.OPENING_NAME_ENTRY_MESSAGE_003);
            TextControl.setIdText(this._mcBase.NaviBalloon3Mc.balloonMc.TextMc.textDt, MessageId.OPENING_NAME_ENTRY_MESSAGE_004);
            return;
        }// end function

        public function release() : void
        {
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._isoBard)
            {
                this._isoBard.release();
            }
            this._isoBard = null;
            if (this._isoBalloon1)
            {
                this._isoBalloon1.release();
            }
            this._isoBalloon1 = null;
            if (this._isoBalloon2)
            {
                this._isoBalloon2.release();
            }
            this._isoBalloon2 = null;
            if (this._isoBalloon3)
            {
                this._isoBalloon3.release();
            }
            this._isoBalloon3 = null;
            if (this._inputTextField)
            {
                this._inputTextField.removeEventListener(KeyboardEvent.KEY_DOWN, this.cbKeyDown);
            }
            ButtonManager.getInstance().removeButton(this._btnDecide);
            this._btnDecide = null;
            ButtonManager.getInstance().removeButton(this._btnTitleReturn);
            this._btnTitleReturn = null;
            ButtonManager.getInstance().removeButton(this._btnYes);
            this._btnYes = null;
            ButtonManager.getInstance().removeButton(this._btnNo);
            this._btnNo = null;
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            InputManager.getInstance().delMouseCallback(this);
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            if (this._backScreen)
            {
                this._backScreen.release();
            }
            this._backScreen = null;
            this._cbNameEntry = null;
            this._cbReturn = null;
            this._parent = null;
            return;
        }// end function

        public function setIn() : void
        {
            this.setPhase(this._PHASE_RESOURCE_LOAD);
            return;
        }// end function

        public function setOut() : void
        {
            if (this._btnYes)
            {
                this._btnYes.setDisableFlag(true);
            }
            if (this._btnNo)
            {
                this._btnNo.setDisableFlag(true);
            }
            this.setPhase(this._PHASE_SET_CLOSE);
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_RESOURCE_LOAD:
                {
                    this.phaseResourceLoad();
                    break;
                }
                case this._PHASE_NAME_ENTRY_OPEN:
                {
                    this.phaseNameEntyrOpen();
                    break;
                }
                case this._PHASE_NAME_ENTRY_WAIT:
                {
                    this.phaseNameEntyrWait();
                    break;
                }
                case this._PHASE_NAME_ENTRY_CONFIRM:
                {
                    this.phaseNameEntyrConfirm();
                    break;
                }
                case this._PHASE_CONNECTING:
                {
                    this.phaseConnecting();
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.phaseWait();
                    break;
                }
                case this._PHASE_SET_CLOSE:
                {
                    this.phaseSetClose();
                    break;
                }
                case this._PHASE_CLOSED:
                {
                    this.phaseClosed();
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
            switch(this._phase)
            {
                case this._PHASE_RESOURCE_LOAD:
                {
                    this.controlResourceLoad();
                    break;
                }
                case this._PHASE_NAME_ENTRY_WAIT:
                {
                    this.controlNameEntryWait(param1);
                    break;
                }
                case this._PHASE_CONNECTING:
                {
                    this.controlConnecting(param1);
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait();
                    break;
                }
                case this._PHASE_SET_CLOSE:
                {
                    this.controlSetClose(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._fade)
            {
                this._fade.control(param1);
            }
            return;
        }// end function

        private function phaseResourceLoad() : void
        {
            ResourceManager.getInstance().loadResource(_RESOURCE_PATH);
            CommonPopup.getInstance().loadResource();
            SoundManager.getInstance().loadSound(SoundId.BGM_INS_RESEARCH);
            return;
        }// end function

        private function controlResourceLoad() : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.resourceLoaded();
                this.setPhase(this._PHASE_NAME_ENTRY_OPEN);
            }
            return;
        }// end function

        private function phaseNameEntyrOpen() : void
        {
            SoundManager.getInstance().playBgm(SoundId.BGM_INS_RESEARCH);
            this._fade.setFadeIn(1, function () : void
            {
                _isoMain.setIn(function () : void
                {
                    _isoBard.setIn(function () : void
                    {
                        _isoBalloon1.setIn(function () : void
                        {
                            setPhase(_PHASE_NAME_ENTRY_WAIT);
                            return;
                        }// end function
                        );
                        return;
                    }// end function
                    );
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function phaseNameEntyrWait() : void
        {
            this._btnDecide.setDisableFlag(true);
            this._btnTitleReturn.setDisable(false);
            this._len = -1;
            Main.GetProcess().stage.focus = this._inputTextField;
            return;
        }// end function

        private function controlNameEntryWait(param1:Number) : void
        {
            if (this._len != this._inputTextField.length)
            {
                this._len = this._inputTextField.length;
                this._btnDecide.setDisable(this._len < 1);
            }
            return;
        }// end function

        private function phaseNameEntyrConfirm() : void
        {
            this._btnYes.setDisableFlag(false);
            this._btnNo.setDisableFlag(false);
            return;
        }// end function

        private function phaseConnecting() : void
        {
            return;
        }// end function

        private function controlConnecting(param1:Number) : void
        {
            if (this._bNameEntryCompleted && this._isoBalloon2.bClosed)
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            if (this._bNameEntryCompleted)
            {
                if (this._cbNameEntry != null)
                {
                    this._cbNameEntry();
                }
            }
            else if (this._cbReturn != null)
            {
                this._cbReturn();
            }
            return;
        }// end function

        private function controlWait() : void
        {
            return;
        }// end function

        private function phaseSetClose() : void
        {
            if (this._btnDecide)
            {
                this._btnDecide.setDisableFlag(true);
            }
            if (this._btnTitleReturn)
            {
                this._btnTitleReturn.setDisableFlag(true);
            }
            if (this._btnYes)
            {
                this._btnYes.setDisableFlag(true);
            }
            if (this._btnNo)
            {
                this._btnNo.setDisableFlag(true);
            }
            this._fade.setFadeOut(0.5, function () : void
            {
                _isoBalloon3.setOut();
                _isoBard.setOut();
                _isoMain.setOut();
                if (_backScreen)
                {
                    _backScreen.release();
                }
                _backScreen = null;
                return;
            }// end function
            );
            return;
        }// end function

        private function controlSetClose(param1:Number) : void
        {
            if (this._isoBalloon3.bClosed && this._isoBard.bClosed && this._isoMain.bClosed)
            {
                this.setPhase(this._PHASE_CLOSED);
            }
            return;
        }// end function

        private function phaseClosed() : void
        {
            return;
        }// end function

        private function cbBtnDecide(param1:int) : void
        {
            var id:* = param1;
            this._btnDecide.setDisableFlag(true);
            this._btnTitleReturn.setDisableFlag(true);
            this._isoBalloon1.setOut(function () : void
            {
                _inputName = SrtConv.toZenkaku(_inputTextField.text);
                TextControl.setText(_mcBase.NaviBalloon2Mc.balloonMc.nameTextMc.textDt, _inputName);
                _isoBalloon2.setIn(function () : void
                {
                    setPhase(_PHASE_NAME_ENTRY_CONFIRM);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function cbBtnTitleReturn(param1:int) : void
        {
            this._btnDecide.setDisableFlag(true);
            this._btnTitleReturn.setDisableFlag(true);
            this.setPhase(this._PHASE_WAIT);
            return;
        }// end function

        private function cbBtnYes(param1:int) : void
        {
            this._btnYes.setDisableFlag(true);
            this._btnNo.setDisableFlag(true);
            this._isoBalloon2.setOut();
            if (UserDataManager.getInstance().userData.name == this._inputName)
            {
                this._bNameEntryCompleted = true;
            }
            else
            {
                NetManager.getInstance().request(new NetTaskUserRename(this._inputName, this.cbConnectNameEntry));
            }
            this.setPhase(this._PHASE_CONNECTING);
            return;
        }// end function

        private function cbBtnNo(param1:int) : void
        {
            var id:* = param1;
            this._btnYes.setDisableFlag(true);
            this._btnNo.setDisableFlag(true);
            this._isoBalloon2.setOut(function () : void
            {
                _isoBalloon1.setIn(function () : void
                {
                    setPhase(_PHASE_NAME_ENTRY_WAIT);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function cbConnectNameEntry(param1:NetResult) : void
        {
            var cbFunc:Function;
            var res:* = param1;
            if (res.resultCode != NetId.RESULT_OK)
            {
                cbFunc = function () : void
            {
                _isoBalloon1.setIn(function () : void
                {
                    setPhase(_PHASE_NAME_ENTRY_WAIT);
                    return;
                }// end function
                );
                return;
            }// end function
            ;
                if (res.resultCode == NetId.RESULT_ERROR_USER_RENAME_TOO_LONG)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.OPENING_NAME_ENTRY_ERROR_MESSAGE_TOO_LONG), cbFunc);
                }
                else if (res.resultCode == NetId.RESULT_ERROR_USER_RENAME_NG_WORD)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.OPENING_NAME_ENTRY_ERROR_MESSAGE_NG_WORD), cbFunc);
                }
                else if (res.resultCode == NetId.RESULT_ERROR_USER_RENAME_INVALID_CHARA)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.OPENING_NAME_ENTRY_ERROR_MESSAGE_INVALID_CHARA), cbFunc);
                }
                return;
            }
            UserDataManager.getInstance().userData.name = this._inputName;
            this._bNameEntryCompleted = true;
            return;
        }// end function

        private function cbKeyDown(event:KeyboardEvent) : void
        {
            if (event.keyCode == Keyboard.ENTER)
            {
                if (this._btnDecide.isEnable())
                {
                    this.cbBtnDecide(0);
                }
            }
            return;
        }// end function

    }
}
