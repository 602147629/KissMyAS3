package quest
{
    import player.*;

    public class QuestPlayerBattleBonus extends Object
    {
        private var _uniqueId:uint;
        private var _aPlayerBattleBonus:Array;

        public function QuestPlayerBattleBonus()
        {
            return;
        }// end function

        public function get uniqueId() : uint
        {
            return this._uniqueId;
        }// end function

        public function get aPlayerBattleBonus() : Array
        {
            return this._aPlayerBattleBonus.concat();
        }// end function

        public function setParam(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._uniqueId = param1.uniqueId;
            this._aPlayerBattleBonus = [];
            for each (_loc_2 in param1.aBonus)
            {
                
                _loc_3 = new PlayerBattleBonus();
                _loc_3.setParam(_loc_2);
                this._aPlayerBattleBonus.push(_loc_3);
            }
            return;
        }// end function

        public function getParam(param1:int) : PlayerBattleBonus
        {
            var _loc_2:* = this._aPlayerBattleBonus[param1];
            return _loc_2;
        }// end function

    }
}
