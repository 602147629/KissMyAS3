package asset
{
    import message.*;
    import resource.*;

    public class AssetListManager extends Object
    {
        private var _loader:XmlLoader;
        private var _bCreated:Boolean;
        private var _aAssetInfo:Array;
        private static var _instance:AssetListManager = null;

        public function AssetListManager()
        {
            this._aAssetInfo = [];
            return;
        }// end function

        public function get bCreated() : Boolean
        {
            return this._bCreated;
        }// end function

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "AssetList.xml", this.cbLoadComplete, false);
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
                
                _loc_3 = new AssetInformation();
                _loc_3.setXml(_loc_2);
                this._aAssetInfo.push(_loc_3);
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        public function getAssetInfomation(param1:int) : AssetInformation
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aAssetInfo)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getAssetPng(param1:int) : String
        {
            var _loc_2:* = this.getAssetInfomation(param1);
            if (_loc_2)
            {
                return ResourcePath.ASSET_PATH + _loc_2.fileName;
            }
            return "";
        }// end function

        public function getAssetName(param1:int) : String
        {
            var _loc_2:* = this.getAssetInfomation(param1);
            if (_loc_2)
            {
                return _loc_2.name;
            }
            return "";
        }// end function

        public function getAssetLackMessage(param1:int) : String
        {
            return TextControl.formatIdText(MessageId.RESOURCE_NOT_ENOUGH, this.getAssetName(param1));
        }// end function

        public static function getInstance() : AssetListManager
        {
            if (_instance == null)
            {
                _instance = new AssetListManager;
            }
            return _instance;
        }// end function

    }
}
