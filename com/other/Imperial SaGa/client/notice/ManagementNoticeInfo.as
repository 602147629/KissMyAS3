package notice
{

    public class ManagementNoticeInfo extends Object
    {
        private var _type:int;
        private var _title:String;
        private var _param1:String;
        private var _param2:String;

        public function ManagementNoticeInfo()
        {
            return;
        }// end function

        public function setNoticeInfo(param1:Object) : void
        {
            this._type = param1.type;
            this._title = param1.title;
            this._param1 = param1.param1;
            this._param2 = param1.param2;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function get title() : String
        {
            return this._title;
        }// end function

        public function get param1() : String
        {
            return this._param1;
        }// end function

        public function get param2() : String
        {
            return this._param2;
        }// end function

    }
}
