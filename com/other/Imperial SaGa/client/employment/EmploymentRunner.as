package employment
{
    import flash.display.*;
    import flash.geom.*;
    import player.*;
    import sound.*;
    import utility.*;

    public class EmploymentRunner extends Object
    {
        private var _phase:int;
        private var _bRunSEend:Boolean = true;
        private var _mcBase:MovieClip;
        private var _mcJump:MovieClip;
        private var _mcRunnerAnimation:MovieClip;
        private var _runnerDisplay:EmploymentRunnerDisplay;
        private var _jumpPlayerDisplay:EmploymentRunnerDisplay;
        private var _jumpStartPoint:Point;
        private var _animationNo:int;
        private var _lastActionLabel:String;
        private var counter:int = 0;
        private static const _aSeList:Array = [new LabelSe("se1101", SoundId.SE_REV_TRAIN_JUMP2), new LabelSe("se1102", SoundId.SE_REV_TRAIN_JUMP2), new LabelSe("se1103", SoundId.SE_REV_TRAIN_JUMP2), new LabelSe("se1201", SoundId.SE_REV_TRAIN_JUMPCHARGE), new LabelSe("se1301", SoundId.SE_REV_TRAIN_BIGJUMP), new LabelSe("se1401", SoundId.SE_REV_TRAIN_BANE), new LabelSe("se1501", SoundId.SE_REV_TRAIN_MISS2), new LabelSe("se1601", SoundId.SE_REV_TRAIN_GRANDIN), new LabelSe("se1701", SoundId.SE_REV_TRAIN_UNDERGROUND), new LabelSe("se1801", SoundId.SE_REV_TRAIN_GRANDOUT), new LabelSe("se1901", SoundId.SE_REV_TRAIN_MISS), new LabelSe("se2001", SoundId.SE_REV_TRAIN_CHAKUCHI), new LabelSe("se2101", SoundId.SE_REV_TRAIN_OTOSHIANA), new LabelSe("se2201", SoundId.SE_REV_TRAIN_CLIMB), new LabelSe("se2202", SoundId.SE_REV_TRAIN_CLIMB), new LabelSe("se2203", SoundId.SE_REV_TRAIN_CLIMB), new LabelSe("se2204", SoundId.SE_REV_TRAIN_CLIMB), new LabelSe("se2301", SoundId.SE_REV_TRAIN_FLY), new LabelSe("se2401", SoundId.SE_REV_TRAIN_MISS), new LabelSe("se2501", SoundId.SE_REV_TRAIN_CHARGE), new LabelSe("se2601", SoundId.SE_REV_TRAIN_OTOSHIANA), new LabelSe("se2701", SoundId.SE_REV_TRAIN_JUMP)];
        private static const _PHASE_STOP:int = 0;
        private static const _PHASE_JUMP:int = 1;
        private static const _PHASE_READY:int = 2;
        private static const _PHASE_RUNNING:int = 3;
        private static const _PHASE_OVER:int = 4;
        private static var _aWinAnimationNo:Array = [];
        private static var _aLoseAnimationNo:Array = [];
        private static var _bInitWinLoseAnimation:Boolean = false;

        public function EmploymentRunner(param1:MovieClip, param2:MovieClip, param3:int)
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            this._mcBase = param1;
            this._mcJump = param2;
            this._mcBase.gotoAndStop(1);
            this._mcRunnerAnimation = null;
            this._runnerDisplay = null;
            this._jumpPlayerDisplay = new EmploymentRunnerDisplay(this._mcJump, param3);
            this._jumpStartPoint = new Point(this._mcJump.x, this._mcJump.y);
            this._animationNo = Constant.UNDECIDED;
            if (!_bInitWinLoseAnimation)
            {
                _aWinAnimationNo = [];
                _aLoseAnimationNo = [];
                _loc_4 = this._mcBase.currentLabels;
                for each (_loc_5 in _loc_4)
                {
                    
                    if (_loc_5.name.lastIndexOf("_win") != -1)
                    {
                        _aWinAnimationNo.push(_loc_5.frame);
                        continue;
                    }
                    _aLoseAnimationNo.push(_loc_5.frame);
                }
                _bInitWinLoseAnimation = true;
            }
            this.setPhase(_PHASE_STOP);
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._runnerDisplay.mc;
        }// end function

        public function get animationNo() : int
        {
            return this._animationNo;
        }// end function

        public function release() : void
        {
            if (this._runnerDisplay)
            {
                this._runnerDisplay.release();
            }
            this._runnerDisplay = null;
            if (this._jumpPlayerDisplay)
            {
                this._jumpPlayerDisplay.release();
            }
            this._jumpPlayerDisplay = null;
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
                case _PHASE_JUMP:
                {
                    this.initPhaseJump();
                    break;
                }
                case _PHASE_READY:
                {
                    this.initPhaseReady();
                    break;
                }
                case _PHASE_RUNNING:
                {
                    this.initPhaseRunning();
                    break;
                }
                case _PHASE_OVER:
                {
                    this.initPhaseOver();
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
                case _PHASE_JUMP:
                {
                    this.controlPhaseJump(param1);
                    break;
                }
                case _PHASE_READY:
                {
                    this.controlPhaseReady(param1);
                    break;
                }
                case _PHASE_RUNNING:
                {
                    this.controlPhaseRunning(param1);
                    break;
                }
                case _PHASE_OVER:
                {
                    this.controlPhaseOver(param1);
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

        private function initPhaseJump() : void
        {
            var _loc_1:* = this._mcRunnerAnimation.chrNull;
            var _loc_2:* = this._mcBase.localToGlobal(new Point());
            var _loc_3:* = new Point(this._mcBase.x + _loc_1.x - this._jumpStartPoint.x, this._mcBase.y - this._jumpStartPoint.y);
            this._jumpPlayerDisplay.pos = new Point();
            this._runnerDisplay.mc.visible = false;
            this._jumpPlayerDisplay.mc.visible = true;
            this._jumpPlayerDisplay.setTargetJump(_loc_3);
            this._mcRunnerAnimation.gotoAndStop("stay2");
            return;
        }// end function

        private function controlPhaseJump(param1:Number) : void
        {
            if (this._jumpPlayerDisplay)
            {
                this._jumpPlayerDisplay.control(param1);
            }
            return;
        }// end function

        private function initPhaseReady() : void
        {
            this._jumpPlayerDisplay.setAnimationWithCallback(PlayerDisplay.LABEL_STATUS_UP, function () : void
            {
                this.setAnimation("wait");
                return;
            }// end function
            );
            return;
        }// end function

        private function controlPhaseReady(param1:Number) : void
        {
            if (this._runnerDisplay)
            {
                this._runnerDisplay.control(param1);
            }
            return;
        }// end function

        private function initPhaseRunning() : void
        {
            this._runnerDisplay.mc.visible = true;
            this._jumpPlayerDisplay.mc.visible = false;
            this._lastActionLabel = "";
            this._mcRunnerAnimation.gotoAndPlay("runStart");
            this._runnerDisplay.setAnimation(PlayerDisplay.LABEL_SIDE_DASH);
            return;
        }// end function

        private function SEstepEnd() : void
        {
            this._bRunSEend = true;
            return;
        }// end function

        private function controlPhaseRunning(param1:Number) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this.counter + 1;
            _loc_2.counter = _loc_3;
            this.controlSoundE();
            if (this._mcRunnerAnimation.currentLabel != this._lastActionLabel)
            {
                if (this.isSeLabel(this._mcRunnerAnimation.currentLabel))
                {
                    return;
                }
                if (this._mcRunnerAnimation.currentLabel == "end")
                {
                    this.setPhase(_PHASE_OVER);
                    return;
                }
                if (this._mcRunnerAnimation.currentLabel == "runStart")
                {
                    this._runnerDisplay.setAnimation(PlayerDisplay.LABEL_SIDE_DASH);
                }
                else if (this._mcRunnerAnimation.currentLabel == "goal")
                {
                    if (_aWinAnimationNo.indexOf(this._animationNo) != -1)
                    {
                        this._runnerDisplay.setAnimation(EmploymentRunnerDisplay.LABEL_WIN_POSE);
                    }
                }
                else
                {
                    this._runnerDisplay.setAnimation(this._mcRunnerAnimation.currentLabel);
                }
                this._lastActionLabel = this._mcRunnerAnimation.currentLabel;
            }
            if (this._runnerDisplay)
            {
                this._runnerDisplay.control(param1);
            }
            if (PlayerManager.getInstance().cmpRaritySuperRare(this._runnerDisplay.info.rarity) < 0 && this._runnerDisplay.iconRarity.mc.alpha > 0)
            {
                this._runnerDisplay.iconRarity.mc.alpha = this._runnerDisplay.iconRarity.mc.alpha - param1 * 5;
                if (this._runnerDisplay.iconRarity.mc.alpha < 0)
                {
                    this._runnerDisplay.iconRarity.mc.alpha = 0;
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
            if (this._runnerDisplay)
            {
                this._runnerDisplay.control(param1);
            }
            return;
        }// end function

        public function setAnimationNo(param1:int) : void
        {
            if (param1 < 0 && param1 >= _aWinAnimationNo.length + _aLoseAnimationNo.length)
            {
                param1 = 0;
            }
            this._animationNo = param1;
            this._mcBase.gotoAndStop(this._animationNo);
            this._mcRunnerAnimation = this._mcBase["runner" + (this._animationNo >= 10 ? (this._animationNo) : ("0" + this._animationNo))];
            this._mcRunnerAnimation.gotoAndStop("stop");
            if (this._runnerDisplay)
            {
                this._runnerDisplay.release();
            }
            this._runnerDisplay = null;
            this._runnerDisplay = new EmploymentRunnerDisplay(this._mcRunnerAnimation.chrNull, Constant.EMPTY_ID);
            return;
        }// end function

        public function setId(param1:int) : void
        {
            if (this._runnerDisplay)
            {
                this._runnerDisplay.setId(param1, Constant.EMPTY_ID);
            }
            this._jumpPlayerDisplay.setId(param1, Constant.EMPTY_ID);
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(this._runnerDisplay.info.id);
            this._runnerDisplay.iconRarity.setRarity(_loc_2.rarity);
            this._runnerDisplay.iconRarity.mc.alpha = 1;
            this._jumpPlayerDisplay.iconRarity.setRarity(_loc_2.rarity);
            return;
        }// end function

        public function isWinAnimation() : Boolean
        {
            return _aWinAnimationNo.indexOf(this._animationNo) != -1;
        }// end function

        public function isEndJump() : Boolean
        {
            return !(this._phase == _PHASE_JUMP && this._jumpPlayerDisplay.bMoveing);
        }// end function

        public function jump() : void
        {
            this.setPhase(_PHASE_JUMP);
            return;
        }// end function

        public function ready() : void
        {
            this.setPhase(_PHASE_READY);
            return;
        }// end function

        public function run() : void
        {
            this.setPhase(_PHASE_RUNNING);
            return;
        }// end function

        public function effectStart() : void
        {
            if (this._mcRunnerAnimation.currentLabel == "goal")
            {
                this._mcRunnerAnimation.gotoAndPlay("effStart");
            }
            return;
        }// end function

        public function out() : void
        {
            this._mcRunnerAnimation.gotoAndPlay("out");
            return;
        }// end function

        private function controlSoundE() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _aSeList)
            {
                
                if (this._mcRunnerAnimation.currentFrameLabel == _loc_1.label)
                {
                    if (_loc_1.seId != Constant.EMPTY_ID)
                    {
                        SoundManager.getInstance().playSe(_loc_1.seId);
                    }
                    break;
                }
            }
            return;
        }// end function

        private function isSeLabel(param1:String) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in _aSeList)
            {
                
                if (param1 == _loc_2.label)
                {
                    return true;
                }
            }
            if (param1 == "se1001" || param1 == "se1002" || param1 == "se1003")
            {
                return true;
            }
            return false;
        }// end function

        public static function get numWinAnimation() : int
        {
            return _aWinAnimationNo.length;
        }// end function

        public static function getWinAnimationNo(param1:int) : int
        {
            if (param1 < 0 && param1 >= _aWinAnimationNo.length)
            {
                param1 = 0;
            }
            return _aWinAnimationNo[param1];
        }// end function

        public static function get numLoseAnimation() : int
        {
            return _aLoseAnimationNo.length;
        }// end function

        public static function getLoseAnimationNo(param1:int) : int
        {
            if (param1 < 0 && param1 >= _aLoseAnimationNo.length)
            {
                param1 = 0;
            }
            return _aLoseAnimationNo[param1];
        }// end function

        public static function resetWinLoseAnimation() : void
        {
            _bInitWinLoseAnimation = false;
            return;
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in _aSeList)
            {
                
                ArrayUtil.uniquePushId(_loc_1, _loc_2.seId);
            }
            return _loc_1;
        }// end function

    }
}
