package quest
{
    import character.*;
    import flash.display.*;
    import formation.*;
    import layer.*;
    import player.*;

    public class QuestUnit extends Object
    {
        private var _piece:QuestPiecePlayer;
        private var _teamNo:int;
        private var _squareId:int;
        private var _oldSquareId:int;
        private var _targetSquareId:int;
        private var _aPlayer:Array;
        private var _unitFormation:FormationSetData;
        private var _bPause:Boolean;

        public function QuestUnit(param1:int)
        {
            this._aPlayer = new Array();
            this._teamNo = param1;
            this._targetSquareId = Constant.UNDECIDED;
            this._squareId = Constant.UNDECIDED;
            this._oldSquareId = Constant.UNDECIDED;
            this._unitFormation = null;
            return;
        }// end function

        public function get piece() : QuestPiecePlayer
        {
            return this._piece;
        }// end function

        public function set piece(param1:QuestPiecePlayer) : void
        {
            this._piece = param1;
            return;
        }// end function

        public function get teamNo() : int
        {
            return this._teamNo;
        }// end function

        public function set teamNo(param1:int) : void
        {
            this._teamNo = param1;
            return;
        }// end function

        public function get squareId() : int
        {
            return this._squareId;
        }// end function

        public function get oldSquareId() : int
        {
            return this._oldSquareId;
        }// end function

        public function get targetSquareId() : int
        {
            return this._targetSquareId;
        }// end function

        public function set targetSquareId(param1:int) : void
        {
            this._targetSquareId = param1;
            return;
        }// end function

        public function get aPlayer() : Array
        {
            return this._aPlayer;
        }// end function

        public function get unitFormation() : FormationSetData
        {
            return this._unitFormation;
        }// end function

        public function get bPause() : Boolean
        {
            return this._bPause;
        }// end function

        public function release(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            this.removePiece();
            this._piece = null;
            if (param1)
            {
                for each (_loc_2 in this._aPlayer)
                {
                    
                    _loc_2.release();
                }
            }
            this._aPlayer = [];
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._piece != null && this._bPause == false)
            {
                this._piece.control(param1);
            }
            return;
        }// end function

        public function addTab(param1:MovieClip) : void
        {
            var _loc_2:* = null;
            switch(this._teamNo)
            {
                case QuestConstant.TEAM_NO1:
                {
                    _loc_2 = param1.teamTab1;
                    break;
                }
                case QuestConstant.TEAM_NO2:
                {
                    _loc_2 = param1.teamTab2;
                    break;
                }
                case QuestConstant.TEAM_NO3:
                {
                    _loc_2 = param1.teamTab3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2 == null)
            {
                return;
            }
            return;
        }// end function

        public function addPiece(param1:LayerQuestMap, param2:int) : void
        {
            this.removePiece();
            this._piece = new QuestPiecePlayer(param1.getLayer(LayerQuestMap.PIECE), param2);
            return;
        }// end function

        public function removePiece() : void
        {
            if (this._piece != null)
            {
                this._piece.release();
            }
            return;
        }// end function

        public function movePiece(param1:int) : void
        {
            var _loc_2:* = QuestManager.getInstance().getSquare(param1);
            if (_loc_2 != null)
            {
                this._piece.setMovePos(_loc_2.x, _loc_2.y);
                this._piece.setSortPos(_loc_2.y);
                this._oldSquareId = this._squareId;
                this._squareId = param1;
                this._targetSquareId = Constant.UNDECIDED;
            }
            return;
        }// end function

        public function setPiece(param1:int) : void
        {
            var _loc_2:* = QuestManager.getInstance().getSquare(param1);
            if (_loc_2 != null)
            {
                this._piece.setPos(_loc_2.x, _loc_2.y);
                this._piece.setSortPos(_loc_2.y);
                this._oldSquareId = this._squareId;
                this._squareId = param1;
                this._targetSquareId = Constant.UNDECIDED;
            }
            return;
        }// end function

        public function addPlayer(param1:PlayerDisplay) : void
        {
            this._aPlayer.push(param1);
            this.bubbleSort((this._aPlayer.length - 1));
            return;
        }// end function

        public function removePlayer(param1:PlayerDisplay) : void
        {
            param1.removeParent();
            var _loc_2:* = 0;
            while (_loc_2 < this._aPlayer.length)
            {
                
                if (this._aPlayer[_loc_2] == param1)
                {
                    this._aPlayer.splice(_loc_2, 1);
                    return;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function clearPlayer() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aPlayer)
            {
                
                _loc_1.removeParent();
            }
            this._aPlayer = [];
            return;
        }// end function

        public function setFormation(param1:FormationSetData) : void
        {
            this._unitFormation = param1;
            var _loc_2:* = 1;
            while (_loc_2 < this._aPlayer.length)
            {
                
                this.bubbleSort(_loc_2);
                _loc_2++;
            }
            return;
        }// end function

        public function setPause(param1:Boolean) : void
        {
            this._bPause = param1;
            return;
        }// end function

        private function bubbleSort(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (this._unitFormation && param1 < this._aPlayer.length)
            {
                _loc_2 = this._unitFormation.aPlayerUniqueId;
                _loc_3 = this._aPlayer[param1];
                _loc_4 = _loc_2.indexOf(_loc_3.uniqueId);
                if (_loc_4 < 0)
                {
                    _loc_4 = this._aPlayer.length;
                }
                _loc_5 = param1 - 1;
                while (_loc_5 >= 0)
                {
                    
                    _loc_3 = this._aPlayer[_loc_5];
                    _loc_6 = _loc_2.indexOf(_loc_3.uniqueId);
                    if (_loc_6 < 0)
                    {
                        _loc_6 = this._aPlayer.length;
                    }
                    if (_loc_6 > _loc_4)
                    {
                        this._aPlayer[_loc_5] = this._aPlayer[(_loc_5 + 1)];
                        this._aPlayer[(_loc_5 + 1)] = _loc_3;
                    }
                    else
                    {
                        break;
                    }
                    _loc_5 = _loc_5 - 1;
                }
            }
            return;
        }// end function

    }
}
