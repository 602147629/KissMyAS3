package battle
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;

    public class BattleBadStatusIcon extends Object
    {
        private var _mc:MovieClip;
        private var _aBadStatusId:Array;
        private var _badStatusIndex:int;
        private var _waitTime:Number;
        private var _phase:int;
        private static const _ICON_DISP_BAD_STATUS:Array = [BattleConstant.BAD_STATUS_ID_POISON, BattleConstant.BAD_STATUS_ID_PARALYSIS, BattleConstant.BAD_STATUS_ID_DARKNESS, BattleConstant.BAD_STATUS_ID_SLEEP, BattleConstant.BAD_STATUS_ID_CONFUSION, BattleConstant.BAD_STATUS_ID_CHARM, BattleConstant.BAD_STATUS_ID_STONE];
        private static const _LABEL_SINGLE_STAY:String = "simple";
        private static const _LABEL_MULTI_STAY:String = "multiple";
        private static const _LABEL_MULTI_CHANGE:String = "change";
        private static const _LABEL_MULTI_CHANGE2:String = "change2";
        private static const _LABEL_MULTI_END:String = "end";
        private static const _LABEL_BAD_STATE_POISON:String = "Poison";
        private static const _LABEL_BAD_STATE_PARALYSIS:String = "Paralyze";
        private static const _LABEL_BAD_STATE_SLEEP:String = "Sleep";
        private static const _LABEL_BAD_STATE_DARKNESS:String = "Darkness";
        private static const _LABEL_BAD_STATE_CHARM:String = "Fascination";
        private static const _LABEL_BAD_STATE_CONFUSION:String = "Confusion";
        private static const _LABEL_BAD_STATE_STONE:String = "Stone";
        private static const _PHASE_SET_BAD_STATE:int = 1;
        private static const _PHASE_CHANGE:int = 2;
        private static const _PHASE_CHANGE2:int = 3;
        private static const _WAIT_TIME:Number = 1;

        public function BattleBadStatusIcon(param1:DisplayObjectContainer, param2:BattleBadStatus, param3:Point)
        {
            var _loc_6:* = null;
            this._aBadStatusId = [];
            this._badStatusIndex = 0;
            var _loc_4:* = param2.aBadStatusData;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_6 = _loc_4[_loc_5];
                if (_ICON_DISP_BAD_STATUS.indexOf(_loc_6.id) < 0)
                {
                }
                else
                {
                    this._aBadStatusId.push(_loc_6.id);
                }
                _loc_5++;
            }
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "BadStatusMc");
            this._mc.x = param3.x;
            this._mc.y = param3.y;
            param1.addChild(this._mc);
            this._waitTime = 0;
            this.setPhase(_PHASE_SET_BAD_STATE);
            return;
        }// end function

        public function release() : void
        {
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._aBadStatusId.length <= 1)
            {
                return;
            }
            switch(this._phase)
            {
                case _PHASE_SET_BAD_STATE:
                {
                    this._waitTime = this._waitTime + param1;
                    if (this._waitTime > _WAIT_TIME)
                    {
                        this._waitTime = 0;
                        this.setPhase(_PHASE_CHANGE);
                    }
                    break;
                }
                case _PHASE_CHANGE:
                {
                    if (this._mc.currentLabel == _LABEL_MULTI_CHANGE2)
                    {
                        this.setPhase(_PHASE_CHANGE2);
                    }
                    break;
                }
                case _PHASE_CHANGE2:
                {
                    if (this._mc.currentLabel == _LABEL_MULTI_END)
                    {
                        this.setPhase(_PHASE_SET_BAD_STATE);
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

        private function setPhase(param1:int) : void
        {
            var _loc_2:* = 0;
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_SET_BAD_STATE:
                {
                    if (this._aBadStatusId.length == 1)
                    {
                        this._mc.gotoAndStop(_LABEL_SINGLE_STAY);
                    }
                    else
                    {
                        this._mc.gotoAndStop(_LABEL_MULTI_STAY);
                    }
                    this.setBadStatus(this._mc.badStatus1, this._aBadStatusId[this._badStatusIndex]);
                    break;
                }
                case _PHASE_CHANGE:
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this._badStatusIndex + 1;
                    _loc_3._badStatusIndex = _loc_4;
                    if (this._aBadStatusId.length == this._badStatusIndex)
                    {
                        this._badStatusIndex = 0;
                    }
                    this.setBadStatus(this._mc.badStatus2, this._aBadStatusId[this._badStatusIndex]);
                    this._mc.gotoAndPlay(_LABEL_MULTI_CHANGE);
                    break;
                }
                case _PHASE_CHANGE2:
                {
                    _loc_2 = this._badStatusIndex + 1;
                    if (this._aBadStatusId.length == _loc_2)
                    {
                        _loc_2 = 0;
                    }
                    this.setBadStatus(this._mc.badStatus1, this._aBadStatusId[this._badStatusIndex]);
                    this.setBadStatus(this._mc.badStatus2, this._aBadStatusId[_loc_2]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setBadStatus(param1:MovieClip, param2:int) : void
        {
            switch(param2)
            {
                case BattleConstant.BAD_STATUS_ID_POISON:
                {
                    param1.gotoAndStop(_LABEL_BAD_STATE_POISON);
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_PARALYSIS:
                {
                    param1.gotoAndStop(_LABEL_BAD_STATE_PARALYSIS);
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_DARKNESS:
                {
                    param1.gotoAndStop(_LABEL_BAD_STATE_DARKNESS);
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_SLEEP:
                {
                    param1.gotoAndStop(_LABEL_BAD_STATE_SLEEP);
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_CONFUSION:
                {
                    param1.gotoAndStop(_LABEL_BAD_STATE_CONFUSION);
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_CHARM:
                {
                    param1.gotoAndStop(_LABEL_BAD_STATE_CHARM);
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_STONE:
                {
                    param1.gotoAndStop(_LABEL_BAD_STATE_STONE);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function isIconDisplay(param1:BattleBadStatus) : Boolean
        {
            if (BattleManager.isBadStatusPoison(param1) || BattleManager.isBadStatusParalysis(param1) || BattleManager.isBadStatusDarkness(param1) || BattleManager.isBadStatusSleep(param1) || BattleManager.isBadStatusConfusion(param1) || BattleManager.isBadStatusCharm(param1) || BattleManager.isBadStatusStone(param1))
            {
                return true;
            }
            return false;
        }// end function

    }
}
