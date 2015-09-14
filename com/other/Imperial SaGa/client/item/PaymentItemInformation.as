package item
{
    import utility.*;

    public class PaymentItemInformation extends Object
    {
        private var _itemId:int;
        private var _itemName:String;
        private var _fileName:String;
        private var _bEquipItem:Boolean;
        private var _bSetItem:Boolean;
        private var _price:int;
        private var _useCount:int;
        private var _description:String;

        public function PaymentItemInformation()
        {
            return;
        }// end function

        public function get id() : int
        {
            return this._itemId;
        }// end function

        public function get name() : String
        {
            return this._itemName;
        }// end function

        public function get fileName() : String
        {
            return this._fileName;
        }// end function

        public function get bEquipItem() : Boolean
        {
            return this._bEquipItem;
        }// end function

        public function get bSetItem() : Boolean
        {
            return this._bSetItem;
        }// end function

        public function get price() : int
        {
            return this._price;
        }// end function

        public function get useCount() : int
        {
            return this._useCount;
        }// end function

        public function get description() : String
        {
            return this._description;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._itemId = parseInt(param1.id);
            this._itemName = param1.name;
            this._fileName = param1.fileName;
            this._bEquipItem = int(param1.equip) == 1;
            this._price = param1.crown;
            this._useCount = param1.useCount;
            this._description = StringTools.xmlLineToStringLine(param1.description);
            this._bSetItem = this._useCount > 1;
            return;
        }// end function

    }
}
