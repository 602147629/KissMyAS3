package item
{
    import battle.*;
    import character.*;
    import utility.*;

    public class ItemInformation extends Object
    {
        private var _id:uint;
        private var _name:String;
        private var _fileName:String;
        private var _itemRank:int;
        private var _bSpecialItem:Boolean;
        protected var _category:int;
        private var _itemStatus:ItemStatus;
        private var _explanation:String;

        public function ItemInformation()
        {
            return;
        }// end function

        public function get id() : uint
        {
            return this._id;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get fileName() : String
        {
            return this._fileName;
        }// end function

        public function get itemRank() : int
        {
            return this._itemRank;
        }// end function

        public function get bSpecialItem() : Boolean
        {
            return this._bSpecialItem;
        }// end function

        public function get category() : int
        {
            return this._category;
        }// end function

        public function get itemStatus() : ItemStatus
        {
            return this._itemStatus;
        }// end function

        public function get shieldType() : int
        {
            return BattleConstant.DEFENSE_SHIELD_NON;
        }// end function

        public function get explanation() : String
        {
            return this._explanation;
        }// end function

        public function get explanationDecomposition() : String
        {
            return this._explanation;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = param1.id;
            this._name = param1.name;
            this._fileName = param1.fileName;
            this._itemRank = param1.itemRank;
            this._bSpecialItem = parseInt(param1.specialItem) == 1;
            switch(int(param1.categoryId))
            {
                case 1:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_SHORTSWORD;
                    break;
                }
                case 2:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_SWORD;
                    break;
                }
                case 3:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_GREATSWORD;
                    break;
                }
                case 4:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_BLADE;
                    break;
                }
                case 5:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_AX;
                    break;
                }
                case 6:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_CLUB;
                    break;
                }
                case 7:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_STAFF;
                    break;
                }
                case 8:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_BOW;
                    break;
                }
                case 9:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_SPEAR;
                    break;
                }
                case 10:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_GLAPPLING;
                    break;
                }
                case 11:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_ARMOR;
                    break;
                }
                case 12:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_SHIELD;
                    break;
                }
                case 13:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_CLOTHES;
                    break;
                }
                case 14:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_HAT;
                    break;
                }
                case 15:
                {
                    this._category = CommonConstant.EQUIPMENTTYPE_ACCESSORIES;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_2:* = [new BattleToleranceData(CharacterConstant.ATTRIBUTE_SLASH, int(param1.DefenseEffect.cut)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_PUNCH, int(param1.DefenseEffect.strike)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_THRUST, int(param1.DefenseEffect.stabb)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_HEAT, int(param1.DefenseEffect.heat)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_ICY, int(param1.DefenseEffect.cold)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_THUNDER, int(param1.DefenseEffect.thunder))];
            var _loc_3:* = [new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_INSTANT_DEATH, int(param1.SpecialStatus.death)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_PARALYSIS, int(param1.SpecialStatus.paralysis)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_HYPNOTIC, int(param1.SpecialStatus.hypnotism)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_DARKNESS, int(param1.SpecialStatus.darkness)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_POISON, int(param1.SpecialStatus.poinson)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_STAN, int(param1.SpecialStatus.stan)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_CHARM, int(param1.SpecialStatus.charm)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_CONFUSION, int(param1.SpecialStatus.confusion)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_STONE, int(param1.SpecialStatus.stone))];
            this._itemStatus = new ItemStatus();
            this._itemStatus.setStatus(param1.AddStatus.attack, param1.AddStatus.defense, param1.AddStatus.speed, param1.AddStatus.magic, _loc_2, _loc_3);
            this._explanation = StringTools.xmlLineToStringLine(param1.comment);
            return;
        }// end function

    }
}
