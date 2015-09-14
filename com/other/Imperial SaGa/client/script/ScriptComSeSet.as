package script
{
    import sound.*;

    public class ScriptComSeSet extends ScriptComBase
    {
        private var _id:int;

        public function ScriptComSeSet()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._id = param1.id;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            SoundManager.getInstance().loadSound(this._id);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
