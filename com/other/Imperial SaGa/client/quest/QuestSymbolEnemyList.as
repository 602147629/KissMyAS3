package quest
{
    import enemy.*;
    import flash.display.*;
    import flash.geom.*;
    import resource.*;
    import utility.*;

    public class QuestSymbolEnemyList extends QuestSprite
    {
        private var _aEnemySymbol:Array;
        private var _sq:QuestSquare;
        private var _parent:DisplayObjectContainer;
        private var _parentMc:MovieClip;
        private var _squareId:int;
        private var _bVanish:Boolean;

        public function QuestSymbolEnemyList(param1:DisplayObjectContainer, param2:QuestSquare)
        {
            super(QuestConstant.PIECE_PRIORITY_ENEMY, param2.y);
            param1.addChild(this);
            this._parent = param1;
            this._sq = param2;
            this._squareId = this._sq.id;
            this._bVanish = false;
            this._aEnemySymbol = [];
            this.createSymbol();
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aEnemySymbol)
            {
                
                _loc_1.release();
            }
            this._aEnemySymbol = null;
            if (this._parentMc && this._parentMc.parent)
            {
                this._parentMc.parent.removeChild(this._parentMc);
            }
            this._parentMc = null;
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            this._parent = null;
            return;
        }// end function

        public function setLandSeId(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aEnemySymbol)
            {
                
                _loc_2.setLandSeId(param1);
            }
            return;
        }// end function

        public function setReverse(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aEnemySymbol)
            {
                
                _loc_2.setReverse(param1);
            }
            return;
        }// end function

        public function setFall(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_5:* = this._parentMc.transform.matrix;
            var _loc_6:* = 0;
            for each (_loc_7 in this._aEnemySymbol)
            {
                
                _loc_8 = _loc_7.height * _loc_6;
                _loc_7.setFall(param1 - _loc_5.tx, param2 - _loc_5.ty - _loc_8, param3 - _loc_5.tx, param4 - _loc_5.ty);
                _loc_6++;
            }
            return;
        }// end function

        public function setVanish() : void
        {
            var _loc_1:* = null;
            this._bVanish = true;
            for each (_loc_1 in this._aEnemySymbol)
            {
                
                _loc_1.setVanish();
            }
            return;
        }// end function

        public function get bMoveing() : Boolean
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aEnemySymbol)
            {
                
                if (_loc_1.bMoveing)
                {
                    return _loc_1.bMoveing;
                }
            }
            return false;
        }// end function

        public function get parentMc() : MovieClip
        {
            return this._parentMc;
        }// end function

        public function get squareId() : int
        {
            return this._squareId;
        }// end function

        public function get bVanish() : Boolean
        {
            var _loc_2:* = null;
            var _loc_1:* = false;
            for each (_loc_2 in this._aEnemySymbol)
            {
                
                if (_loc_2.visible == true)
                {
                    _loc_1 = true;
                }
            }
            return this._bVanish && _loc_1 == false;
        }// end function

        private function createSymbol() : void
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_4:* = QuestManager.getInstance().getQuestEnemyList(this._sq.aEnemy);
            if (QuestManager.getInstance().getQuestEnemyList(this._sq.aEnemy) == null)
            {
                return;
            }
            this._parentMc = ResourceManager.getInstance().createMovieClip(QuestPieceEnemy.getResource(), "MonsterSymbolNum");
            this.addChild(this._parentMc);
            for each (_loc_5 in _loc_4.aEnemyPersonal)
            {
                
                if (_loc_5 != null)
                {
                    _loc_2 = _loc_2 + _loc_5.rank;
                    _loc_1++;
                }
            }
            _loc_2 = Math.ceil(_loc_2 / _loc_1) as int;
            _loc_1 = Math.ceil(_loc_1 / 3);
            _loc_6 = _loc_1;
            this._parentMc.gotoAndStop("rank2");
            if (this._sq.attribute1 == QuestConstant.SQUARE_ATTR1_BOSSBATTLE)
            {
                this._parentMc.gotoAndStop("rank1");
                _loc_6 = 1;
            }
            if (this._sq.aConnectionId.length > 0)
            {
                _loc_11 = QuestManager.getInstance().getSquare(this._sq.aConnectionId[0]);
                _loc_7 = new Point(_loc_11.x - this._sq.x, _loc_11.y - this._sq.y);
            }
            else
            {
                _loc_7 = new Point(0, -20);
            }
            _loc_7.normalize(1);
            _loc_7.x = _loc_7.x * 50;
            _loc_7.y = _loc_7.y * 50;
            var _loc_8:* = this._parentMc.transform.matrix;
            this._parentMc.transform.matrix.translate(this._sq.x + _loc_7.x, this._sq.y + _loc_7.y);
            this._parentMc.transform.matrix = _loc_8;
            var _loc_9:* = 1;
            var _loc_10:* = 0;
            while (_loc_10 < _loc_4.aEnemyPersonal.length)
            {
                
                _loc_12 = _loc_4.aEnemyPersonal[_loc_10];
                if (_loc_12 != null)
                {
                    _loc_13 = this._parentMc.getChildByName("monsNull" + _loc_9.toString()) as MovieClip;
                    _loc_3 = EnemyManager.getInstance().getEnemyInformation(_loc_12.infoId);
                    _loc_14 = new QuestPieceEnemy(_loc_13, this._sq.attribute1, _loc_3, _loc_2);
                    _loc_14.squareId = this._squareId;
                    _loc_14.setFrame(_loc_10 * Random.range(1, 3));
                    if (_loc_7.x < 0)
                    {
                        _loc_14.setReverse(true);
                    }
                    this._aEnemySymbol.push(_loc_14);
                    _loc_9++;
                    _loc_6 = _loc_6 - 1;
                }
                if (_loc_6 == 0)
                {
                    break;
                }
                _loc_10++;
            }
            return;
        }// end function

    }
}
