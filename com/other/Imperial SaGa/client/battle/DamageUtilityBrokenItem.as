package battle
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;
    import utility.*;

    public class DamageUtilityBrokenItem extends DamageUtility
    {
        private const _LP_WAIT_TIME:Number = 1;
        private const _DISP_COLOR_WHITE:int = 1;
        private const _DISP_COLOR_GREEN:int = 2;
        private const _DISP_COLOR_RED:int = 3;
        private const _DISP_COLOR_BLUE:int = 4;
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_LP_DISP:int = 10;
        private const _PHASE_WAIT:int = 20;
        private const _PHASE_CLOSE:int = 99;
        private var _phase:int;
        private var _lpNumMc:MovieClip;
        private var _isoLp:InStayOut;
        private var _beforeLpNumMc:MovieClip;
        private var _afterLpNumMc:MovieClip;

        public function DamageUtilityBrokenItem(param1:DisplayObjectContainer, param2:DamageData, param3:Point, param4:String = "normal")
        {
            super(param1, param2, param3, param4);
            return;
        }// end function

        override protected function createLpDamage(param1:DamageData, param2:String) : MovieClip
        {
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", "guardLPdam2Mc");
            this._lpNumMc = _loc_3.lpDamMc;
            this._isoLp = new InStayOut(this._lpNumMc);
            this.createLpDisp(0);
            _waitTime = this._LP_WAIT_TIME;
            this.setPhase(this._PHASE_OPEN);
            return _loc_3;
        }// end function

        override public function release() : void
        {
            if (this._isoLp)
            {
                this._isoLp.release();
            }
            super.release();
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_LP_DISP:
                {
                    this.controlLpDisp(param1);
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait();
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
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_LP_DISP:
                    {
                        this.phaseLpDisp();
                        break;
                    }
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
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

        public function createLpDisp(param1:int) : void
        {
            this._beforeLpNumMc = this._lpNumMc.Num2ketaMc;
            this.setLpDisp(this._beforeLpNumMc, 0);
            return;
        }// end function

        public function setLpDisp(param1:MovieClip, param2:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_3:* = param2 == 0 ? (this._DISP_COLOR_BLUE) : (this._DISP_COLOR_RED);
            var _loc_4:* = 0;
            while (_loc_4 < param1.numChildren)
            {
                
                _loc_5 = param1.getChildByName("n" + _loc_4.toString()) as MovieClip;
                if (_loc_5 != null)
                {
                    _loc_5.gotoAndStop(_loc_3);
                    _loc_6 = param2 % 10;
                    _loc_5.visible = _loc_4 == 0 || param2 != 0;
                    _loc_5.battleNum.gotoAndStop((_loc_6 + 1));
                }
                param2 = param2 / 10;
                _loc_4++;
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            return;
        }// end function

        private function controlOpen() : void
        {
            if (_isoMain.bOpened)
            {
                this.setPhase(this._PHASE_LP_DISP);
            }
            return;
        }// end function

        private function phaseLpDisp() : void
        {
            this._isoLp.setIn();
            return;
        }// end function

        private function controlLpDisp(param1:Number) : void
        {
            if (this._isoLp.bOpened)
            {
                _waitTime = _waitTime - param1;
                if (_waitTime <= 0)
                {
                    this.setPhase(this._PHASE_WAIT);
                }
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            this._isoLp.setOut();
            return;
        }// end function

        private function controlWait() : void
        {
            if (this._isoLp.bClosed)
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            _isoMain.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            if (_isoMain.bClosed)
            {
                _bEnd = true;
            }
            return;
        }// end function

    }
}
