package formation
{
    import develop.*;
    import enemy.*;
    import flash.display.*;
    import flash.geom.*;
    import resource.*;

    public class FormationDataEnemy extends Object
    {
        private const LAYOUT_ENEMY:String = "EnemyLay";
        private const LAYOUT_SEVENHEROES:String = "SevenHeroesLay";
        private const LAYOUT_VAGADARA:String = "VagaDaraLay";
        private const LAYOUT_TINYFATHER:String = "TinyFatherLay";
        private const LAYOUT_BYUNEI:String = "ByuneiLay";
        private const LAYOUT_DANTAG:String = "DantagLay";
        private const LAYOUT_DES:String = "DesLay";
        private const LAYOUT_DESTRYER:String = "DestryerLay";
        private const LAYOUT_FLTYRANT:String = "FLTyrantLay";
        private const LAYOUT_FORNEUS:String = "ForneusLay";
        private const LAYOUT_REALQUEEN:String = "RealQueenLay";
        private const LAYOUT_ROCBOUQUET:String = "RocbouquetLay";
        private const LAYOUT_SARUIN:String = "SaruinLay";
        private const LAYOUT_WATERDRAGON:String = "WaterDragonLay";
        private const LAYOUT_KUJINSHI:String = "KujinshiLay";
        private const LAYOUT_NOEL:String = "NoelLay";
        private var _mcFormation:MovieClip;

        public function FormationDataEnemy(param1:DisplayObjectContainer, param2:Array)
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this._mcFormation = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleFormationEnemy.swf", "BattleFormationEnemy");
            param1.addChild(this._mcFormation);
            if (param2 != null)
            {
                _loc_3 = 0;
                _loc_4 = Constant.EMPTY_ID;
                for each (_loc_5 in param2)
                {
                    
                    if (_loc_5 != null)
                    {
                        _loc_4 = _loc_5.infoId;
                        _loc_3++;
                    }
                }
                if (_loc_3 == 1)
                {
                    DebugLog.print("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\Odin voin");
                    _loc_6 = this.LAYOUT_ENEMY;
                    switch(_loc_4)
                    {
                        case EnemyId.id_mons_FLTyrant_RS1:
                        {
                            _loc_6 = this.LAYOUT_FLTYRANT;
                            break;
                        }
                        case EnemyId.id_mons_Kujinshi_RS2:
                        {
                            _loc_6 = this.LAYOUT_KUJINSHI;
                            break;
                        }
                        case EnemyId.id_mons_TinyFather_RS1:
                        {
                            _loc_6 = this.LAYOUT_TINYFATHER;
                            break;
                        }
                        case EnemyId.id_mons_Saruin_RS1:
                        {
                            _loc_6 = this.LAYOUT_SARUIN;
                            break;
                        }
                        case EnemyId.id_mons_WaterDragon_RS1:
                        {
                            _loc_6 = this.LAYOUT_WATERDRAGON;
                            break;
                        }
                        case EnemyId.id_mons_RockBouket_RS2:
                        {
                            _loc_6 = this.LAYOUT_ROCBOUQUET;
                            break;
                        }
                        case EnemyId.id_mons_Dantag_RS2:
                        {
                            _loc_6 = this.LAYOUT_DANTAG;
                            break;
                        }
                        case EnemyId.id_mons_RealQueen_RS2:
                        {
                            _loc_6 = this.LAYOUT_REALQUEEN;
                            break;
                        }
                        case EnemyId.id_mons_Byunei_RS3:
                        {
                            _loc_6 = this.LAYOUT_BYUNEI;
                            break;
                        }
                        case EnemyId.id_mons_Death_RS1:
                        case EnemyId.id_mons_Death_Vision_RS1:
                        {
                            _loc_6 = this.LAYOUT_DES;
                            break;
                        }
                        case EnemyId.id_mons_Forneus_RS3:
                        {
                            _loc_6 = this.LAYOUT_FORNEUS;
                            break;
                        }
                        case EnemyId.id_mons_Noel_RS2:
                        {
                            _loc_6 = this.LAYOUT_NOEL;
                            break;
                        }
                        case EnemyId.id_mons_Destryer_1st_RS3:
                        case EnemyId.id_mons_Destryer_4th_RS3:
                        case EnemyId.id_mons_Destryer_5th_RS3:
                        case EnemyId.id_mons_Destryer_6th_RS3:
                        case EnemyId.id_mons_Destryer_7th_RS3:
                        case EnemyId.id_mons_Destryer_8th_RS3:
                        {
                            _loc_6 = this.LAYOUT_DESTRYER;
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
                            _loc_6 = this.LAYOUT_SEVENHEROES;
                            break;
                        }
                        case EnemyId.id_mons_VagaDara_Sword_IS:
                        case EnemyId.id_mons_VagaDara_Harp_IS:
                        case EnemyId.id_mons_VagaDara_Spear_IS:
                        {
                            _loc_6 = this.LAYOUT_VAGADARA;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    this._mcFormation.gotoAndStop(_loc_6);
                }
            }
            return;
        }// end function

        public function release() : void
        {
            if (this._mcFormation)
            {
                if (this._mcFormation.parent)
                {
                    this._mcFormation.parent.removeChild(this._mcFormation);
                }
            }
            this._mcFormation = null;
            return;
        }// end function

        public function getPosition(param1:int) : Point
        {
            var _loc_2:* = [this._mcFormation.enemyLay1Mc, this._mcFormation.enemyLay2Mc, this._mcFormation.enemyLay3Mc, this._mcFormation.enemyLay4Mc, this._mcFormation.enemyLay5Mc, this._mcFormation.enemyLay6Mc, this._mcFormation.enemyLay7Mc, this._mcFormation.enemyLay8Mc, this._mcFormation.enemyLay9Mc];
            var _loc_3:* = new Point();
            var _loc_4:* = _loc_2[param1];
            if (_loc_2[param1] != null)
            {
                _loc_3 = _loc_4.localToGlobal(new Point());
            }
            return _loc_3;
        }// end function

    }
}
