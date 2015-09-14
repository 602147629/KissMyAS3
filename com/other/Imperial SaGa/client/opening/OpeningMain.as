package opening
{
    import button.*;
    import externalLinkage.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import input.*;
    import message.*;
    import movie.*;
    import network.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import user.*;
    import utility.*;

    public class OpeningMain extends Object
    {
        private var _phase:int;
        private var _parent:DisplayObjectContainer;
        private var _mcBase:MovieClip;
        private var _mcMovie:MovieClip;
        private var _movieUi:CommonMovieUi;
        private var _mcChapter:MovieClip;
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
        private var _talkWait:Number;
        private var _bMoviePlayEnd:Boolean;
        private var _bBgmPlayStart:Boolean;
        private var _bBgmPlayEnd:Boolean;
        private var _inputName:String;
        private var _bNameEntryCompleted:Boolean;
        private var _len:int;
        private var _inputTextField:TextField;
        private static const _OPENING_MOVIE_NAME:String = "is_op02.swf";
        private static const _CHAPTER_MOVIE_NAME:String = "chapter01.swf";
        private static const _TALK_IN_WAIT:int = 1;
        private static const _TALK_OUT_WAIT:int = 3;
        private static const _PHASE_LOADING:int = 0;
        private static const _PHASE_NAME_ENTRY_OPEN:int = 1;
        private static const _PHASE_NAME_ENTRY_WAIT:int = 2;
        private static const _PHASE_NAME_ENTRY_CONFIRM:int = 3;
        private static const _PHASE_CONNECTING:int = 4;
        private static const _PHASE_TALK:int = 5;
        private static const _PHASE_MOVIE_WAIT:int = 6;
        private static const _PHASE_MOVIE:int = 7;
        private static const _PHASE_CHAPTER_RESOURCE:int = 8;
        private static const _PHASE_CHAPTER:int = 9;
        private static const _PHASE_CLOSE:int = 10;

        public function OpeningMain(param1:DisplayObjectContainer)
        {
            this._parent = param1;
            ResourceManager.getInstance().loadResource(ResourcePath.LOGIN_PATH + "UI_Login.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.MOVIE_PATH + "UI_Movie.swf");
            ResourceManager.getInstance().loadResourceMovie(ResourcePath.MOVIE_OPED_PATH + _OPENING_MOVIE_NAME);
            CommonPopup.getInstance().loadResource();
            SoundManager.getInstance().loadSound(SoundId.BGM_INS_RESEARCH);
            SoundManager.getInstance().loadSound(SoundId.BGM_DEM_SUCCESSION_LOOP);
            this._phase = _PHASE_LOADING;
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == _PHASE_CLOSE && (this._isoMain && this._isoMain.bClosed);
        }// end function

        private function resourceLoaded() : void
        {
            var _loc_1:* = ResourcePath.LOGIN_PATH + "UI_Login.swf";
            this._mcBase = ResourceManager.getInstance().createMovieClip(_loc_1, "nameEntryPopup");
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
            this._mcMovie = null;
            this._movieUi = null;
            this._mcChapter = null;
            this._bMoviePlayEnd = false;
            this._bBgmPlayStart = false;
            this._bBgmPlayEnd = false;
            if (UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_CREATE)
            {
                SoundManager.getInstance().playBgm(SoundId.BGM_INS_RESEARCH);
                this.setPhase(_PHASE_NAME_ENTRY_OPEN);
            }
            else
            {
                this.setPhase(_PHASE_MOVIE_WAIT);
            }
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
            if (this._mcChapter && this._mcChapter.parent)
            {
                this._mcChapter.parent.removeChild(this._mcMovie);
            }
            this._mcChapter = null;
            if (this._movieUi)
            {
                this._movieUi.release();
            }
            this._movieUi = null;
            if (this._mcMovie && this._mcMovie.parent)
            {
                this._mcMovie.parent.removeChild(this._mcMovie);
            }
            this._mcMovie = null;
            InputManager.getInstance().delMouseCallback(this);
            ResourceManager.getInstance().removeMovie(ResourcePath.MOVIE_EVENT_PATH + _CHAPTER_MOVIE_NAME);
            ResourceManager.getInstance().removeResource(ResourcePath.MOVIE_EVENT_PATH + _CHAPTER_MOVIE_NAME);
            ResourceManager.getInstance().removeMovie(ResourcePath.MOVIE_OPED_PATH + _OPENING_MOVIE_NAME);
            ResourceManager.getInstance().removeResource(ResourcePath.MOVIE_OPED_PATH + _OPENING_MOVIE_NAME);
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_NAME_ENTRY_OPEN:
                {
                    this.initPhaseNameEntyrOpen();
                    break;
                }
                case _PHASE_NAME_ENTRY_WAIT:
                {
                    this.initPhaseNameEntyrWait();
                    break;
                }
                case _PHASE_NAME_ENTRY_CONFIRM:
                {
                    this.initPhaseNameEntyrConfirm();
                    break;
                }
                case _PHASE_CONNECTING:
                {
                    this.initPhaseConnecting();
                    break;
                }
                case _PHASE_TALK:
                {
                    this.initPhaseTalk();
                    break;
                }
                case _PHASE_MOVIE_WAIT:
                {
                    this.initPhaseMovieWait();
                    break;
                }
                case _PHASE_MOVIE:
                {
                    this.initPhaseMovie();
                    break;
                }
                case _PHASE_CHAPTER_RESOURCE:
                {
                    this.initPhaseChapterResource();
                    break;
                }
                case _PHASE_CHAPTER:
                {
                    this.initPhaseChapter();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
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
                case _PHASE_LOADING:
                {
                    this.resourceLoaded();
                    break;
                }
                case _PHASE_NAME_ENTRY_WAIT:
                {
                    this.controlPhaseNameEntryWait(param1);
                    break;
                }
                case _PHASE_CONNECTING:
                {
                    this.controlPhaseConnecting(param1);
                    break;
                }
                case _PHASE_TALK:
                {
                    this.controlPhaseTalk(param1);
                    break;
                }
                case _PHASE_MOVIE_WAIT:
                {
                    this.controlPhaseMovieWait(param1);
                    break;
                }
                case _PHASE_MOVIE:
                {
                    this.controlPhaseMovie(param1);
                    break;
                }
                case _PHASE_CHAPTER_RESOURCE:
                {
                    this.controlPhaseChapterResource();
                    break;
                }
                case _PHASE_CHAPTER:
                {
                    this.controlPhaseChapter();
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

        private function initPhaseNameEntyrOpen() : void
        {
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

        private function initPhaseNameEntyrWait() : void
        {
            this._btnDecide.setDisableFlag(true);
            this._btnTitleReturn.setDisable(false);
            this._len = -1;
            Main.GetProcess().stage.focus = this._inputTextField;
            return;
        }// end function

        private function controlPhaseNameEntryWait(param1:Number) : void
        {
            if (this._len != this._inputTextField.length)
            {
                this._len = this._inputTextField.length;
                this._btnDecide.setDisable(this._len < 1);
            }
            return;
        }// end function

        private function initPhaseNameEntyrConfirm() : void
        {
            this._btnYes.setDisableFlag(false);
            this._btnNo.setDisableFlag(false);
            return;
        }// end function

        private function initPhaseConnecting() : void
        {
            return;
        }// end function

        private function controlPhaseConnecting(param1:Number) : void
        {
            if (this._bNameEntryCompleted && this._isoBalloon2.bClosed)
            {
                this.setPhase(_PHASE_TALK);
            }
            return;
        }// end function

        private function initPhaseTalk() : void
        {
            this._talkWait = _TALK_IN_WAIT;
            return;
        }// end function

        private function controlPhaseTalk(param1:Number) : void
        {
            var t:* = param1;
            if (this._talkWait > 0)
            {
                this._talkWait = this._talkWait - t;
                if (this._talkWait <= 0)
                {
                    if (!this._isoBalloon3.bOpened)
                    {
                        this._isoBalloon3.setIn(function () : void
            {
                _talkWait = _TALK_OUT_WAIT;
                return;
            }// end function
            );
                    }
                    else
                    {
                        this._fade.setFadeOut(2, function () : void
            {
                _isoBalloon3.setOut();
                _isoBard.setOut();
                _isoMain.setOut();
                setPhase(_PHASE_MOVIE_WAIT);
                return;
            }// end function
            );
                    }
                }
            }
            return;
        }// end function

        private function initPhaseMovieWait() : void
        {
            SoundManager.getInstance().stopBgm();
            return;
        }// end function

        private function controlPhaseMovieWait(param1:Number) : void
        {
            var t:* = param1;
            if (SoundManager.getInstance().isBgmFade())
            {
                ResourceManager.getInstance().loadMovieData(ResourcePath.MOVIE_OPED_PATH + _OPENING_MOVIE_NAME, function () : void
            {
                _mcMovie = ResourceManager.getInstance().getMovie(ResourcePath.MOVIE_OPED_PATH + _OPENING_MOVIE_NAME);
                _mcMovie.gotoAndPlay(0);
                _movieUi = new CommonMovieUi(_parent, ResourceManager.getInstance().createMovieClip(ResourcePath.MOVIE_PATH + "UI_Movie.swf", "UImovie"), _mcMovie, true);
                return;
            }// end function
            );
                this.setPhase(_PHASE_MOVIE);
            }
            return;
        }// end function

        private function initPhaseMovie() : void
        {
            ResourceManager.getInstance().loadResourceMovie(ResourcePath.MOVIE_EVENT_PATH + _CHAPTER_MOVIE_NAME);
            return;
        }// end function

        private function controlPhaseMovie(param1:Number) : void
        {
            if (this._mcMovie == null)
            {
                return;
            }
            if (this._movieUi)
            {
                this._movieUi.control(param1);
            }
            if (!this._bMoviePlayEnd)
            {
                if (this._mcMovie.currentFrame >= this._mcMovie.totalFrames)
                {
                    this._bMoviePlayEnd = true;
                }
            }
            if (!this._bBgmPlayStart)
            {
                if (this._mcMovie.currentFrame >= 8)
                {
                    this._bBgmPlayStart = true;
                    SoundManager.getInstance().setBgmLoopCount(0);
                    SoundManager.getInstance().playBgm(SoundId.BGM_DEM_SUCCESSION_LOOP);
                }
            }
            if (!this._bBgmPlayEnd)
            {
                if (this._mcMovie.currentFrame >= 2650 || this._bMoviePlayEnd)
                {
                    this._bBgmPlayEnd = true;
                    SoundManager.getInstance().stopBgm();
                }
            }
            if (this._bMoviePlayEnd && this._bBgmPlayEnd && SoundManager.getInstance().isBgmFade())
            {
                this.setPhase(_PHASE_CHAPTER_RESOURCE);
            }
            return;
        }// end function

        private function initPhaseChapterResource() : void
        {
            return;
        }// end function

        private function controlPhaseChapterResource() : void
        {
            if (ResourceManager.getInstance().isLoaded())
            {
                ResourceManager.getInstance().loadMovieData(ResourcePath.MOVIE_EVENT_PATH + _CHAPTER_MOVIE_NAME, function () : void
            {
                _mcChapter = ResourceManager.getInstance().getMovie(ResourcePath.MOVIE_EVENT_PATH + _CHAPTER_MOVIE_NAME);
                _parent.addChild(_mcChapter);
                _mcChapter.gotoAndPlay(0);
                return;
            }// end function
            );
                this.setPhase(_PHASE_CHAPTER);
            }
            return;
        }// end function

        private function initPhaseChapter() : void
        {
            return;
        }// end function

        private function controlPhaseChapter() : void
        {
            if (this._mcChapter == null)
            {
                return;
            }
            if (this._mcChapter.currentFrame >= this._mcChapter.totalFrames || this._mcChapter.isPlaying == false)
            {
                this.setPhase(_PHASE_CLOSE);
            }
            return;
        }// end function

        private function initPhaseClose() : void
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
            var id:* = param1;
            this._btnDecide.setDisableFlag(true);
            this._btnTitleReturn.setDisableFlag(true);
            this._isoBalloon1.setOut(function () : void
            {
                SoundManager.getInstance().stopBgm();
                Main.GetProcess().SetProcessId(ProcessMain.PROCESS_TITLE);
                return;
            }// end function
            );
            return;
        }// end function

        private function cbBtnYes(param1:int) : void
        {
            this._btnYes.setDisableFlag(true);
            this._btnNo.setDisableFlag(true);
            this._isoBalloon2.setOut();
            NetManager.getInstance().request(new NetTaskNameEntry(this._inputName, this.cbConnectNameEntry));
            this.setPhase(_PHASE_CONNECTING);
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
                if (res.resultCode == NetId.RESULT_ERROR_NAME_ENTRY_TOO_LONG)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.OPENING_NAME_ENTRY_ERROR_MESSAGE_TOO_LONG), cbFunc);
                }
                else if (res.resultCode == NetId.RESULT_ERROR_NAME_ENTRY_NG_WORD)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.OPENING_NAME_ENTRY_ERROR_MESSAGE_NG_WORD), cbFunc);
                }
                else if (res.resultCode == NetId.RESULT_ERROR_NAME_ENTRY_INVALID_CHARA)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.OPENING_NAME_ENTRY_ERROR_MESSAGE_INVALID_CHARA), cbFunc);
                }
                return;
            }
            UserDataManager.getInstance().userData.name = this._inputName;
            ExternalLinkageJS.callJSRemarketingTag(ExternalLinkageJSConstant.REMARKETING_TAG_NEWGAME);
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

        private function cbMouseClick(event:MouseEvent) : void
        {
            return;
        }// end function

    }
}
