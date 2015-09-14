package battle
{
    import character.*;
    import flash.display.*;
    import flash.geom.*;
    import player.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class BattlePlayerDead extends Object
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
        private var _baseMc:MovieClip;
        private var _isoBase:InStayOut;
        private var _lpNumMc:MovieClip;
        private var _isoLp:InStayOut;
        private var _beforeLpNumMc:MovieClip;
        private var _afterLpNumMc:MovieClip;
        private var _card:Bitmap;
        private var _playerDisplay:PlayerDisplay;
        private var _waitTime:Number;
        private var _currentLp:int;
        private var _bEmperor:Boolean;

        public function BattlePlayerDead(param1:DisplayObjectContainer, param2:PlayerDisplay, param3:int, param4:Boolean, param5:Boolean)
        {
            var _loc_6:* = null;
            this._currentLp = param3;
            this._bEmperor = param5;
            if (param5)
            {
                this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", "EmperorDieMc");
            }
            else if (param4)
            {
                this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", "guardLPdam1Mc");
            }
            else
            {
                this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", param3 == 0 ? ("charaLostMc") : ("charaDieMc"));
            }
            this._isoBase = new InStayOut(this._baseMc);
            this._baseMc.x = param2.pos.x;
            this._baseMc.y = param2.pos.y;
            if (param5)
            {
                this._lpNumMc = null;
                if (this._baseMc.lpDamMc)
                {
                    this._baseMc.lpDamMc.visible = false;
                }
            }
            else
            {
                this._lpNumMc = this._baseMc.lpDamMc;
            }
            if (this._lpNumMc)
            {
                this._isoLp = new InStayOut(this._lpNumMc);
                this.createLpDisp(param3, param4);
            }
            else
            {
                this._isoLp = null;
            }
            this._playerDisplay = param2;
            this._playerDisplay.backupParent();
            this._playerDisplay.setAnimationPattern(this._baseMc);
            if (this._baseMc.getChildByName("CardSNull"))
            {
                this._card = ResourceManager.getInstance().createBitmap(ResourcePath.CARD_SMALL_PATH + CharacterConstant.ID_CARD + this._playerDisplay.info.cardFileName);
                _loc_6 = new Matrix();
                _loc_6.translate((-this._card.width) / 2, (-this._card.height) / 2);
                this._card.transform.matrix = _loc_6;
                this._card.smoothing = true;
                this._baseMc.CardSNull.addChild(this._card);
            }
            else
            {
                param2.setAnimationPattern(this._baseMc);
            }
            param1.addChild(this._baseMc);
            this._waitTime = 0;
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoBase.bClosed;
        }// end function

        public function createLpDisp(param1:int, param2:Boolean) : void
        {
            this._beforeLpNumMc = this._lpNumMc.Num2ketaMc;
            this._afterLpNumMc = param1 == 0 ? (this._lpNumMc.Num2ketaMc3) : (this._lpNumMc.Num2ketaMc2);
            var _loc_3:* = param1 != 0 ? (this._lpNumMc.Num2ketaMc3) : (this._lpNumMc.Num2ketaMc2);
            _loc_3.visible = false;
            this.setLpDisp(this._beforeLpNumMc, param1 + (param2 ? (0) : (1)));
            this.setLpDisp(this._afterLpNumMc, param1, param2);
            return;
        }// end function

        public function setLpDisp(param1:MovieClip, param2:int, param3:Boolean = false) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_4:* = param2 == 0 ? (this._DISP_COLOR_RED) : (this._DISP_COLOR_WHITE);
            if (param3)
            {
                _loc_4 = this._DISP_COLOR_BLUE;
            }
            var _loc_5:* = 0;
            while (_loc_5 < param1.numChildren)
            {
                
                _loc_6 = param1.getChildByName("n" + _loc_5.toString()) as MovieClip;
                if (_loc_6 != null)
                {
                    _loc_6.gotoAndStop(_loc_4);
                    _loc_7 = param2 % 10;
                    _loc_6.visible = _loc_5 == 0 || param2 != 0;
                    _loc_6.battleNum.gotoAndStop((_loc_7 + 1));
                }
                param2 = param2 / 10;
                _loc_5++;
            }
            return;
        }// end function

        public function release() : void
        {
            if (this._isoLp)
            {
                this._isoLp.release();
            }
            this._isoLp = null;
            if (this._isoBase)
            {
                this._isoBase.release();
            }
            this._isoBase = null;
            if (this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
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

        private function phaseOpen() : void
        {
            this._isoBase.setIn();
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_LP_DISP);
            }
            return;
        }// end function

        private function phaseLpDisp() : void
        {
            if (this._isoLp)
            {
                this._isoLp.setIn();
            }
            else
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            return;
        }// end function

        private function controlLpDisp(param1:Number) : void
        {
            if (this._isoLp.bOpened)
            {
                this._waitTime = this._waitTime + param1;
                if (this._waitTime > this._LP_WAIT_TIME)
                {
                    this._waitTime = 0;
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
            this._isoBase.setOut();
            this._playerDisplay.setAnimDead();
            if (this._currentLp == 0 && !this._bEmperor)
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_LOST_BREAK);
            }
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoBase.bClosed)
            {
                this._playerDisplay.setAnimDead();
            }
            return;
        }// end function

    }
}
