package area
{
    import resource.*;

    public class AreaManager extends Object
    {
        private var _loader:XmlLoader;
        private var _aArea:Array;
        private var _bCreated:Boolean;
        private static var _instance:AreaManager = null;

        public function AreaManager()
        {
            return;
        }// end function

        public function get bCreated() : Boolean
        {
            return this._bCreated;
        }// end function

        public function isLoaded() : Boolean
        {
            if (this._loader != null)
            {
                return this._loader.bLoaded;
            }
            return false;
        }// end function

        public function init() : void
        {
            return;
        }// end function

        public function loadData() : void
        {
            this._aArea = new Array();
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "AreaInformationList.xml", this.cbComplete, false);
            return;
        }// end function

        private function cbComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1.Area)
            {
                
                _loc_3 = new AreaData();
                _loc_3.setXml(_loc_2);
                this._aArea.push(_loc_3);
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        public function getAllArea() : Array
        {
            return this._aArea;
        }// end function

        public function getArea(param1:int) : AreaData
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aArea)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return _loc_2;
        }// end function

        public static function getInstance() : AreaManager
        {
            if (_instance == null)
            {
                _instance = new AreaManager;
            }
            return _instance;
        }// end function

    }
}
