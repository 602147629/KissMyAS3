package item
{
    import asset.*;
    import destinystone.*;
    import material.*;
    import message.*;
    import player.*;
    import resource.*;

    public class ItemManager extends Object
    {
        private var _aItem:Array;
        private var _aPaymentItem:Array;
        private var _aDestinyStoneInfo:Array;
        private var _aMaterialInfo:Array;
        private var _loader:XmlLoader;
        private var _loaderPayment:XmlLoader;
        private var _loaderDestinyStone:XmlLoader;
        private var _loaderMaterial:XmlLoader;
        private var _bCreated:Boolean;
        private var _bCreatedPayment:Boolean;
        private var _bCreatedDestinyStone:Boolean;
        private var _bCreatedMaterial:Boolean;
        private var _aShieldId:Array;
        private var _aPaymentEquipItemId:Array;
        private static var _instance:ItemManager = null;

        public function ItemManager()
        {
            this._aItem = [];
            this._aPaymentItem = [];
            this._aDestinyStoneInfo = [];
            this._aMaterialInfo = [];
            this._aShieldId = [];
            this._aPaymentEquipItemId = [];
            return;
        }// end function

        public function get bCreated() : Boolean
        {
            return this._bCreated;
        }// end function

        public function get bCreatedPayment() : Boolean
        {
            return this._bCreatedPayment;
        }// end function

        public function get bCreatedDestinyStone() : Boolean
        {
            return this._bCreatedDestinyStone;
        }// end function

        public function get bCreatedMaterial() : Boolean
        {
            return this._bCreatedMaterial;
        }// end function

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "ItemList.xml", this.cbLoadComplete, false);
            this._loaderPayment = new XmlLoader();
            this._loaderPayment.load(ResourcePath.PARAMETER_PATH + "PaymentItemList.xml", this.cbLoadPaymentItemComplete, false);
            this._loaderMaterial = new XmlLoader();
            this._loaderMaterial.load(ResourcePath.PARAMETER_PATH + "MaterialParameter.xml", this.cbLoadMaterialComplete, false);
            return;
        }// end function

        public function isLoaded() : Boolean
        {
            if (this._loader != null && this._loaderPayment != null && this._loaderMaterial != null)
            {
                return this._loader.bLoaded && this._loaderPayment.bLoaded && this._loaderMaterial.bLoaded;
            }
            return false;
        }// end function

        public function getItemInformation(param1:int) : ItemInformation
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aItem)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getItemStatus(param1:uint) : ItemStatus
        {
            var _loc_2:* = this.getItemInformation(param1);
            return _loc_2.itemStatus;
        }// end function

        public function getPaymentItemInformation(param1:int) : PaymentItemInformation
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aPaymentItem)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getDestinyStoneInformation(param1:int) : DestinyStoneInformation
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aDestinyStoneInfo)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getAssetInformation(param1:int) : AssetInformation
        {
            return AssetListManager.getInstance().getAssetInfomation(param1);
        }// end function

        public function getMaterialInformation(param1:int) : MaterialInformation
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aMaterialInfo)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getItemPng(param1:int, param2:int) : String
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = "";
            switch(param1)
            {
                case CommonConstant.ITEM_KIND_CROWN:
                {
                    _loc_3 = ResourcePath.ITEM_IMG_PATH + "Item_Gorld.png";
                    break;
                }
                case CommonConstant.ITEM_KIND_DESTINY_STONE:
                {
                    _loc_4 = this.getMaterialInformation(param2);
                    _loc_3 = ResourcePath.MATERIAL_PATH + _loc_4.fileName;
                    break;
                }
                case CommonConstant.ITEM_KIND_PAYMENT_ITEM:
                {
                    _loc_5 = this.getPaymentItemInformation(param2);
                    _loc_3 = ResourcePath.ITEM_IMG_PATH + _loc_5.fileName;
                    break;
                }
                case CommonConstant.ITEM_KIND_ACCESSORIES:
                {
                    _loc_6 = this.getItemInformation(param2);
                    _loc_3 = ResourcePath.EQUIPMENT_IMG_PATH + _loc_6.fileName;
                    break;
                }
                case CommonConstant.ITEM_KIND_WARRIOR:
                {
                    _loc_7 = PlayerManager.getInstance().getPlayerInformation(param2);
                    _loc_3 = ResourcePath.ITEM_IMG_PATH + PlayerManager.getInstance().getRarityWarriorCardFileName(_loc_7.rarity);
                    break;
                }
                case CommonConstant.ITEM_KIND_ASSET:
                {
                    _loc_3 = AssetListManager.getInstance().getAssetPng(param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public function getItemName(param1:int, param2:int) : String
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = "";
            switch(param1)
            {
                case CommonConstant.ITEM_KIND_CROWN:
                {
                    _loc_3 = MessageManager.getInstance().getMessage(MessageId.COMMON_NAME_CROWN);
                    break;
                }
                case CommonConstant.ITEM_KIND_DESTINY_STONE:
                {
                    _loc_4 = this.getMaterialInformation(param2);
                    _loc_3 = _loc_4.name;
                    break;
                }
                case CommonConstant.ITEM_KIND_PAYMENT_ITEM:
                {
                    _loc_5 = this.getPaymentItemInformation(param2);
                    _loc_3 = _loc_5.name;
                    break;
                }
                case CommonConstant.ITEM_KIND_ACCESSORIES:
                {
                    _loc_6 = this.getItemInformation(param2);
                    _loc_3 = _loc_6.name;
                    break;
                }
                case CommonConstant.ITEM_KIND_WARRIOR:
                {
                    _loc_7 = PlayerManager.getInstance().getPlayerInformation(param2);
                    _loc_3 = _loc_7.name;
                    break;
                }
                case CommonConstant.ITEM_KIND_ASSET:
                {
                    _loc_3 = AssetListManager.getInstance().getAssetName(param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public function getItemDescription(param1:int, param2:int) : String
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = "";
            switch(param1)
            {
                case CommonConstant.ITEM_KIND_CROWN:
                {
                    _loc_3 = "";
                    break;
                }
                case CommonConstant.ITEM_KIND_DESTINY_STONE:
                {
                    _loc_4 = this.getMaterialInformation(param2);
                    _loc_3 = _loc_4.description;
                    break;
                }
                case CommonConstant.ITEM_KIND_PAYMENT_ITEM:
                {
                    _loc_5 = this.getPaymentItemInformation(param2);
                    _loc_3 = _loc_5.description;
                    break;
                }
                case CommonConstant.ITEM_KIND_ACCESSORIES:
                {
                    _loc_6 = this.getItemInformation(param2);
                    _loc_3 = _loc_6.explanation;
                    break;
                }
                case CommonConstant.ITEM_KIND_ASSET:
                {
                    _loc_7 = AssetListManager.getInstance().getAssetInfomation(param2);
                    _loc_3 = _loc_7.description;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public function getItemUnit(param1:int, param2:int) : String
        {
            var _loc_3:* = "";
            switch(param1)
            {
                case CommonConstant.ITEM_KIND_CROWN:
                {
                    _loc_3 = "";
                    break;
                }
                case CommonConstant.ITEM_KIND_DESTINY_STONE:
                {
                    _loc_3 = MessageManager.getInstance().getMessage(MessageId.COMMON_UNIT_PIECES);
                    break;
                }
                case CommonConstant.ITEM_KIND_PAYMENT_ITEM:
                {
                    _loc_3 = MessageManager.getInstance().getMessage(MessageId.COMMON_UNIT_PIECES);
                    break;
                }
                case CommonConstant.ITEM_KIND_ACCESSORIES:
                {
                    _loc_3 = MessageManager.getInstance().getMessage(MessageId.COMMON_UNIT_PIECES);
                    break;
                }
                case CommonConstant.ITEM_KIND_WARRIOR:
                {
                    _loc_3 = "";
                    break;
                }
                case CommonConstant.ITEM_KIND_ASSET:
                {
                    if (param2 == AssetId.ASSET_GACHA_POINT)
                    {
                        _loc_3 = "";
                    }
                    else
                    {
                        _loc_3 = MessageManager.getInstance().getMessage(MessageId.COMMON_UNIT_PIECES);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        private function cbLoadComplete(param1:XML) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = uint(param1.Ver);
            var _loc_3:* = new VersionInfo();
            _loc_3.setVertion(CommonConstant.PARAMETER_VERSION_ITEM, _loc_2);
            Main.GetApplicationData().addVersion(_loc_3);
            for each (_loc_4 in param1.Data)
            {
                
                _loc_5 = new ItemInformation();
                _loc_5.setXml(_loc_4);
                this._aItem.push(_loc_5);
                if (_loc_5.category == CommonConstant.EQUIPMENTTYPE_SHIELD)
                {
                    this._aShieldId.push(_loc_5.id);
                }
                if (_loc_5.bSpecialItem)
                {
                    this._aPaymentEquipItemId.push(_loc_5.id);
                }
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        private function cbLoadPaymentItemComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1.Data)
            {
                
                _loc_3 = new PaymentItemInformation();
                _loc_3.setXml(_loc_2);
                this._aPaymentItem.push(_loc_3);
            }
            this._loaderPayment.release();
            this._loaderPayment = null;
            this._bCreatedPayment = true;
            return;
        }// end function

        private function cbLoadMaterialComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._aDestinyStoneInfo = [];
            this._aMaterialInfo = [];
            for each (_loc_2 in param1.Data)
            {
                
                _loc_3 = new MaterialInformation();
                _loc_3.setXml(_loc_2);
                this._aMaterialInfo.push(_loc_3);
                _loc_4 = new DestinyStoneInformation();
                _loc_4.setXml(_loc_2);
                this._aDestinyStoneInfo.push(_loc_4);
            }
            this._loaderMaterial.release();
            this._loaderMaterial = null;
            this._bCreatedMaterial = true;
            this._bCreatedDestinyStone = true;
            return;
        }// end function

        public function isShield(param1:int) : Boolean
        {
            if (this._aShieldId.indexOf(param1) != -1)
            {
                return true;
            }
            return false;
        }// end function

        public function isPaymetEquip(param1:int) : Boolean
        {
            if (this._aPaymentEquipItemId.indexOf(param1) != -1)
            {
                return true;
            }
            return false;
        }// end function

        public static function getInstance() : ItemManager
        {
            if (_instance == null)
            {
                _instance = new ItemManager;
            }
            return _instance;
        }// end function

    }
}
