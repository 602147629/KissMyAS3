package player
{
    import character.*;
    import message.*;
    import resource.*;
    import skill.*;

    public class PlayerManager extends Object
    {
        private const _WORDS_SCENE_STATUS_UP:int = 1;
        private const _WORDS_SCENE_CONFLUENCE:int = 2;
        private const _WORDS_SCENE_LOST:int = 3;
        private const _WORDS_SCENE_EMPLOYMENT:int = 4;
        private const _WORDS_SCENE_LIMITED_EMPLOY_READY:int = 5;
        private const _WORDS_SCENE_LIMITED_EMPLOY_FINISH:int = 6;
        private const _aWeaponLabelTable:Array;
        private var _bCreated:Boolean;
        private var _bCreatedGrowth:Boolean;
        private var _bCreatedTag:Boolean;
        private var _bCreatedCommanderSkill:Boolean;
        private var _loader:XmlLoader;
        private var _loaderGrowth:XmlLoader;
        private var _loaderTag:XmlLoader;
        private var _loaderCommanderSkill:XmlLoader;
        private var _aPlayerInfo:Array;
        private var _aWords:Array;
        private var _aEmperorSkill:Array;
        private var _aCharacterBgm:Array;
        private var _aGrowthParameter:Array;
        private var _aTagText:Array;
        private var _aCommanderSkill:Array;
        private var _aSpStopPlayerUniqueId:Array;
        private static var _instance:PlayerManager = null;

        public function PlayerManager()
        {
            this._aWeaponLabelTable = ["weaponType1", "weaponType3", "weaponType6", "weaponType2", "weaponType1", "weaponType1", "weaponType4", "weaponType5", "weaponType8", "weaponType7"];
            this._aPlayerInfo = [];
            this._aWords = [];
            this._aEmperorSkill = [];
            this._aCharacterBgm = [];
            this._aGrowthParameter = [];
            this._aTagText = [];
            this._aCommanderSkill = [];
            this._aSpStopPlayerUniqueId = [];
            return;
        }// end function

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "PlayerParameter.xml", this.cbLoadComplete, false);
            this._loaderGrowth = new XmlLoader();
            this._loaderGrowth.load(ResourcePath.PARAMETER_PATH + "GrowthParameter.xml", this.cbLoadGrowthParameterComplete, false);
            this._loaderTag = new XmlLoader();
            this._loaderTag.load(ResourcePath.PARAMETER_PATH + "TagText.xml", this.cbLoadTagTextComplete, false);
            this._loaderCommanderSkill = new XmlLoader();
            this._loaderCommanderSkill.load(ResourcePath.PARAMETER_PATH + "CommanderSkill.xml", this.cbLoadCommanderSkillComplete, false);
            return;
        }// end function

        public function getPlayerResourcePath(param1:int) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = this.getPlayerInformation(param1);
            if (_loc_3 != null)
            {
                _loc_2.push(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf");
                _loc_2.push(ResourcePath.PLAYER_PATH + _loc_3.swf);
            }
            return _loc_2;
        }// end function

        public function getPlayerInformation(param1:int) : PlayerInformation
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = this._aPlayerInfo.length - 1;
            while (_loc_2 <= _loc_3)
            {
                
                _loc_4 = (_loc_2 + _loc_3) / 2;
                _loc_5 = this._aPlayerInfo[_loc_4];
                if (param1 <= _loc_5.id)
                {
                    if (_loc_5.id == param1)
                    {
                        return _loc_5;
                    }
                    _loc_3 = _loc_4 - 1;
                    continue;
                }
                _loc_2 = _loc_4 + 1;
            }
            return null;
        }// end function

        public function getPlayerInformationByCharacterId(param1:int) : PlayerInformation
        {
            var _loc_3:* = null;
            var _loc_2:* = null;
            for each (_loc_3 in this._aPlayerInfo)
            {
                
                if (_loc_3.characterId == param1)
                {
                    if (_loc_2 == null || this.cmpRarityValue(_loc_3.rarity, _loc_2.rarity) < 0)
                    {
                        _loc_2 = _loc_3;
                    }
                }
            }
            return _loc_2;
        }// end function

        public function getResourcePath(param1:int) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = this.getPlayerInformation(param1);
            if (_loc_3 != null)
            {
                _loc_2.push(ResourcePath.PLAYER_PATH + _loc_3.swf);
                ;
            }
            return _loc_2;
        }// end function

        public function getResourceImgBastupPath(param1:int) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = this.getPlayerInformation(param1);
            if (_loc_3 != null)
            {
                _loc_2.push(ResourcePath.PLAYER_BUSTUP_PATH + _loc_3.bustUpFileName);
                ;
            }
            return _loc_2;
        }// end function

        public function getResourceBustupPath(param1:int) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = this.getPlayerInformation(param1);
            if (_loc_3 != null)
            {
                _loc_2.push(ResourcePath.PLAYER_PATH + _loc_3.swf);
                _loc_2.push(ResourcePath.PLAYER_BUSTUP_PATH + _loc_3.bustUpFileName);
                ;
            }
            return _loc_2;
        }// end function

        public function getWordStatusUp(param1:int, param2:Array = null) : String
        {
            return this.getWord(param1, this._WORDS_SCENE_STATUS_UP, param2);
        }// end function

        public function getWordMergeParty(param1:int, param2:Array = null) : String
        {
            return this.getWord(param1, this._WORDS_SCENE_CONFLUENCE, param2);
        }// end function

        public function getWordLost(param1:int, param2:Array = null) : String
        {
            return this.getWord(param1, this._WORDS_SCENE_LOST, param2);
        }// end function

        public function getWordEmployment(param1:int, param2:Array = null) : String
        {
            return this.getWord(param1, this._WORDS_SCENE_EMPLOYMENT, param2);
        }// end function

        public function getWordLimitedEmploymentReady(param1:int, param2:Array = null) : String
        {
            return this.getWord(param1, this._WORDS_SCENE_LIMITED_EMPLOY_READY, param2);
        }// end function

        public function getWordLimitedEmploymentFinish(param1:int, param2:Array = null) : String
        {
            return this.getWord(param1, this._WORDS_SCENE_LIMITED_EMPLOY_FINISH, param2);
        }// end function

        private function getWord(param1:int, param2:int, param3:Array) : String
        {
            var _loc_6:* = null;
            if (param3 == null)
            {
                param3 = [];
            }
            var _loc_4:* = null;
            var _loc_5:* = 0;
            while (_loc_5 < this._aWords.length)
            {
                
                _loc_6 = this._aWords[_loc_5];
                if (_loc_6.id == param1 && _loc_6.scene == param2)
                {
                    if (_loc_6.partnerId == Constant.EMPTY_ID)
                    {
                        _loc_4 = _loc_6;
                    }
                    else if (param3.indexOf(_loc_6.partnerId) >= 0)
                    {
                        return _loc_6.message;
                    }
                }
                _loc_5++;
            }
            return _loc_4 ? (_loc_4.message) : ("");
        }// end function

        public function isLoaded() : Boolean
        {
            if (this._loader != null && this._loaderGrowth != null && this._loaderTag != null && this._loaderCommanderSkill != null)
            {
                return this._loader.bLoaded && this._loaderGrowth.bLoaded && this._loaderTag.bLoaded && this._loaderCommanderSkill.bLoaded;
            }
            return false;
        }// end function

        private function cbLoadComplete(param1:XML) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_2:* = uint(param1.Ver);
            var _loc_3:* = new VersionInfo();
            _loc_3.setVertion(CommonConstant.PARAMETER_VERSION_PLAYER, _loc_2);
            Main.GetApplicationData().addVersion(_loc_3);
            var _loc_4:* = param1.Param;
            for each (_loc_5 in _loc_4.children())
            {
                
                _loc_12 = new PlayerInformation();
                _loc_12.setXml(_loc_5);
                this._aPlayerInfo.push(_loc_12);
            }
            this._aPlayerInfo.sortOn("id");
            _loc_6 = param1.Words;
            for each (_loc_7 in _loc_6.children())
            {
                
                _loc_13 = new PlayerWord();
                _loc_13.setXml(_loc_7);
                this._aWords.push(_loc_13);
            }
            _loc_8 = param1.EmperorSkill;
            for each (_loc_9 in _loc_8.children())
            {
                
                _loc_14 = new PlayerEmperorSkill();
                _loc_14.setXml(_loc_9);
                this._aEmperorSkill.push(_loc_14);
            }
            _loc_10 = param1.BGM;
            for each (_loc_11 in _loc_10.children())
            {
                
                _loc_15 = new PlayerEmperorBgm();
                _loc_15.setParam(_loc_11);
                this._aCharacterBgm.push(_loc_15);
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        private function cbLoadGrowthParameterComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1.Data)
            {
                
                _loc_3 = new GrowthParameterData();
                _loc_3.setXml(_loc_2);
                this._aGrowthParameter.push(_loc_3);
            }
            this._loaderGrowth.release();
            this._loaderGrowth = null;
            this._bCreatedGrowth = true;
            return;
        }// end function

        private function cbLoadTagTextComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1.Data)
            {
                
                _loc_3 = new TagTextData();
                _loc_3.setXml(_loc_2);
                this._aTagText.push(_loc_3);
            }
            this._loaderTag.release();
            this._loaderTag = null;
            this._bCreatedTag = true;
            return;
        }// end function

        private function cbLoadCommanderSkillComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1.Data)
            {
                
                _loc_3 = new PlayerCommanderSkill();
                _loc_3.setXml(_loc_2);
                this._aCommanderSkill.push(_loc_3);
            }
            this._loaderCommanderSkill.release();
            this._loaderCommanderSkill = null;
            this._bCreatedCommanderSkill = true;
            return;
        }// end function

        public function getPlayerIdAllList() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aPlayerInfo)
            {
                
                _loc_1.push(_loc_2.id);
            }
            return _loc_1;
        }// end function

        public function getRarityText(param1:int) : String
        {
            var _loc_2:* = MessageId.UNIT_RARITY_NONE;
            switch(param1)
            {
                case CommonConstant.CHARACTER_RARITY_NORMAL:
                {
                    _loc_2 = MessageId.UNIT_RARITY_NORMAL;
                    break;
                }
                case CommonConstant.CHARACTER_RARITY_HIGHNORMAL:
                {
                    _loc_2 = MessageId.UNIT_RARITY_HIGHNORMAL;
                    break;
                }
                case CommonConstant.CHARACTER_RARITY_RARE:
                {
                    _loc_2 = MessageId.UNIT_RARITY_RARE;
                    break;
                }
                case CommonConstant.CHARACTER_RARITY_SUPERRARE:
                {
                    _loc_2 = MessageId.UNIT_RARITY_SUPER_RARE;
                    break;
                }
                case CommonConstant.CHARACTER_RARITY_ULTLARARE:
                {
                    _loc_2 = MessageId.UNIT_RARITY_ULTRA_RARE;
                    break;
                }
                case CommonConstant.CHARACTER_RARITY_SECRET:
                {
                    _loc_2 = MessageId.UNIT_RARITY_SECRET;
                    break;
                }
                case CommonConstant.CHARACTER_RARITY_LEGEND:
                {
                    _loc_2 = MessageId.UNIT_RARITY_LEGEND;
                    break;
                }
                case CommonConstant.CHARACTER_RARITY_PR:
                {
                    _loc_2 = MessageId.UNIT_RARITY_PROMOTION;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return MessageManager.getInstance().getMessage(_loc_2);
        }// end function

        public function getRarityValue(param1:int) : int
        {
            switch(param1)
            {
                case CommonConstant.CHARACTER_RARITY_NORMAL:
                {
                    return CommonConstant.CHARACTER_RARITY_SORT_NORMAL;
                }
                case CommonConstant.CHARACTER_RARITY_HIGHNORMAL:
                {
                    return CommonConstant.CHARACTER_RARITY_SORT_HIGHNORMAL;
                }
                case CommonConstant.CHARACTER_RARITY_RARE:
                {
                    return CommonConstant.CHARACTER_RARITY_SORT_RARE;
                }
                case CommonConstant.CHARACTER_RARITY_SUPERRARE:
                {
                    return CommonConstant.CHARACTER_RARITY_SORT_SUPERRARE;
                }
                case CommonConstant.CHARACTER_RARITY_ULTLARARE:
                {
                    return CommonConstant.CHARACTER_RARITY_SORT_ULTLARARE;
                }
                case CommonConstant.CHARACTER_RARITY_SECRET:
                {
                    return CommonConstant.CHARACTER_RARITY_SORT_SECRET;
                }
                case CommonConstant.CHARACTER_RARITY_LEGEND:
                {
                    return CommonConstant.CHARACTER_RARITY_SORT_LEGEND;
                }
                case CommonConstant.CHARACTER_RARITY_PR:
                {
                    return CommonConstant.CHARACTER_RARITY_SORT_PR;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public function cmpRarityValue(param1:int, param2:int) : int
        {
            return this.getRarityValue(param1) - this.getRarityValue(param2);
        }// end function

        public function cmpRarityRare(param1:int) : int
        {
            return this.getRarityValue(param1) - CommonConstant.CHARACTER_RARITY_SORT_RARE;
        }// end function

        public function cmpRaritySuperRare(param1:int) : int
        {
            return this.getRarityValue(param1) - CommonConstant.CHARACTER_RARITY_SORT_SUPERRARE;
        }// end function

        public function getRarityIconLabel(param1:int) : String
        {
            switch(param1)
            {
                case CommonConstant.CHARACTER_RARITY_NORMAL:
                {
                    return "rank_N";
                }
                case CommonConstant.CHARACTER_RARITY_HIGHNORMAL:
                {
                    return "rank_HN";
                }
                case CommonConstant.CHARACTER_RARITY_RARE:
                {
                    return "rank_R";
                }
                case CommonConstant.CHARACTER_RARITY_SUPERRARE:
                {
                    return "rank_SR";
                }
                case CommonConstant.CHARACTER_RARITY_ULTLARARE:
                {
                    return "rank_UR";
                }
                case CommonConstant.CHARACTER_RARITY_SECRET:
                {
                    return "rank_N";
                }
                case CommonConstant.CHARACTER_RARITY_LEGEND:
                {
                    return "rank_LR";
                }
                case CommonConstant.CHARACTER_RARITY_PR:
                {
                    return "rank_PR";
                }
                default:
                {
                    break;
                }
            }
            return "rank_N";
        }// end function

        public function getRarityWarriorCardFileName(param1:int) : String
        {
            switch(param1)
            {
                case CommonConstant.CHARACTER_RARITY_NORMAL:
                {
                    return "item_char_card_NN.png";
                }
                case CommonConstant.CHARACTER_RARITY_HIGHNORMAL:
                {
                    return "item_char_card_HN.png";
                }
                case CommonConstant.CHARACTER_RARITY_RARE:
                {
                    return "item_char_card_RR.png";
                }
                case CommonConstant.CHARACTER_RARITY_SUPERRARE:
                {
                    return "item_char_card_SR.png";
                }
                case CommonConstant.CHARACTER_RARITY_ULTLARARE:
                {
                    return "item_char_card_UR.png";
                }
                case CommonConstant.CHARACTER_RARITY_SECRET:
                {
                    break;
                }
                case CommonConstant.CHARACTER_RARITY_LEGEND:
                {
                    break;
                }
                case CommonConstant.CHARACTER_RARITY_PR:
                {
                    return "item_char_card_PR.png";
                }
                default:
                {
                    break;
                }
            }
            return "item_char_card.png";
        }// end function

        public function isEmperorRarity(param1:int) : Boolean
        {
            if (param1 == CommonConstant.CHARACTER_RARITY_RARE || param1 == CommonConstant.CHARACTER_RARITY_SUPERRARE || param1 == CommonConstant.CHARACTER_RARITY_ULTLARARE || param1 == CommonConstant.CHARACTER_RARITY_SECRET || param1 == CommonConstant.CHARACTER_RARITY_LEGEND || param1 == CommonConstant.CHARACTER_RARITY_PR)
            {
                return true;
            }
            return false;
        }// end function

        public function needDeleteCheckRarity(param1:int) : Boolean
        {
            return CommonConstant.CHARACTER_RARITY_SORT_RARE <= this.getRarityValue(param1);
        }// end function

        public function getArmyTypeText(param1:int) : String
        {
            var _loc_2:* = [MessageId.PLAYER_ARMY_TYPE_EMPIREHEAVYINFANTRY, MessageId.PLAYER_ARMY_TYPE_EMPIRELIGHTINFANTRY, MessageId.PLAYER_ARMY_TYPE_EMPIREJAGER, MessageId.PLAYER_ARMY_TYPE_MAGICIAN, MessageId.PLAYER_ARMY_TYPE_FREEFIGHTER, MessageId.PLAYER_ARMY_TYPE_FREEMAGE, MessageId.PLAYER_ARMY_TYPE_CITYTHIEF, MessageId.PLAYER_ARMY_TYPE_STRATEGIST, MessageId.PLAYER_ARMY_TYPE_IMPEROALGUARD, MessageId.PLAYER_ARMY_TYPE_FIGHTER, MessageId.PLAYER_ARMY_TYPE_ZYGOGROUP, MessageId.PLAYER_ARMY_TYPE_ARMEDMERCHANTFLEET, MessageId.PLAYER_ARMY_TYPE_HOLYORDER, MessageId.PLAYER_ARMY_TYPE_NOMAD, MessageId.PLAYER_ARMY_TYPE_DESSERTGUARD, MessageId.PLAYER_ARMY_TYPE_EASTGUARD, MessageId.PLAYER_ARMY_TYPE_AMAZONS, MessageId.PLAYER_ARMY_TYPE_HUNTER, MessageId.PLAYER_ARMY_TYPE_WOMANDIVER, MessageId.PLAYER_ARMY_TYPE_SALAMANDER, MessageId.PLAYER_ARMY_TYPE_MALL, MessageId.PLAYER_ARMY_TYPE_NEREID, MessageId.PLAYER_ARMY_TYPE_IRIS, MessageId.PLAYER_ARMY_TYPE_ONMYOJI, MessageId.PLAYER_ARMY_TYPE_LASTEMPEROR, MessageId.PLAYER_ARMY_TYPE_SEVENHEROES, MessageId.PLAYER_ARMY_TYPE_NON];
            return MessageManager.getInstance().getMessage(_loc_2[param1]);
        }// end function

        public function getSexText(param1:int) : String
        {
            switch(param1)
            {
                case CharacterConstant.SEX_NON:
                {
                    return MessageManager.getInstance().getMessage(MessageId.PLAYER_STATUS_SEX_UNKNOWN);
                }
                case CharacterConstant.SEX_MAN:
                {
                    return MessageManager.getInstance().getMessage(MessageId.PLAYER_STATUS_SEX_MALE);
                }
                case CharacterConstant.SEX_WOMAN:
                {
                    return MessageManager.getInstance().getMessage(MessageId.PLAYER_STATUS_SEX_FEMALE);
                }
                case CharacterConstant.SEX_MACHINE:
                {
                    return MessageManager.getInstance().getMessage(MessageId.PLAYER_STATUS_SEX_MACHINE);
                }
                default:
                {
                    break;
                }
            }
            return "";
        }// end function

        public function getWeaponName(param1:int) : String
        {
            var _loc_2:* = [MessageId.WEAPON_TYPE_SWORD, MessageId.WEAPON_TYPE_SPEAR, MessageId.WEAPON_TYPE_GRAPPLE, MessageId.WEAPON_TYPE_LARGE_SWORD, MessageId.WEAPON_TYPE_HALBERD, MessageId.WEAPON_TYPE_CRAW, MessageId.WEAPON_TYPE_AX, MessageId.WEAPON_TYPE_SMALL_SWORD, MessageId.WEAPON_TYPE_STICK, MessageId.WEAPON_TYPE_BOW];
            return MessageManager.getInstance().getMessage(_loc_2[(param1 - 1)]);
        }// end function

        public function getWeaponType(param1:int) : String
        {
            return this._aWeaponLabelTable[param1];
        }// end function

        public function getMagicTypeLabel(param1:uint) : Array
        {
            var _loc_2:* = [];
            if ((param1 & CharacterConstant.MAGIC_TYPE_FLAME) > 0)
            {
                _loc_2.push(SkillConstant.LABEL_MAGIC_TYPE_FIRE);
            }
            if ((param1 & CharacterConstant.MAGIC_TYPE_WATER) > 0)
            {
                _loc_2.push(SkillConstant.LABEL_MAGIC_TYPE_WATER);
            }
            if ((param1 & CharacterConstant.MAGIC_TYPE_EARTH) > 0)
            {
                _loc_2.push(SkillConstant.LABEL_MAGIC_TYPE_EARTH);
            }
            if ((param1 & CharacterConstant.MAGIC_TYPE_WIND) > 0)
            {
                _loc_2.push(SkillConstant.LABEL_MAGIC_TYPE_WIND);
            }
            if ((param1 & CharacterConstant.MAGIC_TYPE_LIGHT) > 0)
            {
                _loc_2.push(SkillConstant.LABEL_MAGIC_TYPE_HEAVEN);
            }
            if ((param1 & CharacterConstant.MAGIC_TYPE_HADES) > 0)
            {
                _loc_2.push(SkillConstant.LABEL_MAGIC_TYPE_HADES);
            }
            return _loc_2;
        }// end function

        public function getEmperorSkill(param1:int) : PlayerEmperorSkill
        {
            var _loc_3:* = null;
            var _loc_2:* = null;
            for each (_loc_3 in this._aEmperorSkill)
            {
                
                if (_loc_3.charId == param1)
                {
                    _loc_2 = _loc_3;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function isEmperorSkillTarget(param1:PlayerInformation, param2:PlayerInformation, param3:PlayerEmperorSkill = null) : Boolean
        {
            if (param3 == null)
            {
                param3 = this.getEmperorSkill(param2.characterId);
            }
            if (param3 == null)
            {
                return false;
            }
            switch(param3.range)
            {
                case PlayerConstant.EMPEROR_SKILL_RANGE_LESS:
                {
                    return false;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_SERIES:
                {
                    return param1.series == param2.series;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_WEAPON_TYPE:
                {
                    return param1.weaponType == param2.weaponType;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_ARMY_TYPE:
                {
                    return param1.armyType != CharacterConstant.ARMYTYPE_NON && param1.armyType == param2.armyType;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_MAN:
                {
                    return param1.sex == CharacterConstant.SEX_MAN;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_WOMAN:
                {
                    return param1.sex == CharacterConstant.SEX_WOMAN;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_SAME_SEX:
                {
                    return param2.sex != CharacterConstant.SEX_NON && param1.sex == param2.sex;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_ALL:
                {
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function getEmperorSkillEffectsBonus(param1:PlayerPersonal, param2:PlayerInformation, param3:PlayerEmperorSkill = null) : int
        {
            if (param3 == null)
            {
                param3 = this.getEmperorSkill(param2.characterId);
            }
            if (param3 == null)
            {
                return 0;
            }
            var _loc_4:* = 0;
            switch(param2.rarity)
            {
                case CommonConstant.CHARACTER_RARITY_RARE:
                {
                    _loc_4 = _loc_4 + 1;
                    break;
                }
                case CommonConstant.CHARACTER_RARITY_SUPERRARE:
                {
                    _loc_4 = _loc_4 + 2;
                    break;
                }
                case CommonConstant.CHARACTER_RARITY_ULTLARARE:
                {
                    _loc_4 = _loc_4 + 3;
                    break;
                }
                case CommonConstant.CHARACTER_RARITY_LEGEND:
                {
                    _loc_4 = _loc_4 + 5;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_5:* = param1 ? (param1.attack + param1.defense + param1.speed) : (param2.attack + param2.defense + param2.speed);
            if ((param1 ? (param1.attack + param1.defense + param1.speed) : (param2.attack + param2.defense + param2.speed)) >= 241)
            {
                _loc_4 = _loc_4 + 3;
            }
            else if (_loc_5 >= 166)
            {
                _loc_4 = _loc_4 + 2;
            }
            else if (_loc_5 >= 91)
            {
                _loc_4 = _loc_4 + 1;
            }
            _loc_4 = _loc_4 + param3.val;
            return _loc_4;
        }// end function

        public function getEmperorSkillEffectsText(param1:PlayerInformation, param2:int, param3:PlayerEmperorSkill = null) : String
        {
            if (param3 == null)
            {
                param3 = this.getEmperorSkill(param1.characterId);
            }
            if (param3 == null || param3.range == PlayerConstant.EMPEROR_SKILL_RANGE_LESS || this.isEmperorRarity(param1.rarity) == false)
            {
                return MessageManager.getInstance().getMessage(MessageId.COMMON_EMPTY);
            }
            var _loc_4:* = "";
            switch(param3.range)
            {
                case PlayerConstant.EMPEROR_SKILL_RANGE_SERIES:
                {
                    _loc_4 = _loc_4 + MessageManager.getInstance().getMessage(MessageId.EMPEROR_SKILL_RANGE_SERIES);
                    break;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_WEAPON_TYPE:
                {
                    _loc_4 = _loc_4 + (MessageManager.getInstance().getMessage(MessageId.COMMON_STATUS_WEAPON_TYPE) + this.getWeaponName(param1.weaponType));
                    break;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_ARMY_TYPE:
                {
                    _loc_4 = _loc_4 + this.getArmyTypeText(param1.armyType);
                    break;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_MAN:
                {
                    _loc_4 = _loc_4 + MessageManager.getInstance().getMessage(MessageId.PLAYER_STATUS_SEX_MALE);
                    break;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_WOMAN:
                {
                    _loc_4 = _loc_4 + MessageManager.getInstance().getMessage(MessageId.PLAYER_STATUS_SEX_FEMALE);
                    break;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_SAME_SEX:
                {
                    _loc_4 = _loc_4 + this.getSexText(param1.sex);
                    break;
                }
                case PlayerConstant.EMPEROR_SKILL_RANGE_ALL:
                {
                    _loc_4 = _loc_4 + MessageManager.getInstance().getMessage(MessageId.EMPEROR_SKILL_RANGE_ALL);
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_5:* = "";
            switch(param3.target)
            {
                case PlayerConstant.EMPEROR_SKILL_TARGET_ATTACK:
                {
                    _loc_5 = _loc_5 + MessageManager.getInstance().getMessage(MessageId.COMMON_STATUS_ATTACK);
                    break;
                }
                case PlayerConstant.EMPEROR_SKILL_TARGET_DEFENSE:
                {
                    _loc_5 = _loc_5 + MessageManager.getInstance().getMessage(MessageId.COMMON_STATUS_DEFENSE);
                    break;
                }
                case PlayerConstant.EMPEROR_SKILL_TARGET_SPEED:
                {
                    _loc_5 = _loc_5 + MessageManager.getInstance().getMessage(MessageId.COMMON_STATUS_SPEED);
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_6:* = "";
            if (param2 >= 16)
            {
                _loc_6 = _loc_6 + MessageManager.getInstance().getMessage(MessageId.EMPEROR_SKILL_EFFECTS_EXCELLENT);
            }
            else if (param2 >= 10)
            {
                _loc_6 = _loc_6 + MessageManager.getInstance().getMessage(MessageId.EMPEROR_SKILL_EFFECTS_GREAT);
            }
            else if (param2 >= 7)
            {
                _loc_6 = _loc_6 + MessageManager.getInstance().getMessage(MessageId.EMPEROR_SKILL_EFFECTS_VERY_GOOD);
            }
            else if (param2 >= 4)
            {
                _loc_6 = _loc_6 + MessageManager.getInstance().getMessage(MessageId.EMPEROR_SKILL_EFFECTS_GOOD);
            }
            else if (param2 >= 1)
            {
                _loc_6 = _loc_6 + MessageManager.getInstance().getMessage(MessageId.EMPEROR_SKILL_EFFECTS_SMALL);
            }
            return TextControl.formatIdText(MessageId.EMPEROR_SKILL_EXPLANATION, _loc_4, _loc_5, _loc_6);
        }// end function

        public function isCommanderSkillTarget(param1:PlayerInformation, param2:PlayerCommanderSkill) : Boolean
        {
            if (param2.isCondFree())
            {
                return true;
            }
            if (param2.condSex != 0 && param2.condSex == param1.sex)
            {
                return true;
            }
            if (param2.condSeries != 0 && param2.condSeries == param1.series)
            {
                return true;
            }
            if (param2.condArmyType != 0 && param2.condArmyType == param1.armyType)
            {
                return true;
            }
            if (param2.condRarity != 0 && param2.condRarity == param1.rarity)
            {
                return true;
            }
            if (param2.condWeapon1 != 0 && param2.condWeapon1 == param1.weaponType)
            {
                return true;
            }
            if (param2.condWeapon2 != 0 && param2.condWeapon2 == param1.weaponType)
            {
                return true;
            }
            if (param2.condWeapon3 != 0 && param2.condWeapon3 == param1.weaponType)
            {
                return true;
            }
            if (param2.condTag != 0 && param2.condTag == param1.tag)
            {
                return true;
            }
            return false;
        }// end function

        public function getCommanderSkillEffectsText(param1:PlayerInformation) : String
        {
            var _loc_2:* = null;
            if (param1.hasCommanderSkill())
            {
                _loc_2 = this.getCommanderSkill(param1.commanderSkillId);
                if (_loc_2)
                {
                    return _loc_2.description;
                }
            }
            return "";
        }// end function

        public function getPlayerTagName(param1:PlayerInformation) : String
        {
            var _loc_2:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_7:* = 0;
            var _loc_3:* = [];
            _loc_4 = this._aTagText.length;
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = Constant.UNDECIDED;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_2 = this._aTagText[_loc_5];
                    if (this.tagCheck(param1, _loc_2))
                    {
                        _loc_7 = _loc_2.tagTextType;
                        _loc_3.push(_loc_2);
                        break;
                    }
                    _loc_5++;
                }
                _loc_5 = _loc_5 + 1;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_2 = this._aTagText[_loc_5];
                    if (_loc_2.tagTextType != _loc_7)
                    {
                        break;
                    }
                    _loc_5++;
                }
            }
            if (_loc_3.length == 0)
            {
                return MessageManager.getInstance().getMessage(MessageId.COMMON_TAGTEXT_NONE);
            }
            _loc_2 = _loc_3[0];
            if (_loc_2.tagTextType == TagTextData.TAG_TEXT_TYPE_SEX)
            {
                _loc_3.shift();
                _loc_3.push(_loc_2);
            }
            var _loc_6:* = "";
            _loc_5 = 0;
            while (_loc_5 < _loc_3.length)
            {
                
                _loc_2 = _loc_3[_loc_5];
                _loc_6 = _loc_6 + _loc_2.name;
                _loc_5++;
            }
            return _loc_6;
        }// end function

        private function tagCheck(param1:PlayerInformation, param2:TagTextData) : Boolean
        {
            if (param2.tagTextType == TagTextData.TAG_TEXT_TYPE_SEX && param1.sex == param2.subId)
            {
                return true;
            }
            if (param2.tagTextType == TagTextData.TAG_TEXT_TYPE_SERIES && param1.series == param2.subId)
            {
                return true;
            }
            if (param2.tagTextType == TagTextData.TAG_TEXT_TYPE_ARMY_TYPE && param1.armyType == param2.subId)
            {
                return true;
            }
            if (param2.tagTextType == TagTextData.TAG_TEXT_TYPE_TAG && param1.tag == param2.subId)
            {
                return true;
            }
            return false;
        }// end function

        public function characterBgm(param1:int) : PlayerEmperorBgm
        {
            var _loc_3:* = null;
            var _loc_2:* = null;
            for each (_loc_3 in this._aCharacterBgm)
            {
                
                if (_loc_3.charaId == param1)
                {
                    _loc_2 = _loc_3;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function getGrowthParameter(param1:PlayerInformation, param2:int) : GrowthParameterData
        {
            var _loc_4:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._aGrowthParameter.length)
            {
                
                _loc_4 = this._aGrowthParameter[_loc_3];
                if (_loc_4.rarity != param1.rarity)
                {
                }
                else if (param2 < _loc_4.life)
                {
                    return _loc_4;
                }
                _loc_3++;
            }
            return null;
        }// end function

        public function getLifeRunningLevel(param1:PlayerInformation, param2:int) : int
        {
            var _loc_3:* = this.getGrowthParameter(param1, param2);
            if (_loc_3)
            {
                return _loc_3.graphic;
            }
            return 5;
        }// end function

        public function getGrowthEndBattleCount(param1:PlayerInformation) : int
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aGrowthParameter.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aGrowthParameter[_loc_2];
                if (_loc_3.rarity == param1.rarity)
                {
                    return _loc_3.life;
                }
                _loc_2 = _loc_2 - 1;
            }
            return 0;
        }// end function

        public function getCommanderSkill(param1:int) : PlayerCommanderSkill
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aCommanderSkill)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function setSpStopPlayer(param1:Array) : void
        {
            this._aSpStopPlayerUniqueId = param1.concat();
            return;
        }// end function

        public function isSpStopPlayer(param1:int) : Boolean
        {
            return this._aSpStopPlayerUniqueId.indexOf(param1) >= 0;
        }// end function

        public static function getInstance() : PlayerManager
        {
            if (_instance == null)
            {
                _instance = new PlayerManager;
            }
            return _instance;
        }// end function

    }
}
