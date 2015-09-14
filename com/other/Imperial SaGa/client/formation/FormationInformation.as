package formation
{
    import utility.*;

    public class FormationInformation extends Object
    {
        private var _id:int;
        private var _name:String;
        private var _member:int;
        private var _aElement:Array;
        private var _formationSkillId:int;
        private var _explanation:String;

        public function FormationInformation()
        {
            this._aElement = new Array();
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get member() : int
        {
            return this._member;
        }// end function

        public function get aElement() : Array
        {
            return this._aElement;
        }// end function

        public function get formationSkillId() : int
        {
            return this._formationSkillId;
        }// end function

        public function get explanation() : String
        {
            return this._explanation;
        }// end function

        public function get aAttackCorrectionValue() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aElement)
            {
                
                _loc_1.push(_loc_2.attack);
            }
            return _loc_1;
        }// end function

        public function get aDefenseCorrectionValue() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aElement)
            {
                
                _loc_1.push(_loc_2.defense);
            }
            return _loc_1;
        }// end function

        public function get aSpeedCorrectionValue() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aElement)
            {
                
                _loc_1.push(_loc_2.speed);
            }
            return _loc_1;
        }// end function

        public function get aMagicCorrectionValue() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aElement)
            {
                
                _loc_1.push(_loc_2.magic);
            }
            return _loc_1;
        }// end function

        public function get aProbability() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aElement)
            {
                
                _loc_1.push(_loc_2.probability);
            }
            return _loc_1;
        }// end function

        public function get aRowPosition() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aElement)
            {
                
                _loc_1.push(_loc_2.rowPosition);
            }
            return _loc_1;
        }// end function

        public function get aColumnPosition() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aElement)
            {
                
                _loc_1.push(_loc_2.columnPosition);
            }
            return _loc_1;
        }// end function

        public function setXml(param1:XML) : void
        {
            var _loc_2:* = null;
            this._id = param1.id;
            this._name = param1.name;
            this._member = param1.member;
            this._formationSkillId = param1.formationSkillId;
            this._explanation = StringTools.xmlLineToStringLine(param1.explanation);
            for each (param1 in param1.param)
            {
                
                _loc_2 = new FormationParam(param1);
                this._aElement.push(_loc_2);
            }
            return;
        }// end function

        public function getAttackCorrectionValue(param1:int, param2:int) : int
        {
            var _loc_3:* = this._aElement[param1];
            if (_loc_3 && (_loc_3.condition == 0 || _loc_3.condition == param2))
            {
                return _loc_3.attack;
            }
            return 0;
        }// end function

        public function getDefenseCorrectionValue(param1:int, param2:int) : int
        {
            var _loc_3:* = this._aElement[param1];
            if (_loc_3 && (_loc_3.condition == 0 || _loc_3.condition == param2))
            {
                return _loc_3.defense;
            }
            return 0;
        }// end function

        public function getSpeedCorrectionValue(param1:int, param2:int) : int
        {
            var _loc_3:* = this._aElement[param1];
            if (_loc_3 && (_loc_3.condition == 0 || _loc_3.condition == param2))
            {
                return _loc_3.speed;
            }
            return 0;
        }// end function

        public function getMagicCorrectionValue(param1:int, param2:int) : int
        {
            var _loc_3:* = this._aElement[param1];
            if (_loc_3 && (_loc_3.condition == 0 || _loc_3.condition == param2))
            {
                return _loc_3.magic;
            }
            return 0;
        }// end function

    }
}
