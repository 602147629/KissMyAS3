package utility
{
    import flash.display.*;
    import resource.*;

    public class LoadingScreen extends Object
    {
        private var _parent:DisplayObjectContainer;
        private var _baseMc:MovieClip;
        private var _isoBaseMc:InStayOut;
        private var _fade:Fade;
        private var _targetIsoMc:InStayOut;
        private var _aCharacterIsoMc:Array;
        private var _aCharacterMc:Array;
        private var _aCharacterNullMc:Array;
        private var _wait:Number;
        private var _loadwait:Number;
        private var _phase:int;
        private var _bEnd:Boolean;
        private static const PHASE_NONE:int = 0;
        private static const PHASE_OPEN:int = 1;
        private static const PHASE_CLOSE:int = 2;
        private static const PHASE_CHARACTER_IN:int = 3;
        private static const PHASE_CHARACTER_STAY:int = 4;
        private static const PHASE_CHARACTER_OUT:int = 5;
        private static const WAIT_TIME:Number = 0.25;
        private static const LOADING_TIME:Number = 0.5;
        private static const _loadingCharacter:Array = [{label:"rollKickCat1Mc", persent:5}];

        public function LoadingScreen(param1:DisplayObjectContainer)
        {
            this._parent = param1;
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Loading.swf", "Loading1Mc");
            this._isoBaseMc = new InStayOut(this._baseMc);
            this._parent.addChild(this._baseMc);
            this._aCharacterNullMc = [this._baseMc.chrNull1, this._baseMc.chrNull2, this._baseMc.chrNull3, this._baseMc.chrNull4, this._baseMc.chrNull5];
            this._aCharacterIsoMc = [];
            this._aCharacterMc = [];
            this._loadwait = 0;
            this._wait = 0;
            this._bEnd = false;
            this.setProgressGauge(0);
            this.setPhase(PHASE_OPEN);
            return;
        }// end function

        public function release() : void
        {
            this.removeCharacterIsoMc();
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            if (this._isoBaseMc)
            {
                this._isoBaseMc.release();
            }
            this._isoBaseMc = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case PHASE_OPEN:
                {
                    this.controlOpen(param1);
                    break;
                }
                case PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                case PHASE_CHARACTER_IN:
                {
                    this.controlCharacterIn();
                    break;
                }
                case PHASE_CHARACTER_OUT:
                {
                    this.controlCharacterOut();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._isoBaseMc && this._isoBaseMc.bOpened)
            {
                this._loadwait = this._loadwait + param1;
            }
            if (this._fade)
            {
                this._fade.control(param1);
            }
            return;
        }// end function

        public function setProgressGauge(param1:Number) : void
        {
            if (this._baseMc.mcLoadGauge)
            {
                this._baseMc.mcLoadGauge.mcGauge.scaleX = param1;
            }
            return;
        }// end function

        public function close() : void
        {
            if (this._loadwait > LOADING_TIME && this._isoBaseMc.bOpened)
            {
                this.setPhase(PHASE_CLOSE);
            }
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    case PHASE_CHARACTER_IN:
                    {
                        this.phaseCharacterIn();
                        break;
                    }
                    case PHASE_CHARACTER_STAY:
                    {
                        this.phaseCharacterStay();
                        break;
                    }
                    case PHASE_CHARACTER_OUT:
                    {
                        this.phaseCharacterOut();
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

        private function createMember() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_1:* = "rollKickCoppelia1";
            for each (_loc_2 in _loadingCharacter)
            {
                
                _loc_3 = Random.range(0, 100);
                if (_loc_3 < _loc_2.persent)
                {
                    _loc_1 = _loc_2.label;
                    break;
                }
            }
            if ((this._aCharacterIsoMc.length + 1) <= this._aCharacterNullMc.length)
            {
                _loc_4 = this._aCharacterNullMc[this._aCharacterIsoMc.length];
                _loc_5 = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Loading.swf", _loc_1);
                _loc_6 = new InStayOut(_loc_5);
                _loc_4.addChild(_loc_5);
                this._aCharacterMc.push(_loc_5);
                this._aCharacterIsoMc.push(_loc_6);
                this._targetIsoMc = _loc_6;
                this._targetIsoMc.setIn();
            }
            else
            {
                Assert.print("ローディングで想定以上のキャラクターが設定されました");
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._isoBaseMc.setIn();
            return;
        }// end function

        private function controlOpen(param1:Number) : void
        {
            if (this._isoBaseMc.bOpened)
            {
                this.setPhase(PHASE_CHARACTER_IN);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._isoBaseMc.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoBaseMc.bEnd)
            {
                this._bEnd = true;
                this.setPhase(PHASE_NONE);
            }
            return;
        }// end function

        private function phaseCharacterIn() : void
        {
            this.createMember();
            return;
        }// end function

        private function controlCharacterIn() : void
        {
            if (this._targetIsoMc.bOpened)
            {
                this.setPhase(PHASE_CHARACTER_STAY);
            }
            return;
        }// end function

        private function phaseCharacterStay() : void
        {
            if (this._aCharacterIsoMc.length < 5)
            {
                this.setPhase(PHASE_CHARACTER_IN);
            }
            else
            {
                this.setPhase(PHASE_CHARACTER_OUT);
            }
            return;
        }// end function

        private function phaseCharacterOut() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aCharacterIsoMc)
            {
                
                _loc_1.setOut();
            }
            return;
        }// end function

        private function controlCharacterOut() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = true;
            for each (_loc_2 in this._aCharacterIsoMc)
            {
                
                if (_loc_2.bAnimetion)
                {
                    _loc_1 = false;
                    break;
                }
            }
            if (_loc_1)
            {
                this.removeCharacterIsoMc();
                this.setPhase(PHASE_CHARACTER_IN);
            }
            return;
        }// end function

        private function removeCharacterIsoMc() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._aCharacterIsoMc)
            {
                
                _loc_1.release();
            }
            this._aCharacterIsoMc = [];
            for each (_loc_2 in this._aCharacterMc)
            {
                
                if (_loc_2 && _loc_2.parent)
                {
                    _loc_2.parent.removeChild(_loc_2);
                }
            }
            this._aCharacterMc = [];
            return;
        }// end function

    }
}
