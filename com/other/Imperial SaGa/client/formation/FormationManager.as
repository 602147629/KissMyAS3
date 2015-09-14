package formation
{
    import battle.*;
    import effect.*;
    import formationSkill.*;
    import layer.*;
    import resource.*;

    public class FormationManager extends Object
    {
        private var _aFormation:Array;
        private var _aFormationSkill:Array;
        private var _loader:XmlLoader;
        private var _skillLoader:XmlLoader;
        private static var _instance:FormationManager = null;

        public function FormationManager()
        {
            this._aFormation = [];
            this._aFormationSkill = [];
            return;
        }// end function

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "FormationParameter.xml", this.cbLoadComplete, false);
            this._skillLoader = new XmlLoader();
            this._skillLoader.load(ResourcePath.PARAMETER_PATH + "FormationSkillParameter.xml", this.cbSkillLoadComplete, false);
            return;
        }// end function

        public function isLoaded() : Boolean
        {
            return this._loader.xml != null && this._skillLoader.xml != null;
        }// end function

        public function getFormationInformation(param1:int) : FormationInformation
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aFormation)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getFormationSkillInformation(param1:int) : FormationSkillInformation
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aFormationSkill)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getFormationSkillInformationByFormationId(param1:int) : FormationSkillInformation
        {
            var _loc_2:* = null;
            var _loc_3:* = this.getFormationInformation(param1);
            if (_loc_3 != null)
            {
                _loc_2 = this.getFormationSkillInformation(_loc_3.formationSkillId);
            }
            return _loc_2;
        }// end function

        private function cbLoadComplete(param1:XML) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = uint(param1.Ver);
            var _loc_3:* = new VersionInfo();
            _loc_3.setVertion(CommonConstant.PARAMETER_VERSION_FORMATION, _loc_2);
            Main.GetApplicationData().addVersion(_loc_3);
            for each (_loc_4 in param1.Data)
            {
                
                _loc_5 = new FormationInformation();
                _loc_5.setXml(_loc_4);
                this._aFormation.push(_loc_5);
            }
            return;
        }// end function

        private function cbSkillLoadComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1.Data)
            {
                
                _loc_3 = new FormationSkillInformation();
                _loc_3.setXml(_loc_2);
                this._aFormationSkill.push(_loc_3);
            }
            return;
        }// end function

        public function getFormationSkillPath(param1:int) : Array
        {
            var _loc_2:* = [];
            switch(param1)
            {
                case FormationSkillId.ID_TIME_LAG:
                {
                    _loc_2.push(FormationSkillTimingAttack.getResource());
                    break;
                }
                case FormationSkillId.ID_HIGHSPEED_NABRA:
                {
                    _loc_2.push(FormationSkillHighspeedNabra.getResource());
                    break;
                }
                case FormationSkillId.ID_EXCEL_DRIVER:
                {
                    _loc_2.push(FormationSkillExcelDriver.getResource());
                    break;
                }
                case FormationSkillId.ID_JACK_KNIFE:
                {
                    _loc_2.push(FormationSkillPJackknife.getResource());
                    break;
                }
                case FormationSkillId.ID_DOBULE_X:
                {
                    _loc_2.push(FormationSkillDoubleX.getResource());
                    break;
                }
                case FormationSkillId.ID_THOUSAND_HAND:
                {
                    _loc_2.push(FormationSkillP1000HandBuddha.getResource());
                    break;
                }
                case FormationSkillId.ID_CARL_GUSTAF:
                {
                    _loc_2.push(FormationSkillCarlGustav.getResource());
                    break;
                }
                case FormationSkillId.ID_FUGETU:
                {
                    _loc_2.push(FormationSkillNaturesChaos.getResource());
                    break;
                }
                case FormationSkillId.ID_DRAGON_TUSK:
                {
                    _loc_2.push(FormationSkillPDragonTusk.getResource());
                    break;
                }
                case FormationSkillId.ID_ARROW_STORM:
                {
                    _loc_2.push(FormationSkillPArrowStorm.getResource());
                    break;
                }
                case FormationSkillId.ID_METEOR_STORM:
                {
                    _loc_2.push(FormationSkillPMeteorStorm.getResource());
                    break;
                }
                case FormationSkillId.ID_STRONGER_TACKLE:
                {
                    _loc_2.push(FormationSkillStrongerTackle.getResource());
                    break;
                }
                default:
                {
                    _loc_2.push(FormationSkillTest.getResource());
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function getFormationSkillSeId(param1:int) : Array
        {
            var _loc_2:* = [];
            switch(param1)
            {
                case FormationSkillId.ID_TIME_LAG:
                {
                    _loc_2 = _loc_2.concat(FormationSkillTimingAttack.getSeIdList());
                    break;
                }
                case FormationSkillId.ID_HIGHSPEED_NABRA:
                {
                    _loc_2 = _loc_2.concat(FormationSkillHighspeedNabra.getSeIdList());
                    break;
                }
                case FormationSkillId.ID_EXCEL_DRIVER:
                {
                    _loc_2 = _loc_2.concat(FormationSkillExcelDriver.getSeIdList());
                    break;
                }
                case FormationSkillId.ID_JACK_KNIFE:
                {
                    _loc_2 = _loc_2.concat(FormationSkillPJackknife.getSeIdList());
                    break;
                }
                case FormationSkillId.ID_DOBULE_X:
                {
                    _loc_2 = _loc_2.concat(FormationSkillDoubleX.getSeIdList());
                    break;
                }
                case FormationSkillId.ID_THOUSAND_HAND:
                {
                    _loc_2 = _loc_2.concat(FormationSkillP1000HandBuddha.getSeIdList());
                    break;
                }
                case FormationSkillId.ID_CARL_GUSTAF:
                {
                    _loc_2 = _loc_2.concat(FormationSkillCarlGustav.getSeIdList());
                    break;
                }
                case FormationSkillId.ID_FUGETU:
                {
                    _loc_2 = _loc_2.concat(FormationSkillNaturesChaos.getSeIdList());
                    break;
                }
                case FormationSkillId.ID_DRAGON_TUSK:
                {
                    _loc_2 = _loc_2.concat(FormationSkillPDragonTusk.getSeIdList());
                    break;
                }
                case FormationSkillId.ID_ARROW_STORM:
                {
                    _loc_2 = _loc_2.concat(FormationSkillPArrowStorm.getSeIdList());
                    break;
                }
                case FormationSkillId.ID_METEOR_STORM:
                {
                    _loc_2 = _loc_2.concat(FormationSkillPMeteorStorm.getSeIdList());
                    break;
                }
                case FormationSkillId.ID_STRONGER_TACKLE:
                {
                    _loc_2 = _loc_2.concat(FormationSkillStrongerTackle.getSeIdList());
                    break;
                }
                default:
                {
                    _loc_2 = _loc_2.concat(FormationSkillTest.getSeIdList());
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function createFormationSkill(param1:int, param2:LayerBattle, param3:Array, param4:Array, param5:EffectManager, param6:BattleManager) : FormationSkillBase
        {
            var _loc_7:* = null;
            switch(param1)
            {
                case FormationSkillId.ID_TIME_LAG:
                {
                    _loc_7 = new FormationSkillTimingAttack(param2, param3, param4, param5);
                    break;
                }
                case FormationSkillId.ID_HIGHSPEED_NABRA:
                {
                    _loc_7 = new FormationSkillHighspeedNabra(param2, param3, param4, param5);
                    break;
                }
                case FormationSkillId.ID_EXCEL_DRIVER:
                {
                    _loc_7 = new FormationSkillExcelDriver(param2, param3, param4, param5);
                    break;
                }
                case FormationSkillId.ID_JACK_KNIFE:
                {
                    _loc_7 = new FormationSkillPJackknife(param2, param3, param4, param5);
                    break;
                }
                case FormationSkillId.ID_DOBULE_X:
                {
                    _loc_7 = new FormationSkillDoubleX(param2, param3, param4, param5);
                    break;
                }
                case FormationSkillId.ID_THOUSAND_HAND:
                {
                    _loc_7 = new FormationSkillP1000HandBuddha(param2, param3, param4, param5);
                    break;
                }
                case FormationSkillId.ID_CARL_GUSTAF:
                {
                    _loc_7 = new FormationSkillCarlGustav(param2, param3, param4, param5);
                    break;
                }
                case FormationSkillId.ID_FUGETU:
                {
                    _loc_7 = new FormationSkillNaturesChaos(param2, param3, param4, param5);
                    break;
                }
                case FormationSkillId.ID_DRAGON_TUSK:
                {
                    _loc_7 = new FormationSkillPDragonTusk(param2, param3, param4, param5);
                    break;
                }
                case FormationSkillId.ID_ARROW_STORM:
                {
                    _loc_7 = new FormationSkillPArrowStorm(param2, param3, param4, param5);
                    break;
                }
                case FormationSkillId.ID_METEOR_STORM:
                {
                    _loc_7 = new FormationSkillPMeteorStorm(param2, param3, param4, param5);
                    break;
                }
                case FormationSkillId.ID_STRONGER_TACKLE:
                {
                    _loc_7 = new FormationSkillStrongerTackle(param2, param3, param4, param5);
                    break;
                }
                default:
                {
                    _loc_7 = new FormationSkillTest(param2, param3, param4, param5);
                    break;
                    break;
                }
            }
            if (_loc_7 != null)
            {
                _loc_7.setBattleManager(param6);
                _loc_7.setWeapon();
            }
            return _loc_7;
        }// end function

        public function getWeaponClassName(param1:int) : String
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case CommonConstant.CHARACTER_WEAPONTYPE_SWORD:
                {
                    _loc_2 = "weapon_Sword1";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD:
                {
                    _loc_2 = "weapon_Sword_Big";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SPEAR:
                {
                    _loc_2 = "weapon_Spear";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_AX:
                {
                    _loc_2 = "weapon_Axe";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD:
                {
                    _loc_2 = "weapon_Sword_Small";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS:
                {
                    _loc_2 = "";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_CLUB:
                {
                    _loc_2 = "weapon_Club";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_HALBERD:
                {
                    _loc_2 = "";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_BOW:
                {
                    _loc_2 = "";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_NAIL:
                {
                    _loc_2 = "";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function getBasicFormationId(param1:int) : int
        {
            param1 = Math.min(5, Math.max(1, param1));
            var _loc_2:* = [4, 3, 2, 1, 0];
            return _loc_2[(param1 - 1)];
        }// end function

        public static function getInstance() : FormationManager
        {
            if (_instance == null)
            {
                _instance = new FormationManager;
            }
            return _instance;
        }// end function

    }
}
