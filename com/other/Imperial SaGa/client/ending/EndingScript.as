package ending
{
    import button.*;
    import flash.display.*;
    import message.*;
    import popup.*;
    import resource.*;
    import script.*;
    import user.*;

    public class EndingScript extends Object
    {
        private const _PHASE_RESOURCE_LOAD:int = 1;
        private const _PHASE_OPEN:int = 2;
        private const _PHASE_SCRIPT_CHECK:int = 3;
        private const _PHASE_SCRIPT_EXE:int = 4;
        private const _PHASE_PAUSE:int = 5;
        private const _PHASE_CLOSE:int = 99;
        private var _fileName:String;
        private var _scriptId:int;
        private var _phase:int;
        private var _backMc:Shape;
        private var _baseMc:MovieClip;
        private var _skipButton:ButtonBase;
        private var _scriptMain:ScriptMain;
        private var _bEnd:Boolean;

        public function EndingScript(param1:DisplayObjectContainer, param2:String, param3:int)
        {
            this._backMc = new Shape();
            this._backMc.graphics.beginFill(0);
            this._backMc.graphics.drawRect(0, 0, Constant.SCREEN_WIDTH, Constant.SCREEN_HEIGHT);
            this._backMc.graphics.endFill();
            param1.addChild(this._backMc);
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.RESULT_PATH + "UI_CycleChange.swf", "EndingMovie");
            this._fileName = param2;
            this._scriptId = param3;
            this._baseMc.skipMc.visible = false;
            param1.addChild(this._baseMc);
            this._bEnd = false;
            this.setPhase(this._PHASE_RESOURCE_LOAD);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            if (this._skipButton)
            {
                ButtonManager.getInstance().removeButton(this._skipButton);
            }
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            if (this._backMc && this._backMc.parent)
            {
                this._backMc.parent.removeChild(this._backMc);
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
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_SCRIPT_CHECK:
                {
                    this.controlScriptCheck(param1);
                    break;
                }
                case this._PHASE_SCRIPT_EXE:
                {
                    this.controlScriptExe(param1);
                    break;
                }
                case this._PHASE_PAUSE:
                {
                    this.controlPause();
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
                    case this._PHASE_RESOURCE_LOAD:
                    {
                        this.phaseResourceLoad();
                        break;
                    }
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_SCRIPT_CHECK:
                    {
                        this.phaseScriptCheck();
                        break;
                    }
                    case this._PHASE_SCRIPT_EXE:
                    {
                        this.phaseScriptExe();
                        break;
                    }
                    case this._PHASE_PAUSE:
                    {
                        this.phasePause();
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

        private function phaseResourceLoad() : void
        {
            this._bEnd = false;
            ScriptManager.getInstance().loadScript(ScriptManager.SCRIPT_PATH + "Ending/" + this._fileName, ScriptScreen.SCREEN_ENDING, true);
            return;
        }// end function

        private function controlResourceLoad() : void
        {
            if (ScriptManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_OPEN);
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._baseMc.visible = true;
            if (Main.GetProcess().fade.isFade())
            {
                Main.GetProcess().fade.setFadeIn(0);
            }
            if (this._skipButton)
            {
                this._skipButton.setDisable(false);
            }
            this.setPhase(this._PHASE_SCRIPT_CHECK);
            return;
        }// end function

        private function controlOpen() : void
        {
            return;
        }// end function

        private function phasePause() : void
        {
            if (this._skipButton)
            {
                this._skipButton.setDisable(true);
            }
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.ENDING_SKIP_POPUP), this.cbCheckSkip);
            return;
        }// end function

        private function controlPause() : void
        {
            return;
        }// end function

        private function phaseScriptCheck() : void
        {
            this._scriptMain = ScriptManager.getInstance().getEndingScript(ScriptScreen.SCREEN_ENDING, this._scriptId);
            this._scriptId = Constant.EMPTY_ID;
            if (this._scriptMain != null)
            {
                ResourceManager.getInstance().loadResource(ScriptManager.getResourcePath());
            }
            return;
        }// end function

        private function controlScriptCheck(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded())
            {
                if (this._scriptMain != null)
                {
                    this.setPhase(this._PHASE_SCRIPT_EXE);
                }
                else
                {
                    this.setPhase(this._PHASE_CLOSE);
                }
            }
            return;
        }// end function

        private function phaseScriptExe() : void
        {
            ScriptManager.getInstance().initScript(this._scriptMain, this._baseMc.movieNull);
            ScriptManager.getInstance().commandInit(UserDataManager.getInstance().userData.cycle != 1);
            return;
        }// end function

        private function controlScriptExe(param1:Number) : void
        {
            ScriptManager.getInstance().commandControl(param1);
            if (ScriptManager.getInstance().isScriptEnd())
            {
                ScriptManager.getInstance().releaseScript();
                this.setPhase(this._PHASE_SCRIPT_CHECK);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            if (this._skipButton)
            {
                this._skipButton.setDisable(true);
            }
            this._baseMc.visible = false;
            this._bEnd = true;
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function cbClick(param1:int) : void
        {
            this.setPhase(this._PHASE_PAUSE);
            return;
        }// end function

        private function cbCheckSkip(param1:Boolean) : void
        {
            if (param1)
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            else
            {
                if (this._skipButton)
                {
                    this._skipButton.setDisable(false);
                }
                this._phase = this._PHASE_SCRIPT_EXE;
            }
            return;
        }// end function

    }
}
