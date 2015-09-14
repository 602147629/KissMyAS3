package quest
{
    import enemy.*;

    public class QuestEnemyList extends Object
    {
        private var _groupId:int;
        private var _flagId:int;
        private var _aEnemyPersonal:Array;
        private var _aChangeEnemy:Array;

        public function QuestEnemyList()
        {
            return;
        }// end function

        public function setRecive(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this._groupId = param1.id;
            this._flagId = param1.flagId;
            this._aEnemyPersonal = [];
            var _loc_2:* = 0;
            while (_loc_2 < QuestConstant.ENEMY_MAX_NUM)
            {
                
                _loc_4 = null;
                for each (_loc_5 in param1.aEnemyPersonal)
                {
                    
                    if (_loc_5 != null && _loc_5.hasOwnProperty("formationIndex"))
                    {
                        if (_loc_5.formationIndex == (_loc_2 + 1))
                        {
                            _loc_4 = new EnemyPersonal();
                            _loc_4.setParameter(_loc_5);
                            break;
                        }
                    }
                }
                this._aEnemyPersonal.push(_loc_4);
                _loc_2++;
            }
            this._aChangeEnemy = [];
            for each (_loc_3 in param1.aChangeEnemy)
            {
                
                _loc_6 = new EnemyPersonal();
                _loc_6.setParameter(_loc_3);
                this._aChangeEnemy.push(_loc_6);
            }
            return;
        }// end function

        public function setReciveDummy(param1:Array, param2:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._groupId = 1;
            this._flagId = 0;
            this._aEnemyPersonal = [];
            var _loc_3:* = 0;
            while (_loc_3 < QuestConstant.ENEMY_MAX_NUM)
            {
                
                _loc_5 = null;
                for each (_loc_6 in param1)
                {
                    
                    if (_loc_6 != null && _loc_6.hasOwnProperty("formationIndex"))
                    {
                        if (_loc_6.formationIndex == (_loc_3 + 1))
                        {
                            _loc_5 = new EnemyPersonal();
                            _loc_5.setParameter(_loc_6);
                            break;
                        }
                    }
                }
                this._aEnemyPersonal.push(_loc_5);
                _loc_3++;
            }
            this._aChangeEnemy = [];
            for each (_loc_4 in param2)
            {
                
                _loc_7 = new EnemyPersonal();
                _loc_7.setParameter(_loc_4);
                this._aChangeEnemy.push(_loc_7);
            }
            return;
        }// end function

        public function get groupId() : int
        {
            return this._groupId;
        }// end function

        public function get flagId() : int
        {
            return this._flagId;
        }// end function

        public function get aEnemyPersonal() : Array
        {
            return this._aEnemyPersonal.concat();
        }// end function

        public function get aChangeEnemy() : Array
        {
            return this._aChangeEnemy.concat();
        }// end function

    }
}
