package item
{

    public class OwnMaterialData extends Object
    {
        private var _materialId:int;
        private var _num:int;

        public function OwnMaterialData(param1:int, param2:int)
        {
            this._materialId = param1;
            this._num = param2;
            return;
        }// end function

        public function get materialId() : int
        {
            return this._materialId;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

    }
}
