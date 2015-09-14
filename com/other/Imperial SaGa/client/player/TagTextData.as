package player
{

    public class TagTextData extends Object
    {
        private var _tagTextType:int;
        private var _subId:int;
        private var _name:String;
        public static const TAG_TEXT_TYPE_SEX:int = 1;
        public static const TAG_TEXT_TYPE_SERIES:int = 2;
        public static const TAG_TEXT_TYPE_ARMY_TYPE:int = 3;
        public static const TAG_TEXT_TYPE_TAG:int = 4;

        public function TagTextData()
        {
            this._name = "";
            return;
        }// end function

        public function get tagTextType() : int
        {
            return this._tagTextType;
        }// end function

        public function get subId() : int
        {
            return this._subId;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._tagTextType = param1.tagTextType;
            this._subId = param1.tagTextId;
            this._name = param1.tagTextName;
            return;
        }// end function

    }
}
