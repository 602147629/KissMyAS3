package employment
{
    import flash.display.*;
    import player.*;
    import sound.*;
    import utility.*;

    public class EmploymentFighter extends Object
    {
        private var _phase:int;
        private var playerType:int;
        private var _mcBase:MovieClip;
        private var _mcFighterAnimation:MovieClip;
        private var _isoFighter:InStayOut;
        private var _fighterDisplay:EmploymentFighterDisplay;
        private var _animationNo:int;
        private var _lastActionLabel:String;
        private var _isStay:Boolean;
        private var _isFinish:Boolean;
        private var _isOut:Boolean;
        private var _isEnd:Boolean;
        private static const _PHASE_STOP:int = 0;
        private static const _PHASE_IN:int = 1;
        private static const _PHASE_READY:int = 2;
        private static const _PHASE_FIGHTING:int = 3;
        private static const _PHASE_OVER:int = 4;
        private static const _PHASE_OUT:int = 5;
        public static const LABEL_START:String = "start";
        public static const LABEL_FINISH:String = "finish";

        public function EmploymentFighter(param1:MovieClip)
        {
            this._mcBase = param1;
            this._isFinish = false;
            this._isOut = false;
            this._mcBase.gotoAndStop(1);
            this._mcFighterAnimation = null;
            this._fighterDisplay = null;
            this._animationNo = Constant.UNDECIDED;
            this.setPhase(_PHASE_STOP);
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._fighterDisplay.mc;
        }// end function

        public function get animationNo() : int
        {
            return this._animationNo;
        }// end function

        public function isStay() : Boolean
        {
            return this._isoFighter && this._isoFighter.bOpened;
        }// end function

        public function isFinish() : Boolean
        {
            return this._isFinish;
        }// end function

        public function isOut() : Boolean
        {
            return this._isOut;
        }// end function

        public function isEnd() : Boolean
        {
            return this._isoFighter && this._isoFighter.bEnd;
        }// end function

        public function release() : void
        {
            if (this._fighterDisplay)
            {
                this._fighterDisplay.release();
            }
            this._fighterDisplay = null;
            if (this._isoFighter)
            {
                this._isoFighter.release();
            }
            this._isoFighter = null;
            this._mcBase = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_STOP:
                {
                    this.initPhaseStop();
                    break;
                }
                case _PHASE_IN:
                {
                    this.initPhaseIn();
                    break;
                }
                case _PHASE_READY:
                {
                    this.initPhaseReady();
                    break;
                }
                case _PHASE_FIGHTING:
                {
                    this.initPhaseFighting();
                    break;
                }
                case _PHASE_OVER:
                {
                    this.initPhaseOver();
                    break;
                }
                case _PHASE_OUT:
                {
                    this.initPhaseOut();
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
                case _PHASE_IN:
                {
                    this.controlPhaseIn(param1);
                    break;
                }
                case _PHASE_READY:
                {
                    this.controlPhaseReady(param1);
                    break;
                }
                case _PHASE_FIGHTING:
                {
                    this.controlPhaseFighting(param1);
                    break;
                }
                case _PHASE_OVER:
                {
                    this.controlPhaseOver(param1);
                    break;
                }
                case _PHASE_OUT:
                {
                    this.controlPhaseOut(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initPhaseStop() : void
        {
            return;
        }// end function

        private function initPhaseIn() : void
        {
            this._fighterDisplay.mc.visible = true;
            this._isoFighter.setIn();
            this._lastActionLabel = "";
            return;
        }// end function

        private function controlPhaseIn(param1:Number) : void
        {
            this.controlSoundE();
            if (this._mcFighterAnimation.currentLabel != "stop" && this._mcFighterAnimation.currentLabel != "in" && this._mcFighterAnimation.currentLabel != "stay")
            {
                if (this._mcFighterAnimation.currentLabel != this._lastActionLabel)
                {
                    switch(this._mcFighterAnimation.currentLabel)
                    {
                        case "se1001":
                        {
                            return;
                        }
                        case "se1002":
                        {
                            return;
                        }
                        case "se1003":
                        {
                            return;
                        }
                        case "se1101":
                        {
                            return;
                        }
                        case "se1201":
                        {
                            return;
                        }
                        case "se1301":
                        {
                            return;
                        }
                        case "se1401":
                        {
                            return;
                        }
                        case "se1501":
                        {
                            return;
                        }
                        case "se1601":
                        {
                            return;
                        }
                        case "se1701":
                        {
                            return;
                        }
                        default:
                        {
                            this._fighterDisplay.setAnimation(this._mcFighterAnimation.currentLabel);
                            break;
                            break;
                        }
                    }
                    this._lastActionLabel = this._mcFighterAnimation.currentLabel;
                }
            }
            return;
        }// end function

        private function initPhaseReady() : void
        {
            return;
        }// end function

        private function controlPhaseReady(param1:Number) : void
        {
            if (this._fighterDisplay)
            {
                this._fighterDisplay.control(param1);
            }
            return;
        }// end function

        private function initPhaseFighting() : void
        {
            this._fighterDisplay.mc.visible = true;
            this._lastActionLabel = "";
            this._mcFighterAnimation.gotoAndPlay(LABEL_START);
            return;
        }// end function

        private function controlPhaseFighting(param1:Number) : void
        {
            this.controlSoundE();
            if (this._mcFighterAnimation.currentLabel != this._lastActionLabel)
            {
                switch(this._mcFighterAnimation.currentLabel)
                {
                    case LABEL_FINISH:
                    {
                        this._isFinish = true;
                        return;
                    }
                    case LABEL_START:
                    {
                        this._fighterDisplay.setAnimation("wait");
                        break;
                    }
                    case "se1001":
                    {
                        return;
                    }
                    case "se1002":
                    {
                        return;
                    }
                    case "se1003":
                    {
                        return;
                    }
                    case "se1101":
                    {
                        return;
                    }
                    case "se1201":
                    {
                        return;
                    }
                    case "se1301":
                    {
                        return;
                    }
                    case "se1401":
                    {
                        return;
                    }
                    case "se1501":
                    {
                        return;
                    }
                    case "se1601":
                    {
                        return;
                    }
                    case "se1701":
                    {
                        return;
                    }
                    default:
                    {
                        this._fighterDisplay.setAnimation(this._mcFighterAnimation.currentLabel);
                        break;
                        break;
                    }
                }
                this._lastActionLabel = this._mcFighterAnimation.currentLabel;
            }
            if (this._fighterDisplay)
            {
                this._fighterDisplay.control(param1);
            }
            if (PlayerManager.getInstance().cmpRarityRare(this._fighterDisplay.info.rarity) < 0 && this._fighterDisplay.iconRarity.mc.alpha > 0)
            {
                this._fighterDisplay.iconRarity.mc.alpha = this._fighterDisplay.iconRarity.mc.alpha - param1 * 5;
                if (this._fighterDisplay.iconRarity.mc.alpha < 0)
                {
                    this._fighterDisplay.iconRarity.mc.alpha = 0;
                }
            }
            return;
        }// end function

        private function initPhaseOver() : void
        {
            return;
        }// end function

        private function controlPhaseOver(param1:Number) : void
        {
            this.controlSoundE();
            if (this._fighterDisplay)
            {
                this._fighterDisplay.control(param1);
            }
            return;
        }// end function

        private function initPhaseOut() : void
        {
            this._isoFighter.setOut();
            this._fighterDisplay.mc.visible = true;
            this._mcFighterAnimation.play();
            return;
        }// end function

        private function controlPhaseOut(param1:Number) : void
        {
            this.controlSoundE();
            if (this._mcFighterAnimation.currentLabel != "out" && this._mcFighterAnimation.currentLabel != "end")
            {
                if (this._mcFighterAnimation.currentLabel != this._lastActionLabel)
                {
                    switch(this._mcFighterAnimation.currentLabel)
                    {
                        case "se1001":
                        {
                            return;
                        }
                        case "se1002":
                        {
                            return;
                        }
                        case "se1003":
                        {
                            return;
                        }
                        case "se1101":
                        {
                            return;
                        }
                        case "se1201":
                        {
                            return;
                        }
                        case "se1301":
                        {
                            return;
                        }
                        case "se1401":
                        {
                            return;
                        }
                        case "se1501":
                        {
                            return;
                        }
                        case "se1601":
                        {
                            return;
                        }
                        case "se1701":
                        {
                            return;
                        }
                        default:
                        {
                            this._fighterDisplay.setAnimation(this._mcFighterAnimation.currentLabel);
                            break;
                            break;
                        }
                    }
                    this._lastActionLabel = this._mcFighterAnimation.currentLabel;
                }
            }
            if (this._mcFighterAnimation.currentLabel == "end")
            {
                this.setPhase(_PHASE_STOP);
            }
            return;
        }// end function

        private function controlSoundE() : void
        {
            switch(this._mcFighterAnimation.currentFrameLabel)
            {
                case "se1001":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_ATTACK);
                    return;
                }
                case "se1002":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_ATTACK);
                    return;
                }
                case "se1003":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_ATTACK);
                    return;
                }
                case "se1101":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_FINALATTACK);
                    return;
                }
                case "se1201":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_034JUMP);
                    return;
                }
                case "se1301":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_SPINLONG);
                    return;
                }
                case "se1401":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_SUNAKEMURI);
                    return;
                }
                case "se1501":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_SPINSHORT);
                    return;
                }
                case "se1601":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_MANYPUNCH);
                    return;
                }
                case "se1701":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_BIGPUNCH);
                    return;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function setAnimationNo(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            this.playerType = param3;
            if (this._fighterDisplay)
            {
                this._fighterDisplay.release();
            }
            this._fighterDisplay = null;
            if (this._isoFighter)
            {
                this._isoFighter.release();
            }
            this._isoFighter = null;
            if (param1 < 0 && param1 >= this._mcBase.currentLabels.length)
            {
                param1 = 0;
            }
            this._animationNo = param1;
            this._mcBase.gotoAndStop(this._animationNo);
            this._mcFighterAnimation = this._mcBase["anim" + (this._animationNo >= 10 ? (this._animationNo) : ("0" + this._animationNo))];
            this._mcFighterAnimation.gotoAndStop("stop");
            this._isoFighter = new InStayOut(this._mcFighterAnimation);
            this._fighterDisplay = new EmploymentFighterDisplay(this._mcFighterAnimation.chrNull, Constant.EMPTY_ID);
            this._fighterDisplay.setId(param2, Constant.EMPTY_ID);
            if (this._fighterDisplay.info)
            {
                _loc_4 = PlayerManager.getInstance().getPlayerInformation(this._fighterDisplay.info.id);
                if (param3 == 1)
                {
                    this._fighterDisplay.RarityParent.scaleX = -1;
                    this._fighterDisplay.iconRarity.setRarity(_loc_4.rarity);
                    this._fighterDisplay.iconRarity.mc.alpha = 1;
                }
                else
                {
                    this._fighterDisplay.iconRarity.setRarity(_loc_4.rarity);
                    this._fighterDisplay.iconRarity.mc.alpha = 1;
                }
            }
            return;
        }// end function

        public function setIn() : void
        {
            this.setPhase(_PHASE_IN);
            return;
        }// end function

        public function setFight() : void
        {
            this.setPhase(_PHASE_FIGHTING);
            return;
        }// end function

        public function setOut() : void
        {
            this.setPhase(_PHASE_OUT);
            return;
        }// end function

    }
}
