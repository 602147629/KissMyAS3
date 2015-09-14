package material
{

    public class MaterialInformation extends Object
    {
        private var _id:int;
        private var _name:String;
        private var _description:String;
        private var _fileName:String;
        private var _rarity:int;

        public function MaterialInformation()
        {
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

        public function get description() : String
        {
            return this._description;
        }// end function

        public function get fileName() : String
        {
            return this._fileName;
        }// end function

        public function get rarity() : int
        {
            return this._rarity;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = param1.id;
            this._name = param1.name;
            this._description = "";
            this._fileName = param1.fileName;
            this._rarity = param1.rarity;
            return;
        }// end function

    }
}
