package battle
{

    public class BattleBgListData extends Object
    {
        private var _id:int;
        private var _fileName:String;

        public function BattleBgListData()
        {
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get fileName() : String
        {
            return this._fileName;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = int(param1.id);
            this._fileName = String(param1.fileName);
            return;
        }// end function

    }
}
