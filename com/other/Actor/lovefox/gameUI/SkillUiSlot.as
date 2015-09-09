package lovefox.gameUI
{
    import lovefox.game.*;

    public class SkillUiSlot extends Slot
    {
        public var _level:Object;
        public var _skill:Object;

        public function SkillUiSlot(param1, param2)
        {
            super(param1, param2);
            this.init();
            return;
        }// end function

        override public function init()
        {
            super.init();
            return;
        }// end function

        public function get level()
        {
            return this._level;
        }// end function

        public function set level(param1)
        {
            this._level = param1;
            if (this._level < 1)
            {
                gray = true;
                buttonMode = false;
            }
            else
            {
                gray = false;
                if (this._skill._skillData.skillType == 1)
                {
                    buttonMode = false;
                }
                else
                {
                    buttonMode = true;
                }
            }
            return;
        }// end function

        public function set skill(param1:Skill)
        {
            this._skill = param1;
            if (this._skill != null)
            {
                _container.addChild(this._skill.getDisplay());
                if (this._skill._skillData.skillType == 1 || this._level < 1)
                {
                    buttonMode = false;
                }
                else
                {
                    buttonMode = true;
                }
            }
            else
            {
                this.level = 0;
                buttonMode = false;
            }
            return;
        }// end function

        public function get skill() : Skill
        {
            return this._skill;
        }// end function

    }
}
