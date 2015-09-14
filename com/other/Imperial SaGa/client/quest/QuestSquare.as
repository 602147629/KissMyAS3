package quest
{

    public class QuestSquare extends Object
    {
        private var _id:int;
        private var _x:int;
        private var _y:int;
        private var _attribute1:int;
        private var _attribute2:int;
        private var _bBattle:Boolean;
        private var _bEncountSymbol:Boolean;
        private var _itemDisp:int;
        private var _itemType:int;
        private var _itemId:int;
        private var _itemCount:int;
        private var _aConnectionId:Array;
        private var _aEnemy:Array;
        private var _emperorExp:int;
        private var _aChangeEnemy:Array;

        public function QuestSquare()
        {
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

        public function get attribute1() : int
        {
            return this._attribute1;
        }// end function

        public function get attribute2() : int
        {
            return this._attribute2;
        }// end function

        public function get bBattle() : Boolean
        {
            return this._bBattle;
        }// end function

        public function get bEncountSymbol() : Boolean
        {
            return this._bEncountSymbol;
        }// end function

        public function get itemDisp() : int
        {
            return this._itemDisp;
        }// end function

        public function get itemType() : int
        {
            return this._itemType;
        }// end function

        public function get itemId() : int
        {
            return this._itemId;
        }// end function

        public function get itemCount() : int
        {
            return this._itemCount;
        }// end function

        public function get aConnectionId() : Array
        {
            return this._aConnectionId;
        }// end function

        public function get aEnemy() : Array
        {
            return this._aEnemy;
        }// end function

        public function get emperorExp() : int
        {
            return this._emperorExp;
        }// end function

        public function get aChangeEnemy() : Array
        {
            return this._aChangeEnemy;
        }// end function

        public function setReceiveData(param1:Object) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._id = param1.id;
            this._x = param1.x;
            this._y = param1.y;
            this._attribute1 = param1.attr1;
            this._attribute2 = param1.attr2;
            this._bBattle = param1.bBattle;
            this._bEncountSymbol = param1.bEncountSymbol;
            this._itemDisp = param1.itemDisp;
            this._itemType = param1.itemType;
            this._itemId = param1.itemId;
            this._itemCount = param1.itemNum;
            this._aConnectionId = [];
            for each (_loc_2 in param1.aConnectionId)
            {
                
                this._aConnectionId.push(_loc_2);
            }
            this._emperorExp = param1.emperorExp;
            this._aEnemy = [];
            for each (_loc_3 in param1.aEnemy)
            {
                
                _loc_4 = new QuestEnemyList();
                _loc_4.setRecive(_loc_3);
                this._aEnemy.push(_loc_4);
            }
            return;
        }// end function

        public function setItem(param1:int, param2:int, param3:int) : void
        {
            this._itemDisp = 0;
            this._itemType = param1;
            this._itemId = param2;
            this._itemCount = param3;
            return;
        }// end function

        public function isTreasure() : Boolean
        {
            if ((this._attribute1 == QuestConstant.SQUARE_ATTR1_TREASURE_1 || this._attribute1 == QuestConstant.SQUARE_ATTR1_TREASURE_2 || this._attribute1 == QuestConstant.SQUARE_ATTR1_TREASURE_3 || this._attribute1 == QuestConstant.SQUARE_ATTR1_TREASURE_4 || this._attribute1 == QuestConstant.SQUARE_ATTR1_TREASURE_5) && this._itemCount > 0 && this._itemDisp != 0)
            {
                return true;
            }
            return false;
        }// end function

    }
}
