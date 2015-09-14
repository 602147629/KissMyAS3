package facility
{
    import resource.*;

    public class FacilityListManager extends Object
    {
        private var _loader:XmlLoader;
        private var _bCreated:Boolean;
        private var _aFacilityList:Array;
        private var _idObj:Object;
        private static var _instance:FacilityListManager = null;

        public function FacilityListManager()
        {
            this._aFacilityList = [];
            this._idObj = new Object();
            return;
        }// end function

        public function get bCreated() : Boolean
        {
            return this._bCreated;
        }// end function

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "FacilityList.xml", this.cbLoadComplete, false);
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
            var _loc_4:* = null;
            for each (_loc_2 in param1.Data)
            {
                
                _loc_3 = new FacilityList();
                _loc_3.setXml(_loc_2);
                this._aFacilityList.push(_loc_3);
                _loc_4 = this._idObj[_loc_3.id];
                if (_loc_4 == null)
                {
                    _loc_4 = new Array();
                    this._idObj[_loc_3.id] = _loc_4;
                }
                _loc_4.push(_loc_3);
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        public function getFacilityListTable(param1:int) : Array
        {
            var _loc_2:* = this._idObj[param1];
            if (_loc_2 != null)
            {
                return _loc_2;
            }
            return [];
        }// end function

        public static function getInstance() : FacilityListManager
        {
            if (_instance == null)
            {
                _instance = new FacilityListManager;
            }
            return _instance;
        }// end function

    }
}
