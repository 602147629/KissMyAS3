package makeEquip
{

    public class RecipeParameter extends Object
    {
        private var _id:int;
        private var _category:int;
        private var _recipeLv:int;
        private var _rank:int;
        private var _materialLimit:int;
        private var _aSlot:Array;

        public function RecipeParameter()
        {
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get category() : int
        {
            return this._category;
        }// end function

        public function get recipeLv() : int
        {
            return this._recipeLv;
        }// end function

        public function get rank() : int
        {
            return this._rank;
        }// end function

        public function get facilityLv() : int
        {
            return this._rank;
        }// end function

        public function get materialLimit() : int
        {
            return this._materialLimit;
        }// end function

        public function get aSlot() : Array
        {
            return this._aSlot;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = param1.id;
            this._category = param1.category;
            this._recipeLv = this.recipeLv;
            this._rank = param1.rank;
            this._materialLimit = param1.materialLimit;
            this._aSlot = [];
            this._aSlot.push(int(param1.slot1));
            this._aSlot.push(int(param1.slot2));
            this._aSlot.push(int(param1.slot3));
            return;
        }// end function

    }
}
