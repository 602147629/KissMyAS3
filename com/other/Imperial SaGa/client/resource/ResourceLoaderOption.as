package resource
{

    public class ResourceLoaderOption extends Object
    {
        private var _bUrl:Boolean;
        private var _bNotEncryption:Boolean;
        private var _bNotDecryption:Boolean;

        public function ResourceLoaderOption()
        {
            this._bUrl = false;
            this._bNotEncryption = false;
            this._bNotDecryption = false;
            return;
        }// end function

        public function get bUrl() : Boolean
        {
            return this._bUrl;
        }// end function

        public function set bUrl(param1:Boolean) : void
        {
            this._bUrl = param1;
            return;
        }// end function

        public function get bNotEncryption() : Boolean
        {
            return this._bNotEncryption;
        }// end function

        public function set bNotEncryption(param1:Boolean) : void
        {
            this._bNotEncryption = param1;
            return;
        }// end function

        public function get bNotDecryption() : Boolean
        {
            return this._bNotDecryption;
        }// end function

        public function set bNotDecryption(param1:Boolean) : void
        {
            this._bNotDecryption = param1;
            return;
        }// end function

    }
}
