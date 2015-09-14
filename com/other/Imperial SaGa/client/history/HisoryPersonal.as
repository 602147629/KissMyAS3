package history
{
    import player.*;
    import utility.*;

    public class HisoryPersonal extends PlayerPersonal
    {
        private var _swf:String;
        private var _cardFileName:String;

        public function HisoryPersonal()
        {
            return;
        }// end function

        override public function setParameter(param1:Object) : void
        {
            _questUniqueId = Constant.EMPTY_ID;
            _playerId = parseInt(param1.id);
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(_playerId);
            this._swf = _loc_2.swf;
            this._cardFileName = _loc_2.bustUpFileName;
            _battleCount = param1.battleCount;
            _hpMax = param1.hpMax;
            _hp = _hpMax;
            _lp = param1.lp;
            _spMax = _loc_2.sp;
            _sp = _spMax;
            _spRecoveryTime = TimeClock.getNowTime();
            _attack = param1.attack;
            _defense = param1.defence;
            _speed = param1.speed;
            _aSetSkillId = param1.aSkill.concat();
            _aSetItemId = param1.aItem.concat();
            updateStatusItem();
            return;
        }// end function

        public function get swf() : String
        {
            return this._swf;
        }// end function

        public function get bustUpFileName() : String
        {
            return this._cardFileName;
        }// end function

    }
}
