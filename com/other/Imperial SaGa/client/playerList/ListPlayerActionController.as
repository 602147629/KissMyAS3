package playerList
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class ListPlayerActionController extends Object
    {
        private var _state:int;
        private var _playerDisplay:PlayerDisplay;
        private var _playerPersonal:PlayerPersonal;
        private var _uniqueId:int;
        private var _effectFlag:int;
        private var _aMcEffect:Array;
        private var _bFrontMember:Boolean;
        private var _bFrontMemberRandomAction:Boolean;
        private var _bEnable:Boolean;
        private var _bMouseOverAction:Boolean;
        private var _timer:Timer;
        private var _timerActionAfterWait:int;
        public static const STATE_DISABLE:int = -1;
        public static const STATE_DEFAULT:int = 0;
        public static const STATE_DEAD:int = 1;
        public static const STATE_DYING:int = 2;
        public static const STATE_FRONTMEMBER:int = 3;
        public static const STATE_RESTING:int = 4;
        public static const STATE_KUMITE:int = 5;
        public static const STATE_TRAINING:int = 6;
        public static const STATE_MAGIC_LERNING:int = 7;
        private static const _EFFECT_FLAG_REST:int = 1;
        private static const _EFFECT_FLAG_BONUS:int = 2;

        public function ListPlayerActionController(param1:PlayerDisplay = null, param2:Boolean = false, param3:Boolean = false)
        {
            this._state = STATE_DISABLE;
            this._playerDisplay = param1;
            this._playerPersonal = null;
            this._uniqueId = Constant.EMPTY_ID;
            this._effectFlag = 0;
            this._aMcEffect = [];
            this._bFrontMember = param2;
            this._bFrontMemberRandomAction = param3;
            this._bMouseOverAction = false;
            this.update();
            return;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function get playerDisplay() : PlayerDisplay
        {
            return this._playerDisplay;
        }// end function

        public function get playerPersonal() : PlayerPersonal
        {
            return this._playerPersonal;
        }// end function

        public function get bFrontMember() : Boolean
        {
            return this._bFrontMember;
        }// end function

        public function get bEnable() : Boolean
        {
            return this._bEnable;
        }// end function

        public function get bMouseOverAction() : Boolean
        {
            return this._bMouseOverAction;
        }// end function

        public function setFrontMember(param1:Boolean, param2:Boolean) : void
        {
            this._bFrontMember = param1;
            this._bFrontMemberRandomAction = param2;
            return;
        }// end function

        public function setPlayerPersonal(param1:PlayerPersonal) : void
        {
            this._playerPersonal = param1;
            this._playerDisplay.setId(this._playerPersonal ? (this._playerPersonal.playerId) : (Constant.EMPTY_ID), this._playerPersonal ? (this._playerPersonal.uniqueId) : (Constant.EMPTY_ID));
            this.update();
            return;
        }// end function

        public function setPlayerId(param1:int) : void
        {
            this._playerPersonal = null;
            this._playerDisplay.setId(param1, Constant.EMPTY_ID);
            this.update();
            return;
        }// end function

        public function release() : void
        {
            this._bEnable = false;
            this._playerDisplay = null;
            this._playerPersonal = null;
            this.removeEffect();
            this._aMcEffect = null;
            this.randomActionTimerClear();
            return;
        }// end function

        public function update() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this._playerPersonal)
            {
                this._bEnable = true;
                _loc_1 = this._state;
                if (this._playerPersonal.isUseFacility())
                {
                    if (this._playerPersonal.lastUseFacilityId == CommonConstant.FACILITY_ID_BARRACKS)
                    {
                        this._state = STATE_RESTING;
                    }
                    else if (this._playerPersonal.lastUseFacilityId == CommonConstant.FACILITY_ID_TRAINING_ROOM && this._playerPersonal.lastUseFacilitySubId == CommonConstant.FACILITY_ID_SUB_TRAINING_KUMITE)
                    {
                        this._state = STATE_KUMITE;
                    }
                    else if (this._playerPersonal.lastUseFacilityId == CommonConstant.FACILITY_ID_TRAINING_ROOM && this._playerPersonal.lastUseFacilitySubId == CommonConstant.FACILITY_ID_SUB_TRAINING_TRAINING)
                    {
                        this._state = STATE_TRAINING;
                    }
                    else if (this._playerPersonal.lastUseFacilityId == CommonConstant.FACILITY_ID_MAGIC_DEVELOP)
                    {
                        this._state = STATE_MAGIC_LERNING;
                    }
                    else
                    {
                        this._state = STATE_DEFAULT;
                    }
                }
                else if (this._playerPersonal.bDead)
                {
                    this._state = STATE_DEAD;
                }
                else if (this._playerPersonal.isDying())
                {
                    this._state = STATE_DYING;
                }
                else if (this._bFrontMember)
                {
                    this._state = STATE_FRONTMEMBER;
                }
                else
                {
                    this._state = STATE_DEFAULT;
                }
                if (_loc_1 != this._state || this._uniqueId != this._playerPersonal.uniqueId)
                {
                    this.reset();
                }
                this._uniqueId = this._playerPersonal.uniqueId;
            }
            else if (this._playerDisplay.info)
            {
                this._bEnable = true;
                this.removeEffect();
                _loc_2 = this._state;
                this._state = STATE_DEFAULT;
                if (_loc_2 != this._state)
                {
                    this.resetAction();
                }
                this._uniqueId = Constant.EMPTY_ID;
            }
            else
            {
                this._bEnable = false;
                this.randomActionTimerClear();
                this.removeEffect();
                this._state = STATE_DISABLE;
                this._uniqueId = Constant.EMPTY_ID;
            }
            return;
        }// end function

        private function reset() : void
        {
            this.removeEffect();
            this.resetAction();
            switch(this._state)
            {
                case STATE_RESTING:
                {
                    this.addEffect(_EFFECT_FLAG_REST);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._playerPersonal.isRestoreBonus())
            {
                this.addEffect(_EFFECT_FLAG_BONUS);
            }
            return;
        }// end function

        public function resetAction() : void
        {
            this.randomActionTimerClear();
            this._bMouseOverAction = false;
            switch(this._state)
            {
                case STATE_DEFAULT:
                {
                    this._playerDisplay.setAnimation(PlayerDisplay.LABEL_SIDE_WALK);
                    break;
                }
                case STATE_RESTING:
                {
                    this._playerDisplay.setAnimation(PlayerDisplay.LABEL_DEAD);
                    break;
                }
                case STATE_KUMITE:
                {
                    this._playerDisplay.setAnimation(PlayerDisplay.LABEL_ACTION_SELECT_END);
                    this.randomActionTimerSet(1000, 4000);
                    break;
                }
                case STATE_TRAINING:
                {
                    this._playerDisplay.setAnimation(PlayerDisplay.LABEL_SIDE_WALK);
                    break;
                }
                case STATE_MAGIC_LERNING:
                {
                    this._playerDisplay.setAnimation(PlayerDisplay.LABEL_ACTION_SELECT_END_MAGIC);
                    break;
                }
                case STATE_DEAD:
                {
                    this._playerDisplay.setAnimation(PlayerDisplay.LABEL_DEAD);
                    break;
                }
                case STATE_DYING:
                {
                    this._playerDisplay.setAnimation(PlayerDisplay.LABEL_CROUCH);
                    break;
                }
                case STATE_FRONTMEMBER:
                {
                    if (this._playerDisplay.mc.currentLabel != PlayerDisplay.LABEL_ACTION_SELECT_END)
                    {
                        this._playerDisplay.setAnimation(PlayerDisplay.LABEL_ACTION_SELECT_END);
                    }
                    if (this._bFrontMemberRandomAction)
                    {
                        this.randomActionTimerSet(3000, 8000);
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

        public function mouseOverAction(param1:Function = null) : void
        {
            this._bMouseOverAction = true;
            if (this._state == STATE_DEAD || this._state == STATE_RESTING)
            {
                if (param1 != null)
                {
                    this.param1();
                }
                return;
            }
            this._playerDisplay.setAnimationWithCallback(PlayerDisplay.LABEL_ACTION_SELECT_START, param1);
            this.randomActionTimerClear();
            return;
        }// end function

        public function randomActionDisable() : void
        {
            this.randomActionTimerClear();
            return;
        }// end function

        public function restEndAction() : void
        {
            this._playerDisplay.setAnimationWithCallback(PlayerDisplay.LABEL_WIN, function () : void
            {
                var newTimer:* = new Timer(300, 1);
                newTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function (event:TimerEvent) : void
                {
                    if (_playerDisplay && _playerPersonal && _playerPersonal.uniqueId == _uniqueId)
                    {
                        resetAction();
                    }
                    return;
                }// end function
                );
                newTimer.start();
                return;
            }// end function
            );
            return;
        }// end function

        private function addEffect(param1:int) : void
        {
            if (this._effectFlag & param1)
            {
                return;
            }
            var _loc_2:* = null;
            if (param1 == _EFFECT_FLAG_REST)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf", "sleepEffectMc");
            }
            else if (param1 == _EFFECT_FLAG_BONUS)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf", "statusBonus_Efc");
            }
            if (_loc_2 == null)
            {
                return;
            }
            _loc_2.x = this._playerDisplay.mc.x;
            _loc_2.y = this._playerDisplay.mc.y;
            _loc_2.mouseEnabled = false;
            _loc_2.mouseChildren = false;
            this._playerDisplay.mc.parent.addChild(_loc_2);
            this._aMcEffect.push(_loc_2);
            this._effectFlag = this._effectFlag | param1;
            return;
        }// end function

        private function removeEffect() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aMcEffect)
            {
                
                if (_loc_1 && _loc_1.parent)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
                _loc_1 = null;
            }
            this._aMcEffect = [];
            this._effectFlag = 0;
            return;
        }// end function

        private function randomActionTimerSet(param1:int, param2:int) : void
        {
            if (!this._bEnable)
            {
                return;
            }
            if (this._timer == null || this._timer.running == false)
            {
                this._timer = new Timer(Random.range(param1, param2), 1);
                this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.cbRandomActionTimer);
                this._timer.start();
            }
            return;
        }// end function

        private function randomActionTimerClear() : void
        {
            if (this._timer)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cbRandomActionTimer);
            }
            this._timer = null;
            return;
        }// end function

        private function cbRandomActionTimer(event:TimerEvent) : void
        {
            var event:* = event;
            if (!this._bEnable)
            {
                return;
            }
            var randomActionList:* = this.getRandomActionList(this._state);
            if (randomActionList.length == 0)
            {
                return;
            }
            var r:* = Random.range(0, (randomActionList.length - 1));
            var label:* = randomActionList[r].label;
            this._timerActionAfterWait = randomActionList[r].wait;
            this._playerDisplay.setAnimation(label);
            this._timer = new Timer(this._timerActionAfterWait, 1);
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, function (event:TimerEvent) : void
            {
                resetAction();
                return;
            }// end function
            );
            this._timer.start();
            return;
        }// end function

        private function getRandomActionList(param1:int) : Array
        {
            switch(param1)
            {
                case STATE_KUMITE:
                {
                    return [{label:PlayerDisplay.LABEL_ACTION_SELECT_START, wait:500}, {label:PlayerDisplay.LABEL_WIN, wait:800}, {label:PlayerDisplay.LABEL_DAMAGE, wait:500}];
                }
                case STATE_FRONTMEMBER:
                {
                    return [{label:PlayerDisplay.LABEL_GUARD, wait:3000}, {label:PlayerDisplay.LABEL_MAGIC_STOP, wait:3000}, {label:PlayerDisplay.LABEL_WIN, wait:1000}, {label:PlayerDisplay.LABEL_SIDE_WALK, wait:5000}, {label:PlayerDisplay.LABEL_SIDE_DASH, wait:5000}];
                }
                default:
                {
                    break;
                }
            }
            return [];
        }// end function

    }
}
