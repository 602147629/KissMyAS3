package tradingPost
{
    import item.*;

    public class PaymentPlanItem extends Object
    {
        private var _itemType:int;
        private var _itemId:int;
        private var _num:int;

        public function PaymentPlanItem()
        {
            return;
        }// end function

        public function get category() : int
        {
            return this._itemType;
        }// end function

        public function get itemId() : int
        {
            return this._itemId;
        }// end function

        public function get num() : uint
        {
            return this._num;
        }// end function

        public function setRecieve(param1:Object) : void
        {
            this._itemType = param1.item_type;
            this._itemId = param1.item_id;
            this._num = param1.num;
            return;
        }// end function

        public function checkEnable() : Boolean
        {
            return this.category != Constant.EMPTY_ID && this.itemId != Constant.EMPTY_ID;
        }// end function

        public function getName() : String
        {
            return ItemManager.getInstance().getItemName(this.category, this.itemId);
        }// end function

        public function getFileName() : String
        {
            return ItemManager.getInstance().getItemPng(this.category, this.itemId);
        }// end function

        public function getDescription() : String
        {
            return ItemManager.getInstance().getItemDescription(this.category, this.itemId);
        }// end function

    }
}
