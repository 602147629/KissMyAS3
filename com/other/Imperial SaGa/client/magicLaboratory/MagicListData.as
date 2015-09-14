package magicLaboratory
{
    import skill.*;

    public class MagicListData extends Object
    {
        private var _skillId:int;
        private var _skillType:int;
        private var _skillDevelopLevel:int;
        private var _skillName:String;
        private var _isDeveloped:Boolean;
        private var _isImpossible:Boolean;

        public function MagicListData(param1:int, param2:Boolean, param3:Boolean)
        {
            this._skillId = param1;
            this._isDeveloped = param2;
            this._isImpossible = param3;
            var _loc_4:* = SkillManager.getInstance().getSkillInformation(this._skillId);
            this._skillName = _loc_4.name;
            switch(_loc_4.skillType)
            {
                case SkillConstant.SKILL_TYPE_FLAME:
                {
                    this._skillType = MagicDevelopList.SORT_MAGIC_FIRE;
                    break;
                }
                case SkillConstant.SKILL_TYPE_WATER:
                {
                    this._skillType = MagicDevelopList.SORT_MAGIC_WATER;
                    break;
                }
                case SkillConstant.SKILL_TYPE_EARTH:
                {
                    this._skillType = MagicDevelopList.SORT_MAGIC_EARTH;
                    break;
                }
                case SkillConstant.SKILL_TYPE_WIND:
                {
                    this._skillType = MagicDevelopList.SORT_MAGIC_WIND;
                    break;
                }
                case SkillConstant.SKILL_TYPE_LIGHT:
                {
                    this._skillType = MagicDevelopList.SORT_MAGIC_LIGHT;
                    break;
                }
                case SkillConstant.SKILL_TYPE_HADES:
                {
                    this._skillType = MagicDevelopList.SORT_MAGIC_HADES;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._skillDevelopLevel = _loc_4.rank;
            return;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        public function get skillType() : int
        {
            return this._skillType;
        }// end function

        public function get skillDevelopLevel() : int
        {
            return this._skillDevelopLevel;
        }// end function

        public function get skillName() : String
        {
            return this._skillName;
        }// end function

        public function get isDeveloped() : Boolean
        {
            return this._isDeveloped;
        }// end function

        public function set isDeveloped(param1:Boolean) : void
        {
            this._isDeveloped = param1;
            return;
        }// end function

        public function get isImpossible() : Boolean
        {
            return this._isImpossible;
        }// end function

        public function set isImpossible(param1:Boolean) : void
        {
            this._isImpossible = param1;
            return;
        }// end function

    }
}
