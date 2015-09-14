package quest
{

    public class QuestRemunerationData extends Object
    {
        private var _categoryId:int;
        private var _itemId:int;
        private var _num:int;

        public function QuestRemunerationData()
        {
            return;
        }// end function

        public function setRemunerationData(param1:Object) : void
        {
            this._categoryId = param1.category;
            this._itemId = param1.itemId;
            this._num = param1.num;
            return;
        }// end function

        public function get categoryId() : int
        {
            return this._categoryId;
        }// end function

        public function get itemId() : int
        {
            return this._itemId;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

    }
}
