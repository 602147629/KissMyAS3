package enemy
{
    import battle.*;
    import flash.display.*;
    import resource.*;

    public class EnemyManager extends Object
    {
        private var _bCreated:Boolean;
        private var _loader:XmlLoader;
        private var _aEnemyInfo:Array;
        private static var _instance:EnemyManager = null;

        public function EnemyManager()
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

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "EnemyParameter.xml", this.cbLoadComplete, false);
            return;
        }// end function

        public function getEnemyInformation(param1:int) : EnemyInformation
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aEnemyInfo)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function cbLoadComplete(param1:XML) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = uint(param1.Ver);
            var _loc_3:* = new VersionInfo();
            _loc_3.setVertion(CommonConstant.PARAMETER_VERSION_ENEMY, _loc_2);
            Main.GetApplicationData().addVersion(_loc_3);
            this._aEnemyInfo = [];
            for each (_loc_4 in param1.Data)
            {
                
                _loc_5 = new EnemyInformation();
                _loc_5.setXml(_loc_4);
                this._aEnemyInfo.push(_loc_5);
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        public function getResourcePath(param1:int) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = this.getEnemyInformation(param1);
            if (_loc_3.bossFlag)
            {
            }
            switch(param1)
            {
                case EnemyId.id_mons_Death_RS1:
                case EnemyId.id_mons_Death_Vision_RS1:
                {
                    break;
                }
                case EnemyId.id_mons_FLTyrant_RS1:
                case EnemyId.id_mons_FLTyrant_RS1_E02:
                case EnemyId.id_mons_FLTyrant_RS1_E04:
                case EnemyId.id_mons_FLTyrant_RS1_E06:
                case EnemyId.id_mons_FLTyrant_RS1_E09:
                {
                    break;
                }
                case EnemyId.id_mons_Kujinshi_RS2:
                case EnemyId.id_mons_Kujinshi_RS2_E02:
                case EnemyId.id_mons_Kujinshi_RS2_E04:
                case EnemyId.id_mons_Kujinshi_RS2_E06:
                case EnemyId.id_mons_Kujinshi_RS2_E09:
                {
                    break;
                }
                case EnemyId.id_mons_TinyFather_RS1:
                case EnemyId.id_mons_TinyFather_RS1_E02:
                case EnemyId.id_mons_TinyFather_RS1_E04:
                case EnemyId.id_mons_TinyFather_RS1_E06:
                case EnemyId.id_mons_TinyFather_RS1_E09:
                {
                    break;
                }
                case EnemyId.id_mons_Saruin_RS1:
                {
                    break;
                }
                case EnemyId.id_mons_WaterDragon_RS1:
                {
                    break;
                }
                case EnemyId.id_mons_Wagnus_RS2:
                case EnemyId.id_mons_Wagnus_RS2_E03:
                case EnemyId.id_mons_Wagnus_RS2_E05:
                case EnemyId.id_mons_Wagnus_RS2_E07:
                case EnemyId.id_mons_Wagnus_RS2_E10:
                {
                    break;
                }
                case EnemyId.id_mons_RockBouket_RS2:
                case EnemyId.id_mons_RockBouket_RS2_E02:
                case EnemyId.id_mons_RockBouket_RS2_E04:
                case EnemyId.id_mons_RockBouket_RS2_E06:
                case EnemyId.id_mons_RockBouket_RS2_E09:
                {
                    break;
                }
                case EnemyId.id_mons_Subie_RS2:
                case EnemyId.id_mons_Subie_RS2_E02:
                case EnemyId.id_mons_Subie_RS2_E04:
                case EnemyId.id_mons_Subie_RS2_E06:
                case EnemyId.id_mons_Subie_RS2_E09:
                {
                    break;
                }
                case EnemyId.id_mons_Dantag_RS2:
                case EnemyId.id_mons_Dantag_RS2_E02:
                case EnemyId.id_mons_Dantag_RS2_E04:
                case EnemyId.id_mons_Dantag_RS2_E06:
                case EnemyId.id_mons_Dantag_RS2_E09:
                {
                    break;
                }
                case EnemyId.id_mons_RealQueen_RS2:
                {
                    break;
                }
                case EnemyId.id_mons_Noel_RS2:
                case EnemyId.id_mons_Noel_RS2_E02:
                case EnemyId.id_mons_Noel_RS2_E04:
                case EnemyId.id_mons_Noel_RS2_E06:
                case EnemyId.id_mons_Noel_RS2_E09:
                {
                    break;
                }
                case EnemyId.id_mons_Byunei_RS3:
                {
                    break;
                }
                case EnemyId.id_mons_Forneus_RS3:
                {
                    break;
                }
                case EnemyId.id_mons_Destryer_1st_RS3:
                case EnemyId.id_mons_Destryer_4th_RS3:
                case EnemyId.id_mons_Destryer_5th_RS3:
                case EnemyId.id_mons_Destryer_6th_RS3:
                case EnemyId.id_mons_Destryer_7th_RS3:
                case EnemyId.id_mons_Destryer_8th_RS3:
                {
                    break;
                }
                case EnemyId.id_mons_SevenHeroes_First_RS2:
                case EnemyId.id_mons_SevenHeroes_Second_RS2:
                case EnemyId.id_mons_SevenHeroes_Thrid_RS2:
                case EnemyId.id_mons_SevenHeroes_Forth_RS2:
                case EnemyId.id_mons_SevenHeroes_Fifth_RS2:
                case EnemyId.id_mons_SevenHeroes_Sixth_RS2:
                case EnemyId.id_mons_SevenHeroes_Final_RS2:
                {
                    break;
                }
                case EnemyId.id_mons_VagaDara_Sword_IS:
                case EnemyId.id_mons_VagaDara_Harp_IS:
                case EnemyId.id_mons_VagaDara_Spear_IS:
                {
                    break;
                }
                case EnemyId.id_mons_Adiris_RS1:
                case EnemyId.id_mons_Adiris_RS1_E02:
                case EnemyId.id_mons_Adiris_RS1_E04:
                case EnemyId.id_mons_Adiris_RS1_E06:
                case EnemyId.id_mons_Adiris_RS1_E09:
                {
                    break;
                }
                case EnemyId.id_mons_Milza_First_RS1:
                case EnemyId.id_mons_Milza_Second_RS1:
                {
                    break;
                }
                case EnemyId.id_mons_Nemea_First_IS:
                case EnemyId.id_mons_Nemea_Second_IS:
                {
                    break;
                }
                case EnemyId.id_mons_Giant_ARM_CL02:
                {
                    break;
                }
                case EnemyId.id_mons_Giant_XL_CL02_E02:
                case EnemyId.id_mons_Giant_XL_CL02_E04:
                case EnemyId.id_mons_Giant_XL_CL02_E06:
                case EnemyId.id_mons_Giant_XL_CL02_E09:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function getResourceBustupPath(param1:int) : Array
        {
            var _loc_2:* = [];
            _loc_2 = _loc_2.concat(this.getResourcePath(param1));
            var _loc_3:* = this.getEnemyInformation(param1);
            if (_loc_3 != null && _loc_3.bossFlag)
            {
                _loc_2.push(ResourcePath.ENEMY_BUSTUP_PATH + _loc_3.bustUpFileName);
            }
            return _loc_2;
        }// end function

        public function getSeId(param1:int) : Array
        {
            var _loc_2:* = [];
            _loc_2 = _loc_2.concat(BattleActionEnemy.getSoundResource());
            switch(param1)
            {
                case EnemyId.id_mons_FLTyrant_RS1:
                case EnemyId.id_mons_FLTyrant_RS1_E02:
                case EnemyId.id_mons_FLTyrant_RS1_E04:
                case EnemyId.id_mons_FLTyrant_RS1_E06:
                case EnemyId.id_mons_FLTyrant_RS1_E09:
                {
                    _loc_2 = _loc_2.concat(EnemyBossFlameTyrant.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Kujinshi_RS2:
                case EnemyId.id_mons_Kujinshi_RS2_E02:
                case EnemyId.id_mons_Kujinshi_RS2_E04:
                case EnemyId.id_mons_Kujinshi_RS2_E06:
                case EnemyId.id_mons_Kujinshi_RS2_E09:
                {
                    _loc_2 = _loc_2.concat(EnemyBossKujinshi.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_WaterDragon_RS1:
                case EnemyId.id_mons_WaterDragon_RS1_E02:
                case EnemyId.id_mons_WaterDragon_RS1_E04:
                case EnemyId.id_mons_WaterDragon_RS1_E06:
                case EnemyId.id_mons_WaterDragon_RS1_E09:
                {
                    _loc_2 = _loc_2.concat(EnemyBossWaterDragon.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_TinyFather_RS1:
                case EnemyId.id_mons_TinyFather_RS1_E02:
                case EnemyId.id_mons_TinyFather_RS1_E04:
                case EnemyId.id_mons_TinyFather_RS1_E06:
                case EnemyId.id_mons_TinyFather_RS1_E09:
                {
                    _loc_2 = _loc_2.concat(EnemyBossTinyFather.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Dantag_RS2:
                case EnemyId.id_mons_Dantag_RS2_E02:
                case EnemyId.id_mons_Dantag_RS2_E04:
                case EnemyId.id_mons_Dantag_RS2_E06:
                case EnemyId.id_mons_Dantag_RS2_E09:
                {
                    _loc_2 = _loc_2.concat(EnemyBossDantag.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Bokuorn_RS2:
                case EnemyId.id_mons_Bokuorn_RS2_E02:
                case EnemyId.id_mons_Bokuorn_RS2_E04:
                case EnemyId.id_mons_Bokuorn_RS2_E06:
                case EnemyId.id_mons_Bokuorn_RS2_E09:
                {
                    _loc_2 = _loc_2.concat(EnemyBossBokuorn.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Wagnus_RS2:
                case EnemyId.id_mons_Wagnus_RS2_E03:
                case EnemyId.id_mons_Wagnus_RS2_E05:
                case EnemyId.id_mons_Wagnus_RS2_E07:
                case EnemyId.id_mons_Wagnus_RS2_E10:
                {
                    _loc_2 = _loc_2.concat(EnemyBossWagnus.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_RockBouket_RS2:
                case EnemyId.id_mons_RockBouket_RS2_E02:
                case EnemyId.id_mons_RockBouket_RS2_E04:
                case EnemyId.id_mons_RockBouket_RS2_E06:
                case EnemyId.id_mons_RockBouket_RS2_E09:
                {
                    _loc_2 = _loc_2.concat(EnemyBossRocbouquet.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Subie_RS2:
                case EnemyId.id_mons_Subie_RS2_E02:
                case EnemyId.id_mons_Subie_RS2_E04:
                case EnemyId.id_mons_Subie_RS2_E06:
                case EnemyId.id_mons_Subie_RS2_E09:
                {
                    _loc_2 = _loc_2.concat(EnemyBossSubie.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Byunei_RS3:
                {
                    _loc_2 = _loc_2.concat(EnemyBossByunei.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Death_RS1:
                case EnemyId.id_mons_Death_Vision_RS1:
                {
                    _loc_2 = _loc_2.concat(EnemyBossDeath.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Noel_RS2:
                case EnemyId.id_mons_Noel_RS2_E02:
                case EnemyId.id_mons_Noel_RS2_E04:
                case EnemyId.id_mons_Noel_RS2_E06:
                case EnemyId.id_mons_Noel_RS2_E09:
                {
                    _loc_2 = _loc_2.concat(EnemyBossNoel.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Saruin_RS1:
                {
                    _loc_2 = _loc_2.concat(EnemyBossSaruin.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_AntQueen_RS2:
                {
                    _loc_2 = _loc_2.concat(EnemyBossQueen.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_RealQueen_RS2:
                {
                    _loc_2 = _loc_2.concat(EnemyBossRealQueen.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Forneus_RS3:
                {
                    _loc_2 = _loc_2.concat(EnemyBossForneus.getSoundResource());
                }
                case EnemyId.id_mons_Destryer_1st_RS3:
                case EnemyId.id_mons_Destryer_4th_RS3:
                case EnemyId.id_mons_Destryer_5th_RS3:
                case EnemyId.id_mons_Destryer_6th_RS3:
                case EnemyId.id_mons_Destryer_7th_RS3:
                case EnemyId.id_mons_Destryer_8th_RS3:
                {
                    _loc_2 = _loc_2.concat(EnemyBossDestryer.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_SevenHeroes_First_RS2:
                case EnemyId.id_mons_SevenHeroes_Second_RS2:
                case EnemyId.id_mons_SevenHeroes_Thrid_RS2:
                case EnemyId.id_mons_SevenHeroes_Forth_RS2:
                case EnemyId.id_mons_SevenHeroes_Fifth_RS2:
                case EnemyId.id_mons_SevenHeroes_Sixth_RS2:
                case EnemyId.id_mons_SevenHeroes_Final_RS2:
                {
                    _loc_2 = _loc_2.concat(EnemyBossSevenHeroes.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_VagaDara_Sword_IS:
                case EnemyId.id_mons_VagaDara_Harp_IS:
                case EnemyId.id_mons_VagaDara_Spear_IS:
                {
                    _loc_2 = _loc_2.concat(EnemyBossVagaDara.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Adiris_RS1:
                case EnemyId.id_mons_Adiris_RS1_E02:
                case EnemyId.id_mons_Adiris_RS1_E04:
                case EnemyId.id_mons_Adiris_RS1_E06:
                case EnemyId.id_mons_Adiris_RS1_E09:
                {
                    _loc_2 = _loc_2.concat(EnemyBossAdiris.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Milza_First_RS1:
                case EnemyId.id_mons_Milza_Second_RS1:
                {
                    _loc_2 = _loc_2.concat(EnemyBossMilza.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Nemea_First_IS:
                case EnemyId.id_mons_Nemea_Second_IS:
                {
                    _loc_2 = _loc_2.concat(EnemyBossNemea.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Giant_ARM_CL02:
                {
                    _loc_2 = _loc_2.concat(EnemyBossGiantArmor.getSoundResource());
                    break;
                }
                case EnemyId.id_mons_Giant_XL_CL02_E02:
                case EnemyId.id_mons_Giant_XL_CL02_E04:
                case EnemyId.id_mons_Giant_XL_CL02_E06:
                case EnemyId.id_mons_Giant_XL_CL02_E09:
                {
                    _loc_2 = _loc_2.concat(EnemyBossGiantSuperLarge.getSoundResource());
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function createEnemyDisplay(param1:DisplayObjectContainer, param2:int, param3:int) : EnemyDisplay
        {
            var _loc_4:* = null;
            switch(param2)
            {
                case EnemyId.id_mons_FLTyrant_RS1:
                case EnemyId.id_mons_FLTyrant_RS1_E02:
                case EnemyId.id_mons_FLTyrant_RS1_E04:
                case EnemyId.id_mons_FLTyrant_RS1_E06:
                case EnemyId.id_mons_FLTyrant_RS1_E09:
                {
                    _loc_4 = new EnemyBossFlameTyrant(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Kujinshi_RS2:
                case EnemyId.id_mons_Kujinshi_RS2_E02:
                case EnemyId.id_mons_Kujinshi_RS2_E04:
                case EnemyId.id_mons_Kujinshi_RS2_E06:
                case EnemyId.id_mons_Kujinshi_RS2_E09:
                {
                    _loc_4 = new EnemyBossKujinshi(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_WaterDragon_RS1:
                case EnemyId.id_mons_WaterDragon_RS1_E02:
                case EnemyId.id_mons_WaterDragon_RS1_E04:
                case EnemyId.id_mons_WaterDragon_RS1_E06:
                case EnemyId.id_mons_WaterDragon_RS1_E09:
                {
                    _loc_4 = new EnemyBossWaterDragon(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_TinyFather_RS1:
                case EnemyId.id_mons_TinyFather_RS1_E02:
                case EnemyId.id_mons_TinyFather_RS1_E04:
                case EnemyId.id_mons_TinyFather_RS1_E06:
                case EnemyId.id_mons_TinyFather_RS1_E09:
                {
                    _loc_4 = new EnemyBossTinyFather(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Dantag_RS2:
                case EnemyId.id_mons_Dantag_RS2_E02:
                case EnemyId.id_mons_Dantag_RS2_E04:
                case EnemyId.id_mons_Dantag_RS2_E06:
                case EnemyId.id_mons_Dantag_RS2_E09:
                {
                    _loc_4 = new EnemyBossDantag(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Bokuorn_RS2:
                case EnemyId.id_mons_Bokuorn_RS2_E02:
                case EnemyId.id_mons_Bokuorn_RS2_E04:
                case EnemyId.id_mons_Bokuorn_RS2_E06:
                case EnemyId.id_mons_Bokuorn_RS2_E09:
                {
                    _loc_4 = new EnemyBossBokuorn(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Wagnus_RS2:
                case EnemyId.id_mons_Wagnus_RS2_E03:
                case EnemyId.id_mons_Wagnus_RS2_E05:
                case EnemyId.id_mons_Wagnus_RS2_E07:
                case EnemyId.id_mons_Wagnus_RS2_E10:
                {
                    _loc_4 = new EnemyBossWagnus(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_RockBouket_RS2:
                case EnemyId.id_mons_RockBouket_RS2_E02:
                case EnemyId.id_mons_RockBouket_RS2_E04:
                case EnemyId.id_mons_RockBouket_RS2_E06:
                case EnemyId.id_mons_RockBouket_RS2_E09:
                {
                    _loc_4 = new EnemyBossRocbouquet(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Subie_RS2:
                case EnemyId.id_mons_Subie_RS2_E02:
                case EnemyId.id_mons_Subie_RS2_E04:
                case EnemyId.id_mons_Subie_RS2_E06:
                case EnemyId.id_mons_Subie_RS2_E09:
                {
                    _loc_4 = new EnemyBossSubie(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Byunei_RS3:
                {
                    _loc_4 = new EnemyBossByunei(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Death_RS1:
                case EnemyId.id_mons_Death_Vision_RS1:
                {
                    _loc_4 = new EnemyBossDeath(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_MinionHate_RS1:
                case EnemyId.id_mons_MinionHateStory_RS1:
                case EnemyId.id_mons_MinionStrif_RS1:
                case EnemyId.id_mons_MinionWile_RS1:
                {
                    _loc_4 = new EnemyBossMinionHate(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Noel_RS2:
                case EnemyId.id_mons_Noel_RS2_E02:
                case EnemyId.id_mons_Noel_RS2_E04:
                case EnemyId.id_mons_Noel_RS2_E06:
                case EnemyId.id_mons_Noel_RS2_E09:
                {
                    _loc_4 = new EnemyBossNoel(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Saruin_RS1:
                {
                    _loc_4 = new EnemyBossSaruin(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_AntQueen_RS2:
                {
                    _loc_4 = new EnemyBossQueen(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_RealQueen_RS2:
                {
                    _loc_4 = new EnemyBossRealQueen(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Forneus_RS3:
                {
                    _loc_4 = new EnemyBossForneus(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_NachtSieger_RS3:
                {
                    _loc_4 = new EnemyBossNachtSieger(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Yummy_RS3:
                {
                    _loc_4 = new EnemyBossYummy(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Yama_RS3:
                {
                    _loc_4 = new EnemyBossYama(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Destryer_1st_RS3:
                case EnemyId.id_mons_Destryer_4th_RS3:
                case EnemyId.id_mons_Destryer_5th_RS3:
                case EnemyId.id_mons_Destryer_6th_RS3:
                case EnemyId.id_mons_Destryer_7th_RS3:
                case EnemyId.id_mons_Destryer_8th_RS3:
                {
                    _loc_4 = new EnemyBossDestryer(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_SevenHeroes_First_RS2:
                case EnemyId.id_mons_SevenHeroes_Second_RS2:
                case EnemyId.id_mons_SevenHeroes_Thrid_RS2:
                case EnemyId.id_mons_SevenHeroes_Forth_RS2:
                case EnemyId.id_mons_SevenHeroes_Fifth_RS2:
                case EnemyId.id_mons_SevenHeroes_Sixth_RS2:
                case EnemyId.id_mons_SevenHeroes_Final_RS2:
                {
                    _loc_4 = new EnemyBossSevenHeroes(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_VagaDara_Sword_IS:
                case EnemyId.id_mons_VagaDara_Harp_IS:
                case EnemyId.id_mons_VagaDara_Spear_IS:
                {
                    _loc_4 = new EnemyBossVagaDara(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Adiris_RS1:
                case EnemyId.id_mons_Adiris_RS1_E02:
                case EnemyId.id_mons_Adiris_RS1_E04:
                case EnemyId.id_mons_Adiris_RS1_E06:
                case EnemyId.id_mons_Adiris_RS1_E09:
                {
                    _loc_4 = new EnemyBossAdiris(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Milza_First_RS1:
                case EnemyId.id_mons_Milza_Second_RS1:
                {
                    _loc_4 = new EnemyBossMilza(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Nemea_First_IS:
                case EnemyId.id_mons_Nemea_Second_IS:
                {
                    _loc_4 = new EnemyBossNemea(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Giant_ARM_CL02:
                {
                    _loc_4 = new EnemyBossGiantArmor(param1, param2, param3);
                    break;
                }
                case EnemyId.id_mons_Giant_XL_CL02_E02:
                case EnemyId.id_mons_Giant_XL_CL02_E04:
                case EnemyId.id_mons_Giant_XL_CL02_E06:
                case EnemyId.id_mons_Giant_XL_CL02_E09:
                {
                    _loc_4 = new EnemyBossGiantSuperLarge(param1, param2, param3);
                    break;
                }
                default:
                {
                    _loc_4 = new EnemyDisplay(param1, param2, param3);
                    break;
                    break;
                }
            }
            return _loc_4;
        }// end function

        public function getUseSkill(param1:int) : Array
        {
            var _loc_2:* = this.getEnemyInformation(param1);
            return _loc_2.aSetEasySkill.concat();
        }// end function

        public static function getInstance() : EnemyManager
        {
            if (_instance == null)
            {
                _instance = new EnemyManager;
            }
            return _instance;
        }// end function

        public static function getBossMagicEffectResource() : String
        {
            return ResourcePath.SKILL_PATH + "Magic_Boss_Magic.swf";
        }// end function

    }
}
