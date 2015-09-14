package trainingRoom
{
    import resource.*;

    public class KumiteListManager extends Object
    {
        private var _loader:XmlLoader;
        private var _bCreated:Boolean;
        private var _aKumiteList:Array;
        private static var _instance:KumiteListManager = null;

        public function KumiteListManager()
        {
            this._aKumiteList = [];
            return;
        }// end function

        public function get bCreated() : Boolean
        {
            return this._bCreated;
        }// end function

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "KumiteList.xml", this.cbLoadComplete, false);
            return;
        }// end function

        public function isLoaded() : Boolean
        {
            if (this._loader != null)
            {
                return this._loader.bLoaded;
            }
            return false;
        }// end function

        private function cbLoadComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1.Data)
            {
                
                _loc_3 = new KumiteList();
                _loc_3.setXml(_loc_2);
                this._aKumiteList.push(_loc_3);
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        public function getKumiteList(param1:int) : KumiteList
        {
            var _loc_2:* = null;
            var _loc_3:* = this._aKumiteList.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_2 = this._aKumiteList[_loc_3];
                if (_loc_2.rank <= param1)
                {
                    return _loc_2;
                }
                _loc_3 = _loc_3 - 1;
            }
            return _loc_2;
        }// end function

        public static function getInstance() : KumiteListManager
        {
            if (_instance == null)
            {
                _instance = new KumiteListManager;
            }
            return _instance;
        }// end function

    }
}
