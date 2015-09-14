package script
{
    import utility.*;

    public class ScriptComBalloonSetCharacter extends ScriptComBase
    {
        private var _name:String;
        private var _aName:Array;

        public function ScriptComBalloonSetCharacter()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            this._aName = [];
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            var _loc_3:* = null;
            super.setXml(param1);
            this._name = param1.name;
            var _loc_2:* = param1.characterName;
            if (_loc_2 != null)
            {
                for each (_loc_3 in _loc_2.children())
                {
                    
                    this._aName.push(String(_loc_3));
                }
            }
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().getBalloon(this._name);
            if (_loc_1 == null)
            {
                Assert.print("フキダシ【" + this._name + "】が作成されていません");
            }
            _loc_1.aCharacterName = this._aName;
            _bCommandEnd = true;
            return;
        }// end function

    }
}
