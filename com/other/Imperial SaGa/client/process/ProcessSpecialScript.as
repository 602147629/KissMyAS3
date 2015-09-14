package process
{
    import flash.display.*;
    import layer.*;
    import resource.*;
    import script.*;
    import user.*;

    public class ProcessSpecialScript extends ProcessBase
    {
        private var _phase:int;
        private var _scriptMain:ScriptMain;
        private var _layer:LayerSpecialScript;
        private var _filter:Sprite;
        private static const PHASE_SCRIPT_CHECK:int = 1;
        private static const PHASE_SCRIPT_EXE:int = 2;
        private static const PHASE_ROUTE_WAIT:int = 3;
        private static const PHASE_END:int = 4;

        public function ProcessSpecialScript()
        {
            return;
        }// end function

        override public function release() : void
        {
            if (this._layer)
            {
                this._layer.release();
            }
            this._layer = null;
            if (this._filter && this._filter.parent)
            {
                this._filter.parent.removeChild(this._filter);
            }
            this._filter = null;
            super.release();
            return;
        }// end function

        override public function init() : void
        {
            this._layer = new LayerSpecialScript();
            addChild(this._layer);
            this._filter = new Sprite();
            var _loc_1:* = this._filter.graphics;
            _loc_1.lineStyle(0, 0, 1);
            _loc_1.beginFill(0, 1);
            _loc_1.drawRect(0, 0, Constant.SCREEN_WIDTH, Constant.SCREEN_HEIGHT);
            this._layer.getLayer(LayerSpecialScript.BG).addChild(this._filter);
            ScriptManager.getInstance().loadResource();
            ScriptManager.getInstance().loadScript(ScriptManager.SCRIPT_PATH + "SpecialEvent/" + CommonConstant.ROUTE_SELECT_SCRIPT_FILE, ScriptScreen.SCREEN_SPECIAL, true);
            bResourceLoadWait = true;
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            if (ScriptManager.getInstance().isLoaded() == false)
            {
                return;
            }
            _bTopbarButtonDisable = true;
            Main.GetProcess().topBar.open();
            if (Main.GetProcess().fade.isFade())
            {
                Main.GetProcess().fade.setFadeIn(0.2);
            }
            bResourceLoadWait = false;
            this.setPhase(PHASE_SCRIPT_CHECK);
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case PHASE_SCRIPT_CHECK:
                {
                    this.controlScriptCheck();
                    break;
                }
                case PHASE_SCRIPT_EXE:
                {
                    this.controlScriptExe(param1);
                    break;
                }
                case PHASE_ROUTE_WAIT:
                {
                    this.controlRouteWait();
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
                    case PHASE_SCRIPT_CHECK:
                    {
                        this.phaseScriptCheck();
                        break;
                    }
                    case PHASE_SCRIPT_EXE:
                    {
                        this.phaseScriptExe();
                        break;
                    }
                    case PHASE_ROUTE_WAIT:
                    {
                        this.phaseRouteWait();
                        break;
                    }
                    case PHASE_END:
                    {
                        this.phaseEnd();
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

        private function phaseScriptCheck() : void
        {
            this._scriptMain = ScriptManager.getInstance().getScript(ScriptScreen.SCREEN_SPECIAL, ScriptComConstant.TRIGGER_SPECIAL_SCRIPT);
            if (this._scriptMain != null)
            {
                ResourceManager.getInstance().loadResource(ScriptManager.getResourcePath());
            }
            return;
        }// end function

        private function controlScriptCheck() : void
        {
            if (ResourceManager.getInstance().isLoaded())
            {
                if (this._scriptMain != null)
                {
                    this.setPhase(PHASE_SCRIPT_EXE);
                }
                else
                {
                    this.setPhase(PHASE_ROUTE_WAIT);
                }
            }
            return;
        }// end function

        private function phaseScriptExe() : void
        {
            ScriptManager.getInstance().initScript(this._scriptMain, this._layer.getLayer(LayerSpecialScript.SCRIPT));
            ScriptManager.getInstance().commandInit(UserDataManager.getInstance().userData.cycle != 1);
            return;
        }// end function

        private function controlScriptExe(param1:Number) : void
        {
            ScriptManager.getInstance().commandControl(param1);
            if (ScriptManager.getInstance().isScriptEnd())
            {
                this.setPhase(PHASE_SCRIPT_CHECK);
            }
            return;
        }// end function

        private function phaseRouteWait() : void
        {
            return;
        }// end function

        private function controlRouteWait() : void
        {
            if (UserDataManager.getInstance().userData.route != CommonConstant.ROUTE_TYPE_NORMAL)
            {
                this.setPhase(PHASE_END);
            }
            return;
        }// end function

        private function phaseEnd() : void
        {
            Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
            return;
        }// end function

    }
}
