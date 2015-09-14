package process
{
    import externalLinkage.*;
    import flash.net.*;
    import network.*;
    import resource.*;
    import sound.*;

    public class ProcessLogin extends ProcessBase
    {
        private var _phase:int;
        private var _cbLoginComplete:Function;
        private static const _PHASE_LOGIN:int = 1;
        private static const _PHASE_LOGIN_RESOURCE:int = 2;
        private static const _PHASE_GOTO:int = 3;

        public function ProcessLogin(param1:Function)
        {
            this._cbLoginComplete = param1;
            this.setPhase(_PHASE_LOGIN);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            _bResourceLoadWait = true;
            var _loc_1:* = ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_AnnouncePopup.swf");
            _loc_1.bRemoveLock = true;
            this.login();
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                bResourceLoadWait = false;
                if (Main.GetProcess().fade.isFade())
                {
                    Main.GetProcess().fade.setFadeIn(0.2);
                }
            }
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case _PHASE_LOGIN:
                {
                    if (Main.GetApplicationData().bLogin)
                    {
                        this.setPhase(_PHASE_LOGIN_RESOURCE);
                    }
                    break;
                }
                case _PHASE_LOGIN_RESOURCE:
                {
                    if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
                    {
                        this.loginLoaded();
                        this.setPhase(_PHASE_GOTO);
                    }
                    break;
                }
                case _PHASE_GOTO:
                {
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
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_LOGIN:
                {
                    break;
                }
                case _PHASE_LOGIN_RESOURCE:
                {
                    break;
                }
                case _PHASE_GOTO:
                {
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_LOGIN_AFTER);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function login() : void
        {
            NetManager.getInstance().request(new NetTaskLogin(this.cbLogin));
            return;
        }// end function

        private function cbLogin(param1:NetResult) : void
        {
            var _loc_2:* = null;
            if (Main.GetApplicationData().getTimeToolUrl() != "")
            {
                _loc_2 = new URLRequest(Main.GetApplicationData().getTimeToolUrl());
                navigateToURL(_loc_2);
            }
            ExternalLinkageJS.callJSRemarketingTag(ExternalLinkageJSConstant.REMARKETING_TAG_LOGIN);
            this._cbLoginComplete();
            return;
        }// end function

        private function loginLoaded() : void
        {
            Main.GetProcess().startLoadingWatch();
            return;
        }// end function

    }
}
