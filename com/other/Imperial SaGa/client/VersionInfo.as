package 
{

    public class VersionInfo extends Object
    {
        private var _id:int;
        private var _ver:uint;

        public function VersionInfo()
        {
            return;
        }// end function

        public function setVersionInfo(param1:Object) : void
        {
            this.setVertion(param1.id, param1.ver);
            return;
        }// end function

        public function setVertion(param1:int, param2:uint) : void
        {
            this._id = param1;
            this._ver = param2;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get ver() : uint
        {
            return this._ver;
        }// end function

    }
}
