package barracks
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import message.*;
    import player.*;
    import sound.*;
    import tutorial.*;
    import utility.*;

    public class BarracksBed extends Object
    {
        private var _state:int;
        public var _snoreLotList:LotList;
        private var _mcBase:MovieClip;
        private var _playerDisplay:PlayerDisplay;
        private var _personal:PlayerPersonal;
        private var _index:int;
        private var _cbOver:Function;
        private var _cbOut:Function;
        private var _cbInstantRestore:Function;
        private var _bedBtn:ButtonBase;
        private var _instantRestoreBtn:ButtonBase;
        private var _hpGreenGauge:Gauge;
        private var _hpRedGauge:Gauge;
        private var _spGauge:Gauge;
        private var _numMcRestoreTime:NumericNumberMc;
        private var _restoreTimeSec:uint;
        private var _maxTimeSec:uint;
        private var _bEnable:Boolean;
        private var _bFinish:Boolean;
        private var _snoreSeWait:Number;
        private static const _STATE_NOT_USE:int = 0;
        private static const _STATE_SLEEP_IN:int = 1;
        private static const _STATE_USING:int = 2;
        private static const _STATE_WAKEUP:int = 3;
        private static const _STATE_WAKEUP_END:int = 4;
        private static const _STATE_SLEEP_OUT:int = 5;
        private static const _SNORE_SE_INTERVAL:Number = 3;
        private static var _SNORE_SE_VOLUME_TABLE:LotList = null;

        public function BarracksBed(param1:MovieClip, param2:int, param3:Function = null, param4:Function = null, param5:Function = null)
        {
            this._mcBase = param1;
            this._index = param2;
            this._playerDisplay = new PlayerDisplay(this._mcBase.charaNull, Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._personal = null;
            this._bedBtn = new ButtonBase(this._mcBase.bedIconBtnMc, null, this.cbBedBtnOver, this.cbBedBtnOut);
            ButtonManager.getInstance().addButtonBase(this._bedBtn);
            this._bedBtn.enterSeId = Constant.UNDECIDED;
            this._instantRestoreBtn = null;
            this._cbOver = param3;
            this._cbOut = param4;
            this._cbInstantRestore = param5;
            this._hpGreenGauge = null;
            this._hpRedGauge = null;
            this._spGauge = null;
            this._numMcRestoreTime = new NumericNumberMc(this._mcBase.timeInfoMc.remainingTimeMc, 0, 0);
            this._restoreTimeSec = 0;
            this._maxTimeSec = 0;
            this._bEnable = false;
            this._bFinish = false;
            this._snoreSeWait = 0;
            this._snoreLotList = null;
            if (_SNORE_SE_VOLUME_TABLE == null)
            {
                _SNORE_SE_VOLUME_TABLE = new LotList();
                _SNORE_SE_VOLUME_TABLE.addTarget({vol:1}, 55);
                _SNORE_SE_VOLUME_TABLE.addTarget({vol:0.3}, 5);
                _SNORE_SE_VOLUME_TABLE.addTarget({vol:0.5}, 10);
                _SNORE_SE_VOLUME_TABLE.addTarget({vol:1.5}, 20);
                _SNORE_SE_VOLUME_TABLE.addTarget({vol:4}, 10);
            }
            TextControl.setIdText(this._mcBase.spotRemainingBtnMc.textMc.textDt, MessageId.BARRACKS_BUTTON_QUICK_RECOVER);
            this._state = _STATE_NOT_USE;
            return;
        }// end function

        public function get mcBase() : MovieClip
        {
            return this._mcBase;
        }// end function

        public function get personal() : PlayerPersonal
        {
            return this._personal;
        }// end function

        public function get uniqueId() : int
        {
            return this._personal ? (this._personal.uniqueId) : (Constant.EMPTY_ID);
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function get bedBtn() : ButtonBase
        {
            return this._bedBtn;
        }// end function

        public function get instantRestoreBtn() : ButtonBase
        {
            return this._instantRestoreBtn;
        }// end function

        public function isFinished() : Boolean
        {
            return this._bFinish;
        }// end function

        public function isInstantEnable() : Boolean
        {
            return this._restoreTimeSec > Constant.INSTANT_MARGIN_SEC;
        }// end function

        public function isUse() : Boolean
        {
            return this._state == _STATE_SLEEP_IN || this._state == _STATE_USING;
        }// end function

        public function isEmpty() : Boolean
        {
            return this._state == _STATE_NOT_USE || this._state == _STATE_SLEEP_OUT;
        }// end function

        public function isWakeupNow() : Boolean
        {
            return this._state == _STATE_WAKEUP;
        }// end function

        public function isWakeupEnd() : Boolean
        {
            return this._state == _STATE_WAKEUP_END;
        }// end function

        public function release() : void
        {
            if (this._bedBtn)
            {
                ButtonManager.getInstance().removeButton(this._bedBtn);
            }
            this._bedBtn = null;
            if (this._instantRestoreBtn)
            {
                ButtonManager.getInstance().removeButton(this._instantRestoreBtn);
            }
            this._instantRestoreBtn = null;
            if (this._hpGreenGauge)
            {
                this._hpGreenGauge.release();
            }
            this._hpGreenGauge = null;
            if (this._hpRedGauge)
            {
                this._hpRedGauge.release();
            }
            this._hpRedGauge = null;
            if (this._spGauge)
            {
                this._spGauge.release();
            }
            this._spGauge = null;
            if (this._playerDisplay)
            {
                this._playerDisplay.release();
            }
            this._playerDisplay = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._state)
            {
                case _STATE_NOT_USE:
                {
                    break;
                }
                case _STATE_SLEEP_IN:
                {
                    if (this._mcBase.currentLabel == "charaStay")
                    {
                        this._state = _STATE_USING;
                        if (this._instantRestoreBtn == null)
                        {
                            this._instantRestoreBtn = ButtonManager.getInstance().addButton(this._mcBase.spotRemainingBtnMc, this.cbInstantRestoreBtnClick);
                            this._instantRestoreBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
                        }
                        this.setDisable(!this._bEnable);
                    }
                    break;
                }
                case _STATE_USING:
                {
                    break;
                }
                case _STATE_WAKEUP:
                {
                    break;
                }
                case _STATE_WAKEUP_END:
                {
                    break;
                }
                case _STATE_SLEEP_OUT:
                {
                    if (this._mcBase.currentLabel == "end")
                    {
                        this._playerDisplay.setId(Constant.EMPTY_ID, Constant.EMPTY_ID);
                        this._mcBase.gotoAndStop("stop");
                        this._state = _STATE_NOT_USE;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function restStart(param1:PlayerPersonal, param2:uint, param3:uint, param4:Boolean = false) : void
        {
            if (param1 == null)
            {
                return;
            }
            this._personal = param1;
            this._personal.updateSp();
            this._playerDisplay.setId(this._personal.playerId, this._personal.uniqueId);
            this._playerDisplay.setAnimation(PlayerDisplay.LABEL_DEAD);
            this._restoreTimeSec = this.getRestoreSec(param2);
            this._maxTimeSec = param3;
            if (this._hpGreenGauge == null)
            {
                this._hpGreenGauge = new Gauge(this._mcBase.timeInfoMc.hpBerMc.hpBarGreenMc, this._personal.hpMax, 0);
            }
            else
            {
                this._hpGreenGauge.setMaxGauge(this._personal.hpMax);
            }
            if (this._hpRedGauge == null)
            {
                this._hpRedGauge = new Gauge(this._mcBase.timeInfoMc.hpBerMc.hpBarRedMc, this._personal.hpMax, 0);
            }
            else
            {
                this._hpRedGauge.setMaxGauge(this._personal.hpMax);
            }
            if (this._spGauge == null)
            {
                this._spGauge = new Gauge(this._mcBase.timeInfoMc.hpBerMc.spBarMc, this._personal.spMax, this._personal.sp);
            }
            else
            {
                this._spGauge.setMaxGauge(this._personal.spMax);
                this._spGauge.setGauge(this._personal.sp);
            }
            this.countTime(0);
            this._mcBase.gotoAndPlay(param4 ? ("charaStay") : ("charaIn"));
            this._mcBase.sleepEffectMc.gotoAndPlay(0);
            this._bFinish = this._restoreTimeSec <= 0;
            this._state = _STATE_SLEEP_IN;
            this.setupSnoring();
            return;
        }// end function

        public function wakeup() : void
        {
            this._mcBase.sleepEffectMc.gotoAndStop(0);
            this._restoreTimeSec = 0;
            this.countTime(0);
            this._spGauge.setGauge(this._personal.sp);
            this._playerDisplay.setReverse(false);
            this._playerDisplay.setAnimation(PlayerDisplay.LABEL_CROUCH);
            var timer:* = new Timer(300, 1);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, function (event:TimerEvent) : void
            {
                var event:* = event;
                SoundManager.getInstance().playSe(SoundId.SE_REV_INN_SPIN);
                _playerDisplay.setAnimationWithCallback(PlayerDisplay.LABEL_WIN, function () : void
                {
                    var newTimer:* = new Timer(300, 1);
                    newTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function (event:TimerEvent) : void
                    {
                        _state = _STATE_WAKEUP_END;
                        return;
                    }// end function
                    );
                    newTimer.start();
                    return;
                }// end function
                );
                return;
            }// end function
            );
            timer.start();
            if (this._instantRestoreBtn)
            {
                this._instantRestoreBtn.setDisable(true);
            }
            this._state = _STATE_WAKEUP;
            return;
        }// end function

        public function restEnd() : void
        {
            if (this._instantRestoreBtn)
            {
                this._instantRestoreBtn.setDisable(true);
            }
            this._mcBase.gotoAndPlay("charaOut");
            this._personal = null;
            this._state = _STATE_SLEEP_OUT;
            return;
        }// end function

        public function setDisable(param1:Boolean) : void
        {
            this._bEnable = !param1;
            if (this._bEnable && this._state == _STATE_USING)
            {
                this._bedBtn.setDisableFlag(false);
                if (this._instantRestoreBtn)
                {
                    this._instantRestoreBtn.setDisable(!this.isInstantEnable());
                }
            }
            else
            {
                this._bedBtn.setDisable(false);
                this._bedBtn.setDisableFlag(true);
                if (this._instantRestoreBtn)
                {
                    this._instantRestoreBtn.setDisable(true);
                }
            }
            return;
        }// end function

        private function updateButtonDisable() : void
        {
            var _loc_1:* = false;
            if (this._bEnable && this._state == _STATE_USING)
            {
                this._bedBtn.setDisableFlag(false);
                if (this._instantRestoreBtn)
                {
                    _loc_1 = this.isInstantEnable();
                    if (this._instantRestoreBtn.isEnable() != _loc_1)
                    {
                        this._instantRestoreBtn.setDisable(_loc_1);
                    }
                }
            }
            else
            {
                this._bedBtn.setDisable(false);
                this._bedBtn.setDisableFlag(true);
                if (this._instantRestoreBtn)
                {
                    this._instantRestoreBtn.setDisable(true);
                }
            }
            return;
        }// end function

        public function getPlayerNullPosition() : Point
        {
            return this._mcBase.charaNull.localToGlobal(new Point());
        }// end function

        public function countTime(param1:int) : void
        {
            this._restoreTimeSec = this._restoreTimeSec > param1 ? (this._restoreTimeSec - param1) : (0);
            var _loc_2:* = TimeClock.getNowTime();
            var _loc_3:* = this.getRestoreSec(_loc_2);
            if (this._restoreTimeSec + 5 < _loc_3)
            {
                this._restoreTimeSec = _loc_3;
            }
            var _loc_4:* = Math.min(this._maxTimeSec, this._restoreTimeSec);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_3))
            {
                _loc_4 = this._maxTimeSec;
            }
            if (this._numMcRestoreTime == null)
            {
                this._numMcRestoreTime = new NumericNumberMc(this._mcBase.timeInfoMc.remainingTimeMc, 0, 0);
            }
            var _loc_5:* = _loc_4 % 60;
            var _loc_6:* = _loc_4 / 60 % 60;
            var _loc_7:* = _loc_4 / 60 / 60;
            var _loc_8:* = _loc_4 / 60 / 60 * 10000 + _loc_6 * 100 + _loc_5;
            this._numMcRestoreTime.setNum(_loc_8);
            var _loc_9:* = this._personal.getHpAtResting();
            var _loc_10:* = this._personal.isDyingAtResting();
            this._mcBase.timeInfoMc.hpBerMc.gotoAndStop(_loc_10 ? ("Red") : ("green"));
            if (_loc_10)
            {
                this._hpGreenGauge.hide();
                this._hpRedGauge.show();
                this._hpRedGauge.setGauge(_loc_9);
            }
            else
            {
                this._hpRedGauge.hide();
                this._hpGreenGauge.show();
                this._hpGreenGauge.setGauge(_loc_9);
            }
            this._personal.updateSp();
            this._spGauge.setGauge(this._personal.sp);
            this._bFinish = this._restoreTimeSec <= 0;
            this.updateButtonDisable();
            return;
        }// end function

        public function getTimeCount() : int
        {
            var _loc_1:* = Math.min(this._maxTimeSec, this._restoreTimeSec);
            var _loc_2:* = _loc_1 % 60;
            var _loc_3:* = _loc_1 / 60 % 60;
            var _loc_4:* = _loc_1 / 60 / 60;
            return _loc_1 / 60 / 60 * 10000 + _loc_3 * 100 + _loc_2;
        }// end function

        private function getRestoreSec(param1:uint) : uint
        {
            return this._personal.getRestoreWaitTime(param1);
        }// end function

        private function getSnoreWait() : Number
        {
            return _SNORE_SE_INTERVAL + Random.range(0, _SNORE_SE_INTERVAL * 10) / 10;
        }// end function

        private function playSnore() : void
        {
            var _loc_1:* = Lot.lotTarget(this._snoreLotList);
            SoundManager.getInstance().playSe(SoundId.SE_SLEEP_CHARA, _loc_1.vol);
            return;
        }// end function

        private function setupSnoring() : void
        {
            this._snoreSeWait = this.getSnoreWait();
            this._snoreLotList = _SNORE_SE_VOLUME_TABLE;
            return;
        }// end function

        private function cbBedBtnOver(param1:int) : void
        {
            if (this._cbOver != null)
            {
                this._cbOver(this);
            }
            return;
        }// end function

        private function cbBedBtnOut(param1:int) : void
        {
            if (this._cbOut != null)
            {
                this._cbOut(this);
            }
            return;
        }// end function

        private function cbInstantRestoreBtnClick(param1:int) : void
        {
            if (this._cbInstantRestore != null)
            {
                this._cbInstantRestore(this);
            }
            return;
        }// end function

    }
}
