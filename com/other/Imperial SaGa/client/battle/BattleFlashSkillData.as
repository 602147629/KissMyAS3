package battle
{

    public class BattleFlashSkillData extends Object
    {
        private var _enemyRank:int;
        private var _aSkillRankRate:Array;

        public function BattleFlashSkillData()
        {
            this._aSkillRankRate = [];
            return;
        }// end function

        public function get enemyRank() : int
        {
            return this._enemyRank;
        }// end function

        public function get aSkillRankRate() : Array
        {
            return this._aSkillRankRate;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._enemyRank = int(param1.enemyRank);
            this._aSkillRankRate = [];
            this._aSkillRankRate.push(0);
            this._aSkillRankRate.push(int(param1.skillRank01));
            this._aSkillRankRate.push(int(param1.skillRank02));
            this._aSkillRankRate.push(int(param1.skillRank03));
            this._aSkillRankRate.push(int(param1.skillRank04));
            this._aSkillRankRate.push(int(param1.skillRank05));
            this._aSkillRankRate.push(int(param1.skillRank06));
            this._aSkillRankRate.push(int(param1.skillRank07));
            this._aSkillRankRate.push(int(param1.skillRank08));
            this._aSkillRankRate.push(int(param1.skillRank09));
            this._aSkillRankRate.push(int(param1.skillRank10));
            return;
        }// end function

        public function getSkillRankRate(param1:int) : int
        {
            return this._aSkillRankRate[param1];
        }// end function

    }
}
