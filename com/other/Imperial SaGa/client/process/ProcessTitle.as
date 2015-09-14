package process
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import input.*;
    import layer.*;
    import message.*;
    import resource.*;
    import sound.*;
    import title.*;
    import topbar.*;
    import user.*;
    import utility.*;

    public class ProcessTitle extends ProcessBase
    {
        private const _PHASE_RESOURCE_LOAD:int = 1;
        private const _PHASE_TITLE_OPEN:int = 20;
        private const _PHASE_STAY:int = 21;
        private const _PHASE_TITLE_OUT:int = 22;
        private const _PHASE_FADE:int = 30;
        private const _PHASE_CLOSE:int = 99;
        private const _LABEL_A_IN:String = "patternAIn";
        private const _LABEL_A_TITLE_OUT:String = "patternATitleOut";
        private const _LABEL_A_TITLE_IN:String = "patternATitleIn";
        private const _LABEL_A_OUT:String = "patternAOut";
        private const _LABEL_B_IN:String = "patternBIn";
        private const _LABEL_B_OUT:String = "patternBOut";
        private const _FILE_NAME:String = "is_op.swf";
        private const _TITLE_WAIT:Number;
        private const _RESOURCE_LOAD_WAIT:Number = 5;
        private const _NO_MOVIE_WAIT:Number = 120;
        private var _titleMc:MovieClip;
        private var _loadingMc:MovieClip;
        private var _titleButton:ButtonBase;
        private var _configButton:ButtonBase;
        private var _phase:int;
        private var _isoTitle:InStayOut;
        private var _isoLoading:InStayOut;
        private var _fade:Fade;
        private var _timer:Number;
        private var _bMovieMode:Boolean;
        private var _bClose:Boolean;
        private const _PLAY_MOVIE_TIME:Number = 18;
        private var _movie:TitleMovie;
        private var _titleTimer:TitleTimer;
        private var _configWindow:ConfigWindow;
        private var _bPlayMovieMode:Boolean;
        private var _configLayer:LayerMainProcess;

        public function ProcessTitle()
        {
            this._TITLE_WAIT = this._PLAY_MOVIE_TIME;
            return;
        }// end function

        private function get _bConfigOpen() : Boolean
        {
            return this._configWindow != null;
        }// end function

        override public function init() : void
        {
            super.init();
            Main.GetProcess().stopLoadingWatch();
            ResourceManager.getInstance().loadResource(ResourcePath.TITLE_PATH + "Title.swf");
            _bResourceLoadWait = true;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._configLayer != null)
            {
                if (this._configLayer.parent)
                {
                    this._configLayer.parent.removeChild(this._configLayer);
                }
            }
            if (this._movie)
            {
                this._movie.release();
            }
            this._movie = null;
            if (this._titleTimer)
            {
                this._titleTimer.release();
            }
            this._titleTimer = null;
            ResourceManager.getInstance().removeResource(ResourcePath.MOVIE_OPED_PATH + this._FILE_NAME);
            if (this._isoLoading)
            {
                this._isoLoading.release();
            }
            if (this._loadingMc && this._loadingMc.parent)
            {
                this._loadingMc.parent.removeChild(this._loadingMc);
            }
            if (this._titleButton)
            {
                ButtonManager.getInstance().removeButton(this._titleButton);
            }
            if (this._configButton)
            {
                ButtonManager.getInstance().removeButton(this._configButton);
                this._configButton = null;
            }
            InputManager.getInstance().delMouseCallback(this);
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            if (ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            this._titleMc = ResourceManager.getInstance().createMovieClip(ResourcePath.TITLE_PATH + "Title.swf", "TitleMc");
            this.addChild(this._titleMc);
            this._isoTitle = new InStayOut(this._titleMc);
            TextControl.setText(this._titleMc.textMc.textDt, "");
            this._fade = Main.GetProcess().fade;
            this._bClose = false;
            this._bMovieMode = true;
            _bResourceLoadWait = false;
            this._titleButton = ButtonManager.getInstance().addButton(this._titleMc.gameStartBtnMc, this.cbButtonClick);
            this._titleButton.enterSeId = SoundId.SE_REV_TITLESTART;
            this._titleButton.setDisableFlag(true);
            this._configButton = ButtonManager.getInstance().addButton(this._titleMc.ConfigBtnMc, this.cbConfigButtonClick);
            this._configButton.enterSeId = ButtonBase.SE_SELECT_ID;
            this._configButton.setDisableFlag(true);
            this._titleTimer = new TitleTimer(this._TITLE_WAIT, this._PLAY_MOVIE_TIME, this._NO_MOVIE_WAIT, this.cbTitleEndTime, this.cbPlayMovieTime, this.cbBgmEndTime);
            this._movie = new TitleMovie(this, this._FILE_NAME, this.cbMovieStart, this.cbMovieEnd);
            if (this._configLayer == null)
            {
                this._configLayer = new LayerMainProcess();
                this.addChild(this._configLayer);
            }
            this._bPlayMovieMode = true;
            this._bMovieMode = true;
            this.setPhase(this._PHASE_RESOURCE_LOAD);
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_RESOURCE_LOAD:
                {
                    this.controlResourceLoad(param1);
                    break;
                }
                case this._PHASE_TITLE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_STAY:
                {
                    this.controlTitleStay(param1);
                    break;
                }
                case this._PHASE_TITLE_OUT:
                {
                    this.controlTitleOut();
                    break;
                }
                case this._PHASE_FADE:
                {
                    this.controlFade();
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            if (this._titleTimer)
            {
                this._titleTimer.control(param1);
            }
            if (this._movie)
            {
                this._movie.control(param1);
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
                    case this._PHASE_TITLE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_STAY:
                    {
                        this.phaseTitleStay();
                        break;
                    }
                    case this._PHASE_TITLE_OUT:
                    {
                        this.phaseTitleOut();
                        break;
                    }
                    case this._PHASE_FADE:
                    {
                        this.phaseFade();
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
                        break;
                    }
                }
            }
            return;
        }// end function

        private function phaseResourceLoad() : void
        {
            SoundManager.getInstance().loadSound(SoundId.BGM_TITLE_MAINTHEME);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_REV_TITLESTART]);
            ResourceManager.getInstance().loadResourceMovie(ResourcePath.MOVIE_OPED_PATH + this._FILE_NAME);
            this._loadingMc = ResourceManager.getInstance().createMovieClip(ResourcePath.TITLE_PATH + "Title.swf", "LordingMc");
            this.addChild(this._loadingMc);
            this._isoLoading = new InStayOut(this._loadingMc);
            this._isoLoading.setIn();
            this._timer = this._RESOURCE_LOAD_WAIT;
            return;
        }// end function

        private function controlResourceLoad(param1:Number) : void
        {
            if (this._isoLoading.bAnimetion)
            {
                return;
            }
            if (this._timer > 0)
            {
                this._timer = this._timer - param1;
            }
            if (ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false || this._timer > 0)
            {
                return;
            }
            if (this._isoLoading.bOpened)
            {
                this._isoLoading.setOut(this.cbLoadingClose);
            }
            return;
        }// end function

        private function cbLoadingClose() : void
        {
            if (this._isoLoading)
            {
                this._isoLoading.release();
            }
            this._isoLoading = null;
            if (this._loadingMc.parent)
            {
                this._loadingMc.parent.removeChild(this._loadingMc);
            }
            this._loadingMc = null;
            this.setPhase(this._PHASE_TITLE_OPEN);
            return;
        }// end function

        private function phaseOpen() : void
        {
            if (!this._bConfigOpen)
            {
                if (this._movie.bPlayMovie && this._bPlayMovieMode)
                {
                    this._isoTitle.setInLabel(this._LABEL_A_TITLE_IN);
                }
                else if (this._bPlayMovieMode)
                {
                    this._isoTitle.setInLabel(this._bMovieMode ? (this._LABEL_A_IN) : (this._LABEL_B_IN));
                    InputManager.getInstance().addMouseCallback(this, null, this.cbFadeInClick);
                }
            }
            SoundManager.getInstance().setBgmLoopCount(0);
            SoundManager.getInstance().playBgm(SoundId.BGM_TITLE_MAINTHEME);
            this._titleTimer.startCheck();
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoTitle.bOpened)
            {
                this.setPhase(this._PHASE_STAY);
            }
            return;
        }// end function

        private function phaseTitleStay() : void
        {
            if (this._fade.isFade())
            {
                this._fade.setFadeOut(0);
            }
            InputManager.getInstance().delMouseCallback(this);
            this.setBtnDisable(false);
            return;
        }// end function

        private function controlTitleStay(param1:Number) : void
        {
            return;
        }// end function

        private function phaseTitleOut() : void
        {
            this.setBtnDisable(true);
            this._isoTitle.setInLabel(this._bMovieMode ? (this._LABEL_A_TITLE_OUT) : (this._LABEL_B_OUT));
            return;
        }// end function

        private function controlTitleOut() : void
        {
            return;
        }// end function

        private function cbTitleClose() : void
        {
            var _loc_1:* = 0;
            if (this._bClose)
            {
                Main.GetProcess().startLoadingWatch();
                if (this._titleTimer)
                {
                    this._titleTimer.stopCheck();
                }
                _loc_1 = ProcessMain.PROCESS_HOME;
                switch(UserDataManager.getInstance().userData.statusType)
                {
                    case CommonConstant.USER_STATE_CREATE:
                    case CommonConstant.USER_STATE_OPENING:
                    {
                        _loc_1 = ProcessMain.PROCESS_OPENING;
                        break;
                    }
                    case CommonConstant.USER_STATE_CYCLE_RESET:
                    case CommonConstant.USER_STATE_CYCLE_ENDING:
                    case CommonConstant.USER_STATE_CYCLE_CHRONOLOGY:
                    case CommonConstant.USER_STATE_CYCLE_REWARD:
                    case CommonConstant.USER_STATE_NEW_CYCLE_TUTORIAL:
                    {
                        _loc_1 = ProcessMain.PROCESS_ENDING;
                        break;
                    }
                    case CommonConstant.USER_STATE_TUTORIAL:
                    {
                        _loc_1 = ProcessMain.PROCESS_LOGIN_AFTER;
                        break;
                    }
                    default:
                    {
                        if (UserDataManager.getInstance().checkSpecialEvent())
                        {
                            _loc_1 = ProcessMain.PROCESS_SPECIAL_EVENT;
                        }
                        break;
                        break;
                    }
                }
                if (_loc_1 == ProcessMain.PROCESS_HOME)
                {
                    Main.GetProcess().createLoadingScreen();
                }
                Main.GetProcess().SetProcessId(_loc_1);
                return;
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this.setBtnDisable(true);
            if (this._titleTimer)
            {
                this._titleTimer.stopCheck();
            }
            this._isoTitle.setInLabel(this._LABEL_B_OUT, this.cbTitleClose);
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function phaseFade() : void
        {
            this._fade.setFadeIn(Constant.FADE_IN_TIME);
            this._bMovieMode = false;
            return;
        }// end function

        private function controlFade() : void
        {
            if (!this._fade.isFade() && this._fade.isFadeEnd())
            {
                this._titleMc.gotoAndStop("patternBStay");
                this.setPhase(this._PHASE_STAY);
            }
            return;
        }// end function

        private function setBtnDisable(param1:Boolean) : void
        {
            if (this._titleButton)
            {
                this._titleButton.setDisable(param1);
            }
            if (this._configButton)
            {
                this._configButton.setDisable(param1);
            }
            return;
        }// end function

        private function cbMovieStart() : void
        {
            this.setBtnDisable(true);
            return;
        }// end function

        private function cbMovieEnd() : void
        {
            this._titleTimer.stopCheck();
            this._bMovieMode = false;
            SoundManager.getInstance().stopBgm();
            this.setPhase(this._PHASE_TITLE_OPEN);
            return;
        }// end function

        private function cbButtonClick(param1:int) : void
        {
            this._bClose = true;
            this.setPhase(this._PHASE_CLOSE);
            return;
        }// end function

        private function cbFadeInClick(event:MouseEvent) : void
        {
            this.setPhase(this._PHASE_FADE);
            return;
        }// end function

        private function cbConfigWindowClose() : void
        {
            if (this._configWindow)
            {
                this._configWindow.release();
            }
            this._configWindow = null;
            this.setBtnDisable(false);
            this.setPhase(this._PHASE_STAY);
            return;
        }// end function

        private function cbConfigButtonClick(param1:int) : void
        {
            this.setBtnDisable(true);
            if (!this._configWindow)
            {
                this._configWindow = new ConfigWindow(this._configLayer, this.cbConfigWindowClose);
            }
            this._configWindow.open();
            return;
        }// end function

        private function cbTitleEndTime() : void
        {
            if (!this._bConfigOpen && this._isoTitle.bClosed == false)
            {
                this.setPhase(this._PHASE_TITLE_OUT);
            }
            return;
        }// end function

        private function cbPlayMovieTime() : void
        {
            if (this._bConfigOpen)
            {
                this._bPlayMovieMode = false;
                return;
            }
            this._bPlayMovieMode = true;
            if (this._movie)
            {
                this._movie.playMovie();
            }
            return;
        }// end function

        private function cbBgmEndTime() : void
        {
            this._titleTimer.stopCheck();
            this._bMovieMode = false;
            SoundManager.getInstance().stopBgm();
            this.setPhase(this._PHASE_TITLE_OPEN);
            return;
        }// end function

    }
}
