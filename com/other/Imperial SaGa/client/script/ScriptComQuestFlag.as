package script
{
    import quest.*;

    public class ScriptComQuestFlag extends ScriptComBase
    {
        private var _id:int;
        private var _value:Boolean;

        public function ScriptComQuestFlag()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._id = parseInt(param1.id);
            this._value = Boolean(parseInt(param1.id.@value));
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            if (ScriptManager.getInstance().isPaymentEvent())
            {
                QuestManager.getInstance().addPaymentEventQuestFlag(this._id);
            }
            QuestManager.getInstance().setQuestFlag(this._id, this._value);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
