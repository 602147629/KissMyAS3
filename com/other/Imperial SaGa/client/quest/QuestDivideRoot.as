package quest
{

    public class QuestDivideRoot extends Object
    {
        private var _aDivideSquareId:Array;
        private var _aSquare:Array;
        private var _aJoint:Array;
        private var _aNode:Array;

        public function QuestDivideRoot()
        {
            this._aDivideSquareId = [];
            this._aSquare = null;
            this._aJoint = null;
            this._aNode = null;
            return;
        }// end function

        public function get aDivideSquareId() : Array
        {
            return this._aDivideSquareId;
        }// end function

        public function isDivideRootSquare(param1:int) : Boolean
        {
            return this._aDivideSquareId.indexOf(param1) >= 0;
        }// end function

        public function searchDivideSquare(param1:Array, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            this._aDivideSquareId = [];
            this._aSquare = param1;
            this._aJoint = [];
            this._aNode = [];
            for each (_loc_3 in this._aSquare)
            {
                
                _loc_4 = this.getPrevSquare(_loc_3.id);
                if (_loc_4.length > 1)
                {
                    this._aJoint.push(new QuestDivideJoint(_loc_3, _loc_4));
                }
            }
            _loc_3 = this.getSquare(param2);
            if (_loc_3)
            {
                _loc_5 = 28;
                this._aNode.push(_loc_3);
                while (this._aNode.length > 0 && _loc_5 > 0)
                {
                    
                    this.search(this._aNode.shift());
                    _loc_5 = _loc_5 - 1;
                }
            }
            this._aSquare = null;
            this._aJoint = null;
            this._aNode = null;
            return;
        }// end function

        private function getSquare(param1:int) : QuestSquare
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aSquare)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function getPrevSquare(param1:int) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._aSquare)
            {
                
                if (_loc_3.id != param1)
                {
                    if (_loc_3.aConnectionId.indexOf(param1) >= 0)
                    {
                        _loc_2.push(_loc_3);
                    }
                }
            }
            return _loc_2;
        }// end function

        private function getJoin(param1:int) : QuestDivideJoint
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aJoint)
            {
                
                if (_loc_2.jointSquare.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function countNode(param1:int) : int
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            for each (_loc_3 in this._aNode)
            {
                
                if (_loc_3.id == param1)
                {
                    _loc_2++;
                }
            }
            return _loc_2;
        }// end function

        private function removeNode(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aNode.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aNode[_loc_2];
                if (_loc_3.id == param1)
                {
                    this._aNode.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        private function search(param1:QuestSquare) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            while (param1)
            {
                
                _loc_2 = this.getJoin(param1.id);
                if (_loc_2)
                {
                    if (1 + this.countNode(param1.id) < _loc_2.aPrevSquare.length)
                    {
                        this._aNode.push(param1);
                        return;
                    }
                    this.removeNode(param1.id);
                    if (this._aDivideSquareId.indexOf(param1.id) < 0)
                    {
                        this._aDivideSquareId.push(param1.id);
                    }
                }
                else if (this._aNode.length > 0)
                {
                    if (this._aDivideSquareId.indexOf(param1.id) < 0)
                    {
                        this._aDivideSquareId.push(param1.id);
                    }
                }
                if (param1.aConnectionId.length >= 2)
                {
                    _loc_3 = [];
                    for each (_loc_5 in param1.aConnectionId)
                    {
                        
                        _loc_4 = this.getSquare(_loc_5);
                        if (_loc_4)
                        {
                            _loc_3.push(_loc_4);
                        }
                    }
                    if (_loc_3.length == 1)
                    {
                        param1 = _loc_3[0];
                        continue;
                    }
                    else
                    {
                        for each (_loc_4 in _loc_3)
                        {
                            
                            this._aNode.push(_loc_4);
                        }
                        return;
                    }
                }
                if (param1.aConnectionId.length <= 0 || param1.aConnectionId[0] == Constant.EMPTY_ID)
                {
                    return;
                }
                param1 = this.getSquare(param1.aConnectionId[0]);
            }
            return;
        }// end function

    }
}

class QuestDivideJoint extends Object
{
    public var jointSquare:QuestSquare;
    public var aPrevSquare:Array;

    function QuestDivideJoint(param1:QuestSquare, param2:Array)
    {
        this.jointSquare = param1;
        this.aPrevSquare = param2;
        return;
    }// end function

}

