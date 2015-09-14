package formationSkill
{
    import utility.*;

    public class FormationSkillInformation extends Object
    {
        private var _id:int;
        private var _skillName:String;
        private var _fileName:String;
        private var _skillPoint:int;
        private var _memberNum:int;
        private var _memberMaxNum:int;
        private var _memberMinNum:int;
        private var _activeRange:int;
        private var _attackPower:int;
        private var _equipWeponConditions:int;
        private var _explanation:String;

        public function FormationSkillInformation()
        {
            return;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = param1.id;
            this._skillName = param1.skillName;
            this._fileName = param1.fileName;
            this._skillPoint = param1.skillPoint;
            this._memberNum = param1.num;
            this._memberMaxNum = param1.maxNum;
            this._memberMinNum = param1.minNum;
            switch(int(param1.activeRange))
            {
                case 1:
                {
                    this._activeRange = FormationSkillConstant.ACTIVE_RANGE_SHORT_DISTANCE_SINGLE_ENEMY;
                    break;
                }
                case 2:
                {
                    this._activeRange = FormationSkillConstant.ACTIVE_RANGE_LONG_DISTANCE_SINGLE_ENEMY;
                    break;
                }
                case 3:
                {
                    this._activeRange = FormationSkillConstant.ACTIVE_RANGE_ALL_ENEMIES;
                    break;
                }
                case 4:
                {
                    this._activeRange = FormationSkillConstant.ACTIVE_RANGE_ALL_ALLIES;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._attackPower = param1.attackPower;
            this._equipWeponConditions = FormationSkillConstant.EQUIP_WEPON_CONDITIONS_NON;
            switch(int(param1.equipWeponConditions))
            {
                case FormationSkillConstant.EQUIP_WEPON_CONDITIONS_SWORD:
                {
                    this._equipWeponConditions = CommonConstant.CHARACTER_WEAPONTYPE_SWORD;
                    break;
                }
                case FormationSkillConstant.EQUIP_WEPON_CONDITIONS_AXE:
                {
                    this._equipWeponConditions = CommonConstant.CHARACTER_WEAPONTYPE_AX;
                    break;
                }
                case FormationSkillConstant.EQUIP_WEPON_CONDITIONS_BOW:
                {
                    this._equipWeponConditions = CommonConstant.CHARACTER_WEAPONTYPE_BOW;
                    break;
                }
                case FormationSkillConstant.EQUIP_WEPON_CONDITIONS_SPEAR:
                {
                    this._equipWeponConditions = CommonConstant.CHARACTER_WEAPONTYPE_SPEAR;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._explanation = StringTools.xmlLineToStringLine(param1.explanation);
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get skillName() : String
        {
            return this._skillName;
        }// end function

        public function get fileName() : String
        {
            return this._fileName;
        }// end function

        public function get skillPoint() : int
        {
            return this._skillPoint;
        }// end function

        public function get memberNum() : int
        {
            return this._memberNum;
        }// end function

        public function get memberMaxNum() : int
        {
            return this._memberMaxNum;
        }// end function

        public function get memberMinNum() : int
        {
            return this._memberMinNum;
        }// end function

        public function get activeRange() : int
        {
            return this._activeRange;
        }// end function

        public function get attackPower() : int
        {
            return this._attackPower;
        }// end function

        public function get equipWeponConditions() : int
        {
            return this._equipWeponConditions;
        }// end function

        public function get explanation() : String
        {
            return this._explanation;
        }// end function

    }
}
