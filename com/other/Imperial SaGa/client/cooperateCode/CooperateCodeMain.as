package cooperateCode
{
    import flash.display.*;
    import network.*;
    import resource.*;
    import sound.*;

    public class CooperateCodeMain extends Object
    {
        private const _PHASE_CONNECT:int = 1;
        private const _PHASE_RESOURCE_LOAD:int = 2;
        private const _PHASE_MAIN:int = 3;
        private const _PHASE_CLOSE:int = 99;
        private var _parent:DisplayObjectContainer;
        private var _phase:int;
        private var _codeList:CooperateCodeList;

        public function CooperateCodeMain(param1:DisplayObjectContainer)
        {
            this._parent = param1;
            this._phase = this._PHASE_CONNECT;
            this._codeList = null;
            NetManager.getInstance().request(new NetTaskCooperateInfo(this.cbReceive));
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == this._PHASE_CLOSE;
        }// end function

        public function release() : void
        {
            if (this._codeList)
            {
                this._codeList.release();
            }
            this._codeList = null;
            this._parent = null;
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
                case this._PHASE_MAIN:
                {
                    this.controlMain(param1);
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
                    case this._PHASE_MAIN:
                    {
                        this.phaseMain();
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

        private function cbReceive(param1:NetResult) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in param1.data.aCooperate)
            {
                
                _loc_4 = new CooperateCodeInformation();
                _loc_4.setReceive(_loc_3);
                _loc_2.push(_loc_4);
            }
            CooperateCodeManager.getInstance().setCooperateCode(_loc_2);
            this.setPhase(this._PHASE_RESOURCE_LOAD);
            return;
        }// end function

        private function phaseResourceLoad() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.HOME_PATH + "UI_CampaignList.swf");
            return;
        }// end function

        private function controlResourceLoad() : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_MAIN);
            }
            return;
        }// end function

        private function phaseMain() : void
        {
            if (this._codeList == null)
            {
                this._codeList = new CooperateCodeList(this._parent);
            }
            return;
        }// end function

        private function controlMain(param1:Number) : void
        {
            if (this._codeList)
            {
                this._codeList.control(param1);
                if (this._codeList.bEnd)
                {
                    this._codeList.release();
                    this._codeList = null;
                    this.setPhase(this._PHASE_CLOSE);
                }
            }
            return;
        }// end function

    }
}
