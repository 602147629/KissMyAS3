package questSelect
{

    public class BannerData extends Object
    {
        private var _index:int;
        private var _bannerPath:String;
        private var _url:String;

        public function BannerData()
        {
            this._index = 0;
            this._bannerPath = "";
            this._url = "";
            return;
        }// end function

        public function setRecieve(param1:Object, param2:int) : void
        {
            this._index = param2;
            this._bannerPath = param1.bannerPath;
            this._url = param1.urlPath;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function get bannerPath() : String
        {
            return this._bannerPath;
        }// end function

        public function get url() : String
        {
            return this._url;
        }// end function

    }
}
