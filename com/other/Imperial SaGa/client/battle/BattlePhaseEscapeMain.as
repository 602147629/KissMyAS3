package battle
{
    import flash.geom.*;
    import player.*;
    import sound.*;

    public class BattlePhaseEscapeMain extends Object
    {
        private const _DASH_POW:Number = 400;
        private const _ESCAPE_WAIT_TIME:Number = 2;
        private var _aEscapePlayer:Array;
        private var _aBadStatusPlayer:Array;
        private var _escapeWaitTime:Number;
        private var _bEnd:Boolean;

        public function BattlePhaseEscapeMain(param1:BattleManager)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._aEscapePlayer = [];
            this._aBadStatusPlayer = [];
            for each (_loc_2 in param1.getEntryPlayer())
            {
                
                if (_loc_2.bBattleDead)
                {
                    continue;
                }
                this._aEscapePlayer.push(_loc_2);
                if (BattleManager.isBadStatusParalysis(_loc_2.status.badStatus) || BattleManager.isBadStatusSleep(_loc_2.status.badStatus) || BattleManager.isBadStatusStone(_loc_2.status.badStatus))
                {
                    this._aBadStatusPlayer.push(_loc_2);
                    continue;
                }
                _loc_3 = _loc_2.characterAction as BattleActionPlayer;
                if (_loc_3 == null)
                {
                    continue;
                }
                _loc_4 = _loc_3.playerDisplay;
                _loc_4.setAnimSideDash();
                _loc_4.layer.scaleX = -1;
                SoundManager.getInstance().playSe(SoundId.SE_CHARA_RUNNING);
            }
            this._escapeWaitTime = this._ESCAPE_WAIT_TIME;
            this._bEnd = false;
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            this._aEscapePlayer = [];
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this._bEnd)
            {
                return;
            }
            this._escapeWaitTime = this._escapeWaitTime - param1;
            var _loc_2:* = this._escapeWaitTime > 1 ? (1) : (this._escapeWaitTime);
            for each (_loc_3 in this._aEscapePlayer)
            {
                
                _loc_4 = _loc_3.characterAction as BattleActionPlayer;
                if (_loc_4 == null)
                {
                    continue;
                }
                _loc_5 = _loc_4.playerDisplay;
                _loc_5.layer.alpha = _loc_2;
                if (this._aBadStatusPlayer.indexOf(_loc_3) != -1)
                {
                    continue;
                }
                _loc_6 = _loc_5.pos;
                _loc_5.pos.x = _loc_6.x + this._DASH_POW * param1;
                _loc_5.pos = _loc_6;
            }
            this._bEnd = this._escapeWaitTime <= 0;
            return;
        }// end function

    }
}
