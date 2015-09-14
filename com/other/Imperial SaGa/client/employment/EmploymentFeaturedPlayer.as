package employment
{
    import PlayerCard.*;
    import character.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class EmploymentFeaturedPlayer extends Object
    {
        private var _phase:int;
        private var _playerDisplay:PlayerDisplay;
        private var _mcInfo:MovieClip;
        private var _isoInfo:InStayOut;
        private var _mcStatus:MovieClip;
        private var _isoStatus:InStayOut;
        private var _miniCard:PlayerSmallCard;
        private var _normalPos:Point;
        private var _highPos:Point;
        private var _specialPos:Point;
        private var _limitedPos:Point;
        private var _homePos:Point;
        private var _aFeaturedPlayer:Array;
        private var _aProbabilityTable:Array;
        private var _nextFeaturedPlayer:EmploymentFeaturedPlayerData;
        private var _wait:Number;
        private var _bViewInfo:Boolean;
        private static const _PHASE_BACKSTAGE_WAIT:int = 0;
        private static const _PHASE_READY_IN:int = 1;
        private static const _PHASE_JUMP_IN:int = 2;
        private static const _PHASE_INTRODUCE:int = 3;
        private static const _PHASE_READY_OUT:int = 4;
        private static const _PHASE_JUMP_OUT:int = 5;
        private static const _PHASE_CLOSE:int = 6;
        private static const _IN_WAIT:Number = 4;
        private static const _OUT_WAIT:Number = 5;
        private static const _FADE_WAIT:Number = 0.3;

        public function EmploymentFeaturedPlayer(param1:DisplayObjectContainer, param2:MovieClip, param3:MovieClip, param4:Point, param5:Point, param6:Point, param7:Point, param8:Array, param9:Array)
        {
            this._playerDisplay = new PlayerDisplay(param1, Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._mcInfo = param2;
            this._isoInfo = new InStayOut(this._mcInfo);
            this._mcStatus = param3;
            this._isoStatus = new InStayOut(this._mcStatus);
            this._miniCard = null;
            this._normalPos = param4;
            this._highPos = param5;
            this._specialPos = param6;
            this._limitedPos = param7;
            this._aFeaturedPlayer = param8;
            this._aProbabilityTable = param9;
            this._nextFeaturedPlayer = null;
            this._wait = 0;
            this._bViewInfo = false;
            this.setPhase(_PHASE_BACKSTAGE_WAIT);
            return;
        }// end function

        public function release() : void
        {
            if (this._playerDisplay)
            {
                this._playerDisplay.release();
            }
            this._playerDisplay = null;
            if (this._isoInfo)
            {
                this._isoInfo.release();
            }
            this._isoInfo = null;
            if (this._isoStatus)
            {
                this._isoStatus.release();
            }
            this._isoStatus = null;
            if (this._miniCard)
            {
                this._miniCard.release();
            }
            this._miniCard = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_BACKSTAGE_WAIT:
                {
                    this.initPhaseBackStageWait();
                    break;
                }
                case _PHASE_READY_IN:
                {
                    this.initPhaseReadyIn();
                    break;
                }
                case _PHASE_JUMP_IN:
                {
                    this.initPhaseJumpIn();
                    break;
                }
                case _PHASE_INTRODUCE:
                {
                    this.initPhaseIntroduce();
                    break;
                }
                case _PHASE_READY_OUT:
                {
                    this.initPhaseReadyOut();
                    break;
                }
                case _PHASE_JUMP_OUT:
                {
                    this.initPhaseJumpOut();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
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
            this._playerDisplay.control(param1);
            switch(this._phase)
            {
                case _PHASE_BACKSTAGE_WAIT:
                {
                    this.controlPhaseBackStageWait(param1);
                    break;
                }
                case _PHASE_READY_IN:
                {
                    this.controlPhaseReadyIn(param1);
                    break;
                }
                case _PHASE_JUMP_IN:
                {
                    this.controlPhaseJumpIn(param1);
                    break;
                }
                case _PHASE_INTRODUCE:
                {
                    this.controlPhaseIntroduce(param1);
                    break;
                }
                case _PHASE_READY_OUT:
                {
                    this.controlPhaseReadyOut(param1);
                    break;
                }
                case _PHASE_JUMP_OUT:
                {
                    this.controlPhaseJumpOut(param1);
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.controlPhaseClose(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initPhaseBackStageWait() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            this._playerDisplay.setId(Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._wait = _IN_WAIT;
            var _loc_1:* = [];
            var _loc_2:* = [];
            var _loc_3:* = [];
            for each (_loc_4 in this._aFeaturedPlayer)
            {
                
                if (_loc_4.featuredType == EmploymentFeaturedPlayerData.FEATURED_TYPE_FEATURED)
                {
                    _loc_1.push(_loc_4);
                }
                if (_loc_4.featuredType == EmploymentFeaturedPlayerData.FEATURED_TYPE_NEW_COMER)
                {
                    _loc_2.push(_loc_4);
                }
                if (_loc_4.featuredType == EmploymentFeaturedPlayerData.FEATURED_TYPE_MORE_SR)
                {
                    _loc_3.push(_loc_4);
                }
            }
            _loc_4 = null;
            if (_loc_1.length > 0 && _loc_2.length == 0 && _loc_3.length == 0)
            {
                _loc_4 = _loc_1[Random.range(0, (_loc_1.length - 1))];
            }
            else if (_loc_1.length > 0 && _loc_2.length == 0 && _loc_3.length > 0)
            {
                if (Random.range(1, 100) <= 80)
                {
                    _loc_4 = _loc_1[Random.range(0, (_loc_1.length - 1))];
                }
                else
                {
                    _loc_4 = _loc_3[Random.range(0, (_loc_3.length - 1))];
                }
            }
            else if (_loc_1.length == 0 && _loc_2.length > 0)
            {
                _loc_4 = _loc_2[Random.range(0, (_loc_1.length - 1))];
            }
            else if (_loc_1.length > 0 && _loc_2.length > 0)
            {
                if (Random.range(1, 100) <= 60)
                {
                    _loc_4 = _loc_1[Random.range(0, (_loc_1.length - 1))];
                }
                else
                {
                    _loc_4 = _loc_2[Random.range(0, (_loc_2.length - 1))];
                }
            }
            else
            {
                _loc_4 = _loc_3[Random.range(0, (_loc_3.length - 1))];
            }
            if (_loc_4)
            {
                this._nextFeaturedPlayer = _loc_4;
                _loc_5 = PlayerManager.getInstance().getPlayerInformation(this._nextFeaturedPlayer.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_5.swf);
                ResourceManager.getInstance().loadResource(ResourcePath.CARD_SMALL_PATH + CharacterConstant.ID_CARD + _loc_5.cardFileName);
            }
            return;
        }// end function

        private function controlPhaseBackStageWait(param1:Number) : void
        {
            if (this._aFeaturedPlayer.length == 0)
            {
                return;
            }
            if (ResourceManager.getInstance().isLoaded() == false)
            {
                return;
            }
            this._wait = this._wait - param1;
            if (this._wait <= 0)
            {
                this._wait = _IN_WAIT;
                if (this._nextFeaturedPlayer)
                {
                    switch(this._nextFeaturedPlayer.employmentType)
                    {
                        case CommonConstant.EMPLOYMENT_TYPE_NORMAL:
                        {
                            this.enter(this._nextFeaturedPlayer.employmentType, this._nextFeaturedPlayer.playerId, this._normalPos);
                            break;
                        }
                        case CommonConstant.EMPLOYMENT_TYPE_HIGH:
                        {
                            this.enter(this._nextFeaturedPlayer.employmentType, this._nextFeaturedPlayer.playerId, this._highPos);
                            break;
                        }
                        case CommonConstant.EMPLOYMENT_TYPE_SPECIAL:
                        {
                            this.enter(this._nextFeaturedPlayer.employmentType, this._nextFeaturedPlayer.playerId, this._specialPos);
                            break;
                        }
                        case CommonConstant.EMPLOYMENT_TYPE_LIMITED:
                        {
                            this.enter(this._nextFeaturedPlayer.employmentType, this._nextFeaturedPlayer.playerId, this._limitedPos);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                this._nextFeaturedPlayer = null;
            }
            return;
        }// end function

        private function initPhaseReadyIn() : void
        {
            this._playerDisplay.setReverse(false);
            this._playerDisplay.setAnimation(PlayerDisplay.LABEL_FRONT_STOP);
            this._playerDisplay.mc.alpha = 0;
            this._wait = 0.3;
            return;
        }// end function

        private function controlPhaseReadyIn(param1:Number) : void
        {
            if (this._playerDisplay.mc.alpha < 1)
            {
                this._playerDisplay.mc.alpha = this._playerDisplay.mc.alpha + param1 / _FADE_WAIT;
                if (this._playerDisplay.mc.alpha > 1)
                {
                    this._playerDisplay.mc.alpha = 1;
                }
            }
            else
            {
                this._wait = this._wait - param1;
                if (this._wait <= 0)
                {
                    this.setPhase(_PHASE_JUMP_IN);
                }
            }
            return;
        }// end function

        private function initPhaseJumpIn() : void
        {
            this._playerDisplay.setReverse(this._playerDisplay.pos.x < 0);
            this._playerDisplay.setTargetJump(new Point(0, 0));
            return;
        }// end function

        private function controlPhaseJumpIn(param1:Number) : void
        {
            if (this._playerDisplay.bMoveing == false)
            {
                this.setPhase(_PHASE_INTRODUCE);
            }
            return;
        }// end function

        private function initPhaseIntroduce() : void
        {
            this._playerDisplay.setReverse(false);
            this._playerDisplay.setAnimStatusUp();
            this._wait = _OUT_WAIT;
            return;
        }// end function

        private function controlPhaseIntroduce(param1:Number) : void
        {
            if (this._isoStatus.bClosed && this._isoInfo.bClosed && this._playerDisplay.bAnimationEnd)
            {
                if (this._bViewInfo)
                {
                    this._isoInfo.setIn();
                }
                this._isoStatus.setIn();
            }
            this._wait = this._wait - param1;
            if (this._wait <= 0)
            {
                this.setPhase(_PHASE_READY_OUT);
            }
            return;
        }// end function

        private function initPhaseReadyOut() : void
        {
            if (this._isoInfo.bOpened)
            {
                this._isoInfo.setOut();
            }
            this._isoStatus.setOut();
            this._playerDisplay.setAnimCrouch();
            this._wait = 0.2;
            return;
        }// end function

        private function controlPhaseReadyOut(param1:Number) : void
        {
            this._wait = this._wait - param1;
            if (this._wait <= 0)
            {
                this.setPhase(_PHASE_JUMP_OUT);
            }
            return;
        }// end function

        private function initPhaseJumpOut() : void
        {
            this._playerDisplay.setReverse(this._homePos.x >= 0);
            this._playerDisplay.setTargetJump(this._homePos);
            return;
        }// end function

        private function controlPhaseJumpOut(param1:Number) : void
        {
            if (this._playerDisplay.bMoveing == false)
            {
                if (this._playerDisplay.mc.alpha > 0)
                {
                    this._playerDisplay.mc.alpha = this._playerDisplay.mc.alpha - param1 / _FADE_WAIT;
                    if (this._playerDisplay.mc.alpha < 0)
                    {
                        this._playerDisplay.mc.alpha = 0;
                    }
                }
                else
                {
                    this.setPhase(_PHASE_BACKSTAGE_WAIT);
                }
            }
            return;
        }// end function

        private function initPhaseClose() : void
        {
            if (this._isoInfo.bOpened)
            {
                this._isoInfo.setOut();
            }
            if (this._isoStatus.bOpened)
            {
                this._isoStatus.setOut();
            }
            return;
        }// end function

        private function controlPhaseClose(param1:Number) : void
        {
            if (this._playerDisplay.mc.alpha > 0)
            {
                this._playerDisplay.mc.alpha = this._playerDisplay.mc.alpha - param1 / _FADE_WAIT;
                if (this._playerDisplay.mc.alpha < 0)
                {
                    this._playerDisplay.mc.alpha = 0;
                }
            }
            return;
        }// end function

        public function enter(param1:int, param2:int, param3:Point) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (this._phase != _PHASE_BACKSTAGE_WAIT)
            {
                return;
            }
            this._playerDisplay.setId(param2, Constant.EMPTY_ID);
            this._homePos = this._playerDisplay.layer.parent.globalToLocal(param3);
            this._playerDisplay.pos = this._homePos;
            if (this._miniCard == null)
            {
                this._miniCard = new PlayerSmallCard(this._mcStatus.CharaStatusWinMc.cardNull, Constant.EMPTY_ID);
            }
            this._miniCard.setPlayerId(param2);
            var _loc_4:* = PlayerManager.getInstance().getPlayerInformation(this._playerDisplay.info.id);
            if (PlayerManager.getInstance().getPlayerInformation(this._playerDisplay.info.id))
            {
                TextControl.setIdText(this._mcStatus.CharaStatusWinMc.charaStatus1TextMc.textDt, MessageId.COMMON_STATUS_HP);
                TextControl.setIdText(this._mcStatus.CharaStatusWinMc.charaStatus2TextMc.textDt, MessageId.COMMON_STATUS_LP);
                TextControl.setIdText(this._mcStatus.CharaStatusWinMc.charaStatus4TextMc.textDt, MessageId.COMMON_STATUS_ATTACK);
                TextControl.setIdText(this._mcStatus.CharaStatusWinMc.charaStatus5TextMc.textDt, MessageId.COMMON_STATUS_DEFENSE);
                TextControl.setIdText(this._mcStatus.CharaStatusWinMc.charaStatus6TextMc.textDt, MessageId.COMMON_STATUS_SPEED);
                _loc_6 = String(_loc_4.hp + "/" + _loc_4.hp);
                _loc_7 = String(_loc_4.lp + "/" + _loc_4.lp);
                TextControl.setText(this._mcStatus.CharaStatusWinMc.charaNameMc.textDt, _loc_4.name);
                TextControl.setText(this._mcStatus.CharaStatusWinMc.charaStatusNum1TextMc.textDt, _loc_6);
                TextControl.setText(this._mcStatus.CharaStatusWinMc.charaStatusNum2TextMc.textDt, _loc_7);
                TextControl.setText(this._mcStatus.CharaStatusWinMc.charaStatusNum4TextMc.textDt, _loc_4.attack.toString());
                TextControl.setText(this._mcStatus.CharaStatusWinMc.charaStatusNum5TextMc.textDt, _loc_4.defense.toString());
                TextControl.setText(this._mcStatus.CharaStatusWinMc.charaStatusNum6TextMc.textDt, _loc_4.speed.toString());
            }
            this._bViewInfo = false;
            for each (_loc_5 in this._aProbabilityTable)
            {
                
                if (_loc_5.type == param1)
                {
                    _loc_8 = _loc_5.msg ? (_loc_5.msg) : ("");
                    TextControl.setText(this._mcInfo.CharaInfoWinMc.CharaInfoTextMc.textDt, _loc_8);
                    this._bViewInfo = _loc_8 != "";
                    break;
                }
            }
            this.setPhase(_PHASE_READY_IN);
            return;
        }// end function

        public function setEnable(param1:Boolean) : void
        {
            if (param1 && this._phase == _PHASE_CLOSE)
            {
                this.setPhase(_PHASE_BACKSTAGE_WAIT);
            }
            if (!param1)
            {
                this.setPhase(_PHASE_CLOSE);
            }
            return;
        }// end function

        public function resetFeaturedPlayer(param1:Array, param2:Array) : void
        {
            this._aFeaturedPlayer = param1;
            this._aProbabilityTable = param2;
            this._nextFeaturedPlayer = null;
            return;
        }// end function

    }
}
