package skill
{
    import battle.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import utility.*;

    public class SkillManager extends Object
    {
        private var _bCreated:Boolean;
        private var _aSkillInfo:Array;
        private var _loader:XmlLoader;
        private static var _instance:SkillManager = null;

        public function SkillManager()
        {
            this._aSkillInfo = new Array();
            return;
        }// end function

        public function get bCreated() : Boolean
        {
            return this._bCreated;
        }// end function

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "SkillParameter.xml", this.cbLoadComplete, false);
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

        public function getSkillInformation(param1:int) : SkillInformation
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aSkillInfo)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getSkillInformationFromSkillEffectId(param1:int) : SkillInformation
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aSkillInfo)
            {
                
                if (_loc_2.effectId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getLearnableSkill(param1:int) : Array
        {
            var _loc_4:* = null;
            var _loc_2:* = this.getSkillTypeFromWeaponType(param1);
            var _loc_3:* = [];
            for each (_loc_4 in this._aSkillInfo)
            {
                
                if (_loc_4.skillType == _loc_2)
                {
                    _loc_3.push(_loc_4.id);
                }
            }
            return _loc_3;
        }// end function

        public function getSkillTypeFromWeaponType(param1:int) : int
        {
            var _loc_2:* = Constant.EMPTY_ID;
            switch(param1)
            {
                case CommonConstant.CHARACTER_WEAPONTYPE_SWORD:
                {
                    _loc_2 = CommonConstant.SKILL_TYPE_SWORD;
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SPEAR:
                {
                    _loc_2 = CommonConstant.SKILL_TYPE_SPEAR;
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS:
                {
                    _loc_2 = CommonConstant.SKILL_TYPE_MATERIALARTS;
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD:
                {
                    _loc_2 = CommonConstant.SKILL_TYPE_GREATSWORD;
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_HALBERD:
                {
                    _loc_2 = CommonConstant.SKILL_TYPE_HALBERD;
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_NAIL:
                {
                    _loc_2 = CommonConstant.SKILL_TYPE_NAIL;
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_AX:
                {
                    _loc_2 = CommonConstant.SKILL_TYPE_AX;
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD:
                {
                    _loc_2 = CommonConstant.SKILL_TYPE_SHORTSWORD;
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_CLUB:
                {
                    _loc_2 = CommonConstant.SKILL_TYPE_CLUB;
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_BOW:
                {
                    _loc_2 = CommonConstant.SKILL_TYPE_BOW;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function getWeaponTypeFromSkillType(param1:int) : int
        {
            var _loc_2:* = Constant.EMPTY_ID;
            switch(param1)
            {
                case CommonConstant.SKILL_TYPE_SWORD:
                {
                    _loc_2 = CommonConstant.CHARACTER_WEAPONTYPE_SWORD;
                    break;
                }
                case CommonConstant.SKILL_TYPE_SPEAR:
                {
                    _loc_2 = CommonConstant.CHARACTER_WEAPONTYPE_SPEAR;
                    break;
                }
                case CommonConstant.SKILL_TYPE_MATERIALARTS:
                {
                    _loc_2 = CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS;
                    break;
                }
                case CommonConstant.SKILL_TYPE_GREATSWORD:
                {
                    _loc_2 = CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD;
                    break;
                }
                case CommonConstant.SKILL_TYPE_HALBERD:
                {
                    _loc_2 = CommonConstant.CHARACTER_WEAPONTYPE_HALBERD;
                    break;
                }
                case CommonConstant.SKILL_TYPE_NAIL:
                {
                    _loc_2 = CommonConstant.CHARACTER_WEAPONTYPE_NAIL;
                    break;
                }
                case CommonConstant.SKILL_TYPE_AX:
                {
                    _loc_2 = CommonConstant.CHARACTER_WEAPONTYPE_AX;
                    break;
                }
                case CommonConstant.SKILL_TYPE_SHORTSWORD:
                {
                    _loc_2 = CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD;
                    break;
                }
                case CommonConstant.SKILL_TYPE_CLUB:
                {
                    _loc_2 = CommonConstant.CHARACTER_WEAPONTYPE_CLUB;
                    break;
                }
                case CommonConstant.SKILL_TYPE_BOW:
                {
                    _loc_2 = CommonConstant.CHARACTER_WEAPONTYPE_BOW;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function cbLoadComplete(param1:XML) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = uint(param1.Ver);
            var _loc_3:* = new VersionInfo();
            _loc_3.setVertion(CommonConstant.PARAMETER_VERSION_SKILL, _loc_2);
            Main.GetApplicationData().addVersion(_loc_3);
            for each (_loc_4 in param1.Data)
            {
                
                _loc_5 = new SkillInformation();
                _loc_5.setXml(_loc_4);
                this._aSkillInfo.push(_loc_5);
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        public function getSkillPath(param1:int) : Array
        {
            switch(this.convertNotSupportedSkillId(param1))
            {
                case SkillEffectId.ATTACK_SWORD:
                {
                    return [SkillPAttackSword.getResource()];
                }
                case SkillEffectId.ATTACK_LARGE_SWORD:
                {
                    return [SkillPAttackLargeSword.getResource()];
                }
                case SkillEffectId.ATTACK_AXE:
                {
                    return [SkillPAttackAxe.getResource()];
                }
                case SkillEffectId.ATTACK_CLUB:
                {
                    return [SkillPAttackClub.getResource()];
                }
                case SkillEffectId.ATTACK_SPEAR:
                {
                    return [SkillPAttackSpear.getResource()];
                }
                case SkillEffectId.ATTACK_SMALL_SWORD:
                {
                    return [SkillPAttackSmallSword.getResource()];
                }
                case SkillEffectId.ATTACK_BOW:
                {
                    return [SkillPAttackBow.getResource()];
                }
                case SkillEffectId.ATTACK_PUNCH_LEFT:
                {
                    return [SkillPAttackMartialArt1.getResource()];
                }
                case SkillEffectId.ATTACK_PUNCH_SCISSERS:
                {
                    return [SkillPAttackMartialArt1.getResource()];
                }
                case SkillEffectId.SKILL_SWORD_FALCONSLASH:
                {
                    return [SkillPSwordFalconSlash.getResource()];
                }
                case SkillEffectId.SKILL_ITIMONJI:
                {
                    return [SkillPSwordStraightSlash.getResource()];
                }
                case SkillEffectId.SKILL_CROSS_SLASH:
                {
                    return [SkillPSwordCrossSlash.getResource()];
                }
                case SkillEffectId.SKILL_TUMUJIWIND:
                {
                    return [SkillPSwordTsumujiWind.getResource()];
                }
                case SkillEffectId.SKILL_ONSOKU:
                {
                    return [SkillPSwordSonicSword.getResource()];
                }
                case SkillEffectId.SKILL_SWORD_DOUBLECUT:
                {
                    return [SkillPSwordDoubleCut.getResource()];
                }
                case SkillEffectId.SKILL_MIJIN:
                {
                    return [SkillPSwordTanzaku.getResource()];
                }
                case SkillEffectId.SKILL_NAGIHARAI:
                {
                    return [SkillPSwordSweepDown.getResource()];
                }
                case SkillEffectId.SKILL_SWORD_VACUUMCUT:
                {
                    return [SkillPSwordVacuumCut.getResource()];
                }
                case SkillEffectId.SKILL_SWORD_MIRAGEBLADE:
                {
                    return [SkillPSwordMirageBlade.getResource()];
                }
                case SkillEffectId.SKILL_SAMIDARE:
                {
                    return [SkillPSwordSamidare.getResource()];
                }
                case SkillEffectId.SKILL_CROSSBREAK:
                {
                    return [SkillPSwordCrossBreak.getResource()];
                }
                case SkillEffectId.SKILL_BIGSWORD_DOUBLESTROKE:
                {
                    return [SkillPBigSwordDoubleStroke.getResource()];
                }
                case SkillEffectId.SKILL_TRIPLECUT:
                {
                    return [SkillPBigSwordTripleCut.getResource()];
                }
                case SkillEffectId.SKILL_BIGSWORD_SWALLOWCUT:
                {
                    return [SkillPBigSwordSwallowCut.getResource()];
                }
                case SkillEffectId.SKILL_BIGSWORD_PUMMELSTRIKE:
                {
                    return [SkillPBigSwordPummelStrike.getResource()];
                }
                case SkillEffectId.SKILL_WINDUPSTRIKE:
                {
                    return [SkillPBigSwordWindUpStrike.getResource()];
                }
                case SkillEffectId.SKILL_POWERHIT:
                {
                    return [SkillPBigSwordPowerHit.getResource()];
                }
                case SkillEffectId.SKILL_BIGSWORD_DROPCUT:
                {
                    return [SkillPBigSwordDropCut.getResource()];
                }
                case SkillEffectId.SKILL_BIGSWORD_CRANEBLADE:
                {
                    return [SkillPBigSwordCraneBlade.getResource()];
                }
                case SkillEffectId.SKILL_SMASH:
                {
                    return [SkillPBigSwordSmash.getResource()];
                }
                case SkillEffectId.SKILL_SNOWPLOW_BLADE:
                {
                    return [SkillPBigSwordSnowPlowBlade.getResource()];
                }
                case SkillEffectId.SKILL_CHAOTIC_FLOWER_FALL:
                {
                    return [SkillPBigSwordChaoticFlowerfall.getResource()];
                }
                case SkillEffectId.SKILL_AXE_TOMAHAWK:
                {
                    return [SkillPAxeTomahawk.getResource()];
                }
                case SkillEffectId.SKILL_ONE_PERSON_TIMELAG:
                {
                    return [SkillPAxeOnePersonTimelag.getResource()];
                }
                case SkillEffectId.SKILL_AXE_YOYO:
                {
                    return [SkillPAxeYoyo.getResource()];
                }
                case SkillEffectId.SKILL_HEEL_CUT:
                {
                    return [SkillPAxeHeelCut.getResource()];
                }
                case SkillEffectId.SKILL_WOODCUTTER:
                {
                    return [SkillPAxeWoodCutter.getResource()];
                }
                case SkillEffectId.SKILL_BLADEROLL:
                {
                    return [SkillPAxeBladeRoll.getResource()];
                }
                case SkillEffectId.SKILL_FLYBY:
                {
                    return [SkillPAxeFlyby.getResource()];
                }
                case SkillEffectId.SKILL_AXE_SKYDIVE:
                {
                    return [SkillPAxeSkyDive.getResource()];
                }
                case SkillEffectId.SKILL_WOOD_SPLIT_DYNAMIC:
                {
                    return [SkillPAxeWoodSplitDynamic.getResource()];
                }
                case SkillEffectId.SKILL_HIGH_SPEED_NABLA:
                {
                    return [SkillPAxeHighSpeedNabla.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_BARB_THRUST:
                {
                    return [SkillPClubBarbThrust.getResource()];
                }
                case SkillEffectId.SKILL_CLUB_CROWN_SPLITTER:
                {
                    return [SkillPClubCrownSplitter.getResource()];
                }
                case SkillEffectId.SKILL_CLUB_GONG_BEAT:
                {
                    return [SkillPClubGongBeat.getResource()];
                }
                case SkillEffectId.SKILL_CLUB_DOUBLE_HIT:
                {
                    return [SkillPClubDoubleHit.getResource()];
                }
                case SkillEffectId.SKILL_CLUB_BONE_CRUSHER:
                {
                    return [SkillPClubBoneCrusher.getResource()];
                }
                case SkillEffectId.SKILL_CLUB_TRIPLEHIT:
                {
                    return [SkillPClubTripleHit.getResource()];
                }
                case SkillEffectId.SKILL_CLUB_EARTH_SPLIT_ATTACK:
                {
                    return [SkillPClubEarthSplitAttack.getResource()];
                }
                case SkillEffectId.SKILL_CLUB_ROCK_BREAKER:
                {
                    return [SkillPClubRockBreaker.getResource()];
                }
                case SkillEffectId.SKILL_CLUB_GRAND_SLAM:
                {
                    return [SkillPClubGrandSlam.getResource()];
                }
                case SkillEffectId.SKILL_CLUB_TURTLE_SHELL_BREAK:
                {
                    return [SkillPClubTurtleShellBreak.getResource()];
                }
                case SkillEffectId.SKILL_SMALLSWORD_FEINT:
                {
                    return [SkillPSmallSwordFeint.getResource()];
                }
                case SkillEffectId.SKILL_PARALYSISSTAB:
                {
                    return [SkillPSmallSwordParalysisStab.getResource()];
                }
                case SkillEffectId.SKILL_SIDEWINDER:
                {
                    return [SkillPSmallSwordSideWinder.getResource()];
                }
                case SkillEffectId.SKILL_LIGHTNING_PIERCE:
                {
                    return [SkillPSmallSwordLightningPierce.getResource()];
                }
                case SkillEffectId.SKILL_RONDO_SWORD:
                {
                    return [SkillPSmallSwordRondoSword.getResource()];
                }
                case SkillEffectId.SKILL_SWORD_FLASH:
                {
                    return [SkillPSmallSwordSwordFlash.getResource()];
                }
                case SkillEffectId.SKILL_BESERKERSTAB:
                {
                    return [SkillPSmallSwordBeserkerStab.getResource()];
                }
                case SkillEffectId.SKILL_SCREWDRIVER:
                {
                    return [SkillPSmallSwordScrewDriver.getResource()];
                }
                case SkillEffectId.SKILL_FINAL_LETTER:
                {
                    return [SkillPSmallSwordFinalLetter.getResource()];
                }
                case SkillEffectId.SKILL_SPEAR_TRIP:
                {
                    return [SkillPSpearTrip.getResource()];
                }
                case SkillEffectId.SKILL_SPEAR_AIMING:
                {
                    return [SkillPSpearAiming.getResource()];
                }
                case SkillEffectId.SKILL_SPEAR_DOUBLESTAB:
                {
                    return [SkillPSpearDoubleStab.getResource()];
                }
                case SkillEffectId.SKILL_SPEAR_BRAIN_SCRAPE:
                {
                    return [SkillPSpearBrainScrape.getResource()];
                }
                case SkillEffectId.SKILL_SPEAR_CHARGE:
                {
                    return [SkillPSpearCharge.getResource()];
                }
                case SkillEffectId.SKILL_SPEAR__DOUBLE_DRAGON_WAVE:
                {
                    return [SkillPSpearDoubleDragonWave.getResource()];
                }
                case SkillEffectId.SKILL_SPEAR__BEAST_KILLER:
                {
                    return [SkillPSpearBeastKiller.getResource()];
                }
                case SkillEffectId.SKILL_SPEAR_SPIRALCHARGE:
                {
                    return [SkillPSpearSpiralCharge.getResource()];
                }
                case SkillEffectId.SKILL_SPEAR_METEORTHRUST:
                {
                    return [SkillPSpearMeteorThrust.getResource()];
                }
                case SkillEffectId.SKILL_BOW_SHADOWPIN:
                {
                    return [SkillPBowShadowPin.getResource()];
                }
                case SkillEffectId.SKILL_BOW_BLINDINGARROW:
                {
                    return [SkillPBowBlindingArrow.getResource()];
                }
                case SkillEffectId.SKILL_DOUBLE_ARROW:
                {
                    return [SkillPBowDoubleArrow.getResource()];
                }
                case SkillEffectId.SKILL_RANDOM_ARROW:
                {
                    return [SkillPBowRandomArrow.getResource()];
                }
                case SkillEffectId.SKILL_ID_BREAK:
                {
                    return [SkillPBowIdBreak.getResource()];
                }
                case SkillEffectId.SKILL_BEAST_SLAYER:
                {
                    return [SkillPBowBeastSlayer.getResource()];
                }
                case SkillEffectId.SKILL_ARROW_RAIN:
                {
                    return [SkillPBowArrowRain.getResource()];
                }
                case SkillEffectId.SKILL_SPARROW_SHOT:
                {
                    return [SkillPBowSparrowShot.getResource()];
                }
                case SkillEffectId.SKILL_RAPID_ARROW:
                {
                    return [SkillPBowRapidArrow.getResource()];
                }
                case SkillEffectId.SKILL_RAPID_FIRE:
                {
                    return [SkillPBowRapidFire.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_KICK:
                {
                    return [SkillPMartialArtKick.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_CHISHOT:
                {
                    return [SkillPMartialArtChiShot.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_CORKSCREW:
                {
                    return [SkillPMartialArtCorkscrew.getResource()];
                }
                case SkillEffectId.SKILL_MATERIALART_AIR_THROW:
                {
                    return [SkillPMartialArtAirThrow.getResource()];
                }
                case SkillEffectId.SKILL_MATERIALART_LIGHTINING_KICK:
                {
                    return [SkillPMartialArtLightningKick.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_MACHINEGUNPUNCHES:
                {
                    return [SkillPMartialArtMachineGunPunches.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_SUBMISSION:
                {
                    return [SkillPMartialArtSubmission.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_NIAGARA_BUSTER:
                {
                    return [SkillPMartialArtNiagaraBuster.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_1000HANDS_BUDDHA:
                {
                    return [SkillPMartialArt1000HandBuddha.getResource()];
                }
                case SkillEffectId.SKILL_SWORD_PARRY:
                {
                    return [SkillPSwordParryCounterInit.getResource(), SkillPAttackSword.getResource()];
                }
                case SkillEffectId.SKILL_SMALLSWORD_MATADOR:
                {
                    return [SkillPSmallSwordMatadorCounterInit.getResource(), SkillPAttackSword.getResource()];
                }
                case SkillEffectId.SKILL_SPEAR_WINDMILL:
                {
                    return [SkillPSpearWindmillCounterInit.getResource(), SkillPAttackSword.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_COUNTER:
                {
                    return [SkillPMartialArtCounterCounterInit.getResource(), SkillPAttackSword.getResource()];
                }
                case SkillEffectId.MAGIC_FRAMEWHIP:
                {
                    return [SkillPMagicFireFrameWhip.getResource()];
                }
                case SkillEffectId.MAGIC_FIRE_FIREWEAPON:
                {
                    return [SkillPMagicFireFireWeapon.getResource()];
                }
                case SkillEffectId.MAGIC_FIRE_FIREBALL:
                {
                    return [SkillPMagicFireFireBall.getResource()];
                }
                case SkillEffectId.MAGIC_FIRE_HARDFIRE:
                {
                    return [SkillPMagicFireHardFire.getResource()];
                }
                case SkillEffectId.MAGIC_FIRE_FIREBIRD:
                {
                    return [SkillPMagicFireFireBird.getResource()];
                }
                case SkillEffectId.MAGIC_FIRE_SELFBURNING:
                {
                    return [SkillPMagicFireSelfBurning.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_WATERGUN:
                {
                    return [SkillPMagicWaterWaterGun.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_OILHELL:
                {
                    return [SkillPMagicWaterOilHell.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_WHIRLPOOLS:
                {
                    return [SkillEMagicWaterWhirlpools.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_HEALTHWATER:
                {
                    return [SkillPMagicWaterHealthWater.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_ANTIDOTEWATER:
                {
                    return [SkillPMagicWaterAntidoteWater.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_SQUALL:
                {
                    return [SkillPMagicWaterSquall.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_WATERWHIRL:
                {
                    return [SkillPMagicWaterWaterWhirl.getResource()];
                }
                case SkillEffectId.MAGIC_EARTH_FOOTGRIP:
                {
                    return [SkillPMagicEarthFootGrip.getResource()];
                }
                case SkillEffectId.MAGIC_EARTH_STONESHOWER:
                {
                    return [SkillPMagicEarthStoneShower.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_LIGHTNINGBOLT:
                {
                    return [SkillEMagicWindLightningBolt.getResource()];
                }
                case SkillEffectId.MAGIC_EARTH_GOLDENSTRENGTH:
                {
                    return [SkillPMagicEarthGoldenStrength.getResource()];
                }
                case SkillEffectId.MAGIC_EARTH_STONEBULLET:
                {
                    return [SkillPMagicEarthStoneBullet.getResource()];
                }
                case SkillEffectId.MAGIC_EARTH_STONESKIN:
                {
                    return [SkillPMagicEarthStoneSkin.getResource()];
                }
                case SkillEffectId.MAGIC_EARTH_GOLDENSTRENGTHSHIELD:
                {
                    return [SkillPMagicEarthGoldenStrengthShield.getResource()];
                }
                case SkillEffectId.MAGIC_EARTH_CRACK:
                {
                    return [SkillPMagicEarthCrack.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_DANCINGLEAF:
                {
                    return [SkillPMagicWindDancingleaf.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_NAP:
                {
                    return [SkillPMagicWindNap.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_TORNADO:
                {
                    return [SkillPMagicWindTornado.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_COLDWEAPON:
                {
                    return [SkillPMagicWindColdWeapon.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_WINDCUTTER:
                {
                    return [SkillPMagicWindWindCutter.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_THORNBIND:
                {
                    return [SkillPMagicWindThornBind.getResource()];
                }
                case SkillEffectId.MAGIC_HEAVEN_SUNRAY:
                {
                    return [SkillPMagicHeavenSunRay.getResource()];
                }
                case SkillEffectId.MAGIC_HEAVEN_MOONLIGHTHEEL:
                {
                    return [SkillPMagicHeavenMoonlightHeel.getResource()];
                }
                case SkillEffectId.MAGIC_HEAVEN_SWORD_BARRIER:
                {
                    return [SkillPMagicHeavenSwordBarrier.getResource()];
                }
                case SkillEffectId.MAGIC_HEAVEN_SUNWIND:
                {
                    return [SkillPMagicHeavenSunWind.getResource()];
                }
                case SkillEffectId.MAGIC_HEAVEN_MOONGLOW:
                {
                    return [SkillPMagicHeavenMoonGlow.getResource()];
                }
                case SkillEffectId.MAGIC_HEAVEN_STARFIXER:
                {
                    return [SkillPMagicHeavenStarFixer.getResource()];
                }
                case SkillEffectId.MAGIC_HEAVEN_LIGHTBALL:
                {
                    return [SkillPMagicHeavenLightBall.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_WEAKNESS:
                {
                    return [SkillPMagicHadesweakness.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_SHADOWBOLT:
                {
                    return [SkillPMagicHadesShadowBolt.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_PAIN:
                {
                    return [SkillPMagicHadesPain.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_DARKSWORD:
                {
                    return [SkillPMagicHadesDarkSword.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_SOULFREEZE:
                {
                    return [SkillPMagicHadesSoulFreeze.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_PAINDOUBLE:
                {
                    return [SkillPMagicHadesPainDouble.getResource()];
                }
                case SkillEffectId.MAGIC_FIRE_FLAME:
                {
                    return [SkillEMagicFireFlame.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_MAELSTROM:
                {
                    return [SkillEMagicWaterMaelstrom.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_TEMPTATION:
                {
                    return [SkillEMagicHadesTemptation.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_POISONMIST:
                {
                    return [SkillEMagicWaterPoisonMist.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_SUCKINGBLOOD:
                {
                    return [SkillEMagicHadesBloodSucking.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_HYPNOSIS:
                {
                    return [SkillEMagicHadesHypnosis.getResource()];
                }
                case SkillEffectId.MAGIC_HEAVEN_PSYCHOBIND:
                {
                    return [SkillEMagicHeavenPsychoBind.getResource()];
                }
                case SkillEffectId.SKILL_CLUB_GRANDSLAM:
                {
                    return [SkillEClubGrandSlam.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_BLACKSPHERE:
                {
                    return [SkillEMagicHadesBlackSphere.getResource()];
                }
                case SkillEffectId.MAGIC_EARTH_BERSERK:
                {
                    return [SkillEMagicEarthBerserk.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_EVILSPIRIT:
                {
                    return [SkillEMagicHadesEvilSpirit.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_ULTRASONIC:
                {
                    return [SkillEMagicWindUltrasonic.getResource()];
                }
                case SkillEffectId.MAGIC_FIRE_STARE:
                {
                    return [SkillEMagicFireStare.getResource()];
                }
                case SkillEffectId.MAGIC_FIRE_TRINITYBLAST:
                {
                    return [SkillEMagicFireTrinityBlast.getResource()];
                }
                case SkillEffectId.SKILL_SWORD_SOULSTEAL:
                {
                    return [SkillESwordSoulSteal.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_FANGCRASH:
                {
                    return [SkillEMartialArtFangCrash.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_ANIMATE:
                {
                    return [SkillEMagicHadesAnimate.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_POISONGAS:
                {
                    return [SkillEMagicHadesPoisonGas.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_DEDDORIDORAIBU:
                {
                    return [SkillEMagicHadesDeddoriDoraibu.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_STRONGESTBLOW:
                {
                    return [SkillEMartialArtStrongestBlow.getResource()];
                }
                case SkillEffectId.MAGIC_FIRE_HEATWAVE:
                {
                    return [SkillEMagicFireHeatWave.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_POLLEN:
                {
                    return [SkillEMagicWindPollen.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_ENGINEFULLYOPENING:
                {
                    return [SkillEMartialArtEngineFullyOpening.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_ABSORB:
                {
                    return [SkillEMagicWindAbsorb.getResource()];
                }
                case SkillEffectId.SKILL_SWORD_DEATHSWORD:
                {
                    return [SkillESwordDeathSword.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_MUCUS:
                {
                    return [SkillEMagicWaterMucus.getResource()];
                }
                case SkillEffectId.SKILL_AXE_DEATHSSCYTHE:
                {
                    return [SkillEAxeDeathsScythe.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_CYCLONESQUEEZE:
                {
                    return [SkillEMagicWaterCycloneSqueeze.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_ELECTRICSHOCK:
                {
                    return [SkillEMagicWaterElectricShock.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_CALLTHUNDER:
                {
                    return [SkillEMagicWaterCallThunder.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_LIGHTNINGSTRIKE:
                {
                    return [SkillEMagicWaterLightningStrike.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_MEGASUCTION:
                {
                    return [SkillEMagicHadesMegaSuction.getResource()];
                }
                case SkillEffectId.ATTACK_MARTIALART_CLAW:
                {
                    return [SkillEMartialArtClaw.getResource()];
                }
                case SkillEffectId.ATTACK_MARTIALART_CLAWPOISON:
                {
                    return [SkillEMartialArtClawPoison.getResource()];
                }
                case SkillEffectId.ATTACK_MARTIALART_CLAWPARALYSIS:
                {
                    return [SkillEMartialArtClawParalysis.getResource()];
                }
                case SkillEffectId.ATTACK_MARTIALART_FANG:
                {
                    return [SkillEMartialArtFang.getResource()];
                }
                case SkillEffectId.ATTACK_MARTIALART_FANGPOISON:
                {
                    return [SkillEMartialArtFangPoison.getResource()];
                }
                case SkillEffectId.ATTACK_MARTIALART_FANGPARALYSIS:
                {
                    return [SkillEMartialArtFangParalysis.getResource()];
                }
                case SkillEffectId.ATTACK_MARTIALART_STRONGBLOW:
                {
                    return [SkillEMartialArtStrongBlow.getResource()];
                }
                case SkillEffectId.ATTACK_MARTIALART_HORN:
                {
                    return [SkillEMartialArtHorn.getResource()];
                }
                case SkillEffectId.ATTACK_MARTIALART_TACKLE:
                {
                    return [SkillEMartialArtTackle.getResource()];
                }
                case SkillEffectId.ATTACK_MARTIALART_NEEDLEPOISON:
                {
                    return [SkillEMartialArtNeedlePoison.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_DIAMONDDUST:
                {
                    return [SkillEMagicWindDiamondDust.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_TONGUE:
                {
                    return [SkillEMartialArtTongue.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_TONGUEPOISON:
                {
                    return [SkillEMartialArtTonguePoison.getResource()];
                }
                case SkillEffectId.ATTACK_MARTIALART_MINOSCRASH:
                {
                    return [SkillEMartialArtMinosCrash.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_VENOM:
                {
                    return [SkillEMagicWaterVenom.getResource()];
                }
                case SkillEffectId.MAGIC_FIRE_FLAMEWIND:
                {
                    return [SkillEMagicFireFlameWind.getResource()];
                }
                case SkillEffectId.MAGIC_FIRE_HOTIRON:
                {
                    return [SkillEMagicFireHotIron.getResource()];
                }
                case SkillEffectId.SKILL_SWORD_BLADENET:
                {
                    return [SkillESwordBladeNet.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_TAIL:
                {
                    return [SkillEMartialArtTail.getResource()];
                }
                case SkillEffectId.SKILL_SMALLSWORD_RAPIER:
                {
                    return [SkillPAttackSmallSword.getResource()];
                }
                case SkillEffectId.SKILL_AXE_BATTLEAXE:
                {
                    return [SkillPAttackAxe.getResource()];
                }
                case SkillEffectId.SKILL_BOW_DART:
                {
                    return [SkillPAttackBow.getResource()];
                }
                case SkillEffectId.SKILL_BOW_BULLSHITDIRT:
                {
                    return [SkillPBowRandomArrow.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_PUNCH:
                {
                    return [SkillPAttackMartialArt1.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_BODYATTACK:
                {
                    return [SkillEMartialArtBodyAttack.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_STOMP:
                {
                    return [SkillEMartialArtStomp.getResource()];
                }
                case SkillEffectId.SKILL_SWORD_FALLINGMOONCUT:
                {
                    return [SkillESwordFallingMoonCut.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_DOUBLEATTACK:
                {
                    return [SkillEMartialArtDoubleAttack.getResource()];
                }
                case SkillEffectId.SKILL_AXE_AXEBOMBER:
                {
                    return [SkillEAxeAxeBomber.getResource()];
                }
                case SkillEffectId.SKILL_CLUB_HALT:
                {
                    return [SkillEClubHalt.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_TRIPLEATTACK:
                {
                    return [SkillEMartialArtTripleAttack.getResource()];
                }
                case SkillEffectId.SKILL_SWORD_GEKIKENHA:
                {
                    return [SkillESwordGekikenha.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_DEATHHAND:
                {
                    return [SkillEMartialArtDeathHand.getResource()];
                }
                case SkillEffectId.MAGIC_HADES_RESTRAINTSSHADOW:
                {
                    return [SkillEMagicHadesRestraintsShadow.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_STRONGACID:
                {
                    return [SkillEMagicWaterStrongAcid.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_THUNDERBALL:
                {
                    return [SkillEMagicWaterThunderBall.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_ACIDSPRAY:
                {
                    return [SkillEMagicWaterAcidSpray.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_COLDAIR:
                {
                    return [SkillEMagicWindColdAir.getResource()];
                }
                case SkillEffectId.SKILL_MARTIALART_WINDAROUND:
                {
                    return [SkillEMartialArtWindAround.getResource()];
                }
                case SkillEffectId.MAGIC_FIRE_FIREARTS:
                {
                    return [SkillEMagicFireFireArt.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_LIGHTNINGARTS:
                {
                    return [SkillEMagicWindLightningArt.getResource()];
                }
                case SkillEffectId.MAGIC_WIND_ICEARTS:
                {
                    return [SkillEMagicWindIceArt.getResource()];
                }
                case SkillEffectId.SKILL_SPEAR_LIGHTNING_THRUST:
                {
                    return [SkillESpearLightningThrust.getResource()];
                }
                case SkillEffectId.MAGIC_WATER_ILLSTORM:
                {
                    return [SkillEMagicWaterIllStorm.getResource()];
                }
                case SkillEffectId.SKILL_SWORD_MOONSHADOW:
                {
                    return [SkillPSwordMoonShadow.getResource()];
                }
                default:
                {
                    break;
                }
            }
            return [];
        }// end function

        public function getSkillSeId(param1:int) : Array
        {
            switch(this.convertNotSupportedSkillId(param1))
            {
                case SkillEffectId.ATTACK_SWORD:
                {
                    return SkillPAttackSword.getSeIdList();
                }
                case SkillEffectId.ATTACK_AXE:
                {
                    return SkillPAttackAxe.getSeIdList();
                }
                case SkillEffectId.ATTACK_CLUB:
                {
                    return SkillPAttackClub.getSeIdList();
                }
                case SkillEffectId.ATTACK_SPEAR:
                {
                    return SkillPAttackSpear.getSeIdList();
                }
                case SkillEffectId.ATTACK_SMALL_SWORD:
                {
                    return SkillPAttackSmallSword.getSeIdList();
                }
                case SkillEffectId.ATTACK_BOW:
                {
                    return SkillPAttackBow.getSeIdList();
                }
                case SkillEffectId.MAGIC_FRAMEWHIP:
                {
                    return SkillPMagicFireFrameWhip.getSeIdList();
                }
                case SkillEffectId.SKILL_SAMIDARE:
                {
                    return SkillPSwordSamidare.getSeIdList();
                }
                case SkillEffectId.SKILL_MIJIN:
                {
                    return SkillPSwordTanzaku.getSeIdList();
                }
                case SkillEffectId.SKILL_ONSOKU:
                {
                    return SkillPSwordSonicSword.getSeIdList();
                }
                case SkillEffectId.SKILL_CROSSBREAK:
                {
                    return SkillPSwordCrossBreak.getSeIdList();
                }
                case SkillEffectId.SKILL_SPEAR_TRIP:
                {
                    return SkillPSpearTrip.getSeIdList();
                }
                case SkillEffectId.SKILL_SPEAR_AIMING:
                {
                    return SkillPSpearAiming.getSeIdList();
                }
                case SkillEffectId.SKILL_SPEAR_DOUBLESTAB:
                {
                    return SkillPSpearDoubleStab.getSeIdList();
                }
                case SkillEffectId.SKILL_SPEAR_CHARGE:
                {
                    return SkillPSpearCharge.getSeIdList();
                }
                case SkillEffectId.SKILL_SPEAR__DOUBLE_DRAGON_WAVE:
                {
                    return SkillPSpearDoubleDragonWave.getSeIdList();
                }
                case SkillEffectId.SKILL_SPEAR__BEAST_KILLER:
                {
                    return SkillPSpearBeastKiller.getSeIdList();
                }
                case SkillEffectId.SKILL_DOUBLE_ARROW:
                {
                    return SkillPBowDoubleArrow.getSeIdList();
                }
                case SkillEffectId.SKILL_RANDOM_ARROW:
                {
                    return SkillPBowRandomArrow.getSeIdList();
                }
                case SkillEffectId.SKILL_RAPID_ARROW:
                {
                    return SkillPBowRapidArrow.getSeIdList();
                }
                case SkillEffectId.SKILL_ARROW_RAIN:
                {
                    return SkillPBowArrowRain.getSeIdList();
                }
                case SkillEffectId.SKILL_BEAST_SLAYER:
                {
                    return SkillPBowBeastSlayer.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_KICK:
                {
                    return SkillPMartialArtKick.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_CHISHOT:
                {
                    return SkillPMartialArtChiShot.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_CORKSCREW:
                {
                    return SkillPMartialArtCorkscrew.getSeIdList();
                }
                case SkillEffectId.SKILL_MATERIALART_AIR_THROW:
                {
                    return SkillPMartialArtAirThrow.getSeIdList();
                }
                case SkillEffectId.SKILL_MATERIALART_LIGHTINING_KICK:
                {
                    return SkillPMartialArtLightningKick.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_MACHINEGUNPUNCHES:
                {
                    return SkillPMartialArtMachineGunPunches.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_SUBMISSION:
                {
                    return SkillPMartialArtSubmission.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_NIAGARA_BUSTER:
                {
                    return SkillPMartialArtNiagaraBuster.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_1000HANDS_BUDDHA:
                {
                    return SkillPMartialArt1000HandBuddha.getSeIdList();
                }
                case SkillEffectId.SKILL_AXE_TOMAHAWK:
                {
                    return SkillPAxeTomahawk.getSeIdList();
                }
                case SkillEffectId.SKILL_ONE_PERSON_TIMELAG:
                {
                    return SkillPAxeOnePersonTimelag.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_BARB_THRUST:
                {
                    return SkillPClubBarbThrust.getSeIdList();
                }
                case SkillEffectId.SKILL_CLUB_CROWN_SPLITTER:
                {
                    return SkillPClubCrownSplitter.getSeIdList();
                }
                case SkillEffectId.SKILL_CLUB_GONG_BEAT:
                {
                    return SkillPClubGongBeat.getSeIdList();
                }
                case SkillEffectId.SKILL_CLUB_DOUBLE_HIT:
                {
                    return SkillPClubDoubleHit.getSeIdList();
                }
                case SkillEffectId.SKILL_CLUB_BONE_CRUSHER:
                {
                    return SkillPClubBoneCrusher.getSeIdList();
                }
                case SkillEffectId.SKILL_CLUB_ROCK_BREAKER:
                {
                    return SkillPClubRockBreaker.getSeIdList();
                }
                case SkillEffectId.SKILL_CLUB_EARTH_SPLIT_ATTACK:
                {
                    return SkillPClubEarthSplitAttack.getSeIdList();
                }
                case SkillEffectId.SKILL_CLUB_GRAND_SLAM:
                {
                    return SkillPClubGrandSlam.getSeIdList();
                }
                case SkillEffectId.SKILL_CLUB_TURTLE_SHELL_BREAK:
                {
                    return SkillPClubTurtleShellBreak.getSeIdList();
                }
                case SkillEffectId.SKILL_POWERHIT:
                {
                    return SkillPBigSwordPowerHit.getSeIdList();
                }
                case SkillEffectId.SKILL_SMASH:
                {
                    return SkillPBigSwordSmash.getSeIdList();
                }
                case SkillEffectId.SKILL_SNOWPLOW_BLADE:
                {
                    return SkillPBigSwordSnowPlowBlade.getSeIdList();
                }
                case SkillEffectId.SKILL_CHAOTIC_FLOWER_FALL:
                {
                    return SkillPBigSwordChaoticFlowerfall.getSeIdList();
                }
                case SkillEffectId.SKILL_TRIPLECUT:
                {
                    return SkillPBigSwordTripleCut.getSeIdList();
                }
                case SkillEffectId.SKILL_WINDUPSTRIKE:
                {
                    return SkillPBigSwordWindUpStrike.getSeIdList();
                }
                case SkillEffectId.SKILL_WOODCUTTER:
                {
                    return SkillPAxeWoodCutter.getSeIdList();
                }
                case SkillEffectId.SKILL_BLADEROLL:
                {
                    return SkillPAxeBladeRoll.getSeIdList();
                }
                case SkillEffectId.SKILL_FLYBY:
                {
                    return SkillPAxeFlyby.getSeIdList();
                }
                case SkillEffectId.SKILL_WOOD_SPLIT_DYNAMIC:
                {
                    return SkillPAxeWoodSplitDynamic.getSeIdList();
                }
                case SkillEffectId.SKILL_HIGH_SPEED_NABLA:
                {
                    return SkillPAxeHighSpeedNabla.getSeIdList();
                }
                case SkillEffectId.ATTACK_LARGE_SWORD:
                {
                    return SkillPAttackLargeSword.getSeIdList();
                }
                case SkillEffectId.SKILL_ITIMONJI:
                {
                    return SkillPSwordStraightSlash.getSeIdList();
                }
                case SkillEffectId.SKILL_CROSS_SLASH:
                {
                    return SkillPSwordCrossSlash.getSeIdList();
                }
                case SkillEffectId.SKILL_NAGIHARAI:
                {
                    return SkillPSwordSweepDown.getSeIdList();
                }
                case SkillEffectId.SKILL_TUMUJIWIND:
                {
                    return SkillPSwordTsumujiWind.getSeIdList();
                }
                case SkillEffectId.ATTACK_PUNCH_LEFT:
                {
                    return SkillPAttackMartialArt1.getSeIdList();
                }
                case SkillEffectId.ATTACK_PUNCH_SCISSERS:
                {
                    return SkillPAttackMartialArt1.getSeIdList();
                }
                case SkillEffectId.SKILL_PARALYSISSTAB:
                {
                    return SkillPSmallSwordParalysisStab.getSeIdList();
                }
                case SkillEffectId.SKILL_SIDEWINDER:
                {
                    return SkillPSmallSwordSideWinder.getSeIdList();
                }
                case SkillEffectId.SKILL_LIGHTNING_PIERCE:
                {
                    return SkillPSmallSwordLightningPierce.getSeIdList();
                }
                case SkillEffectId.SKILL_RONDO_SWORD:
                {
                    return SkillPSmallSwordRondoSword.getSeIdList();
                }
                case SkillEffectId.SKILL_SWORD_FLASH:
                {
                    return SkillPSmallSwordSwordFlash.getSeIdList();
                }
                case SkillEffectId.SKILL_BESERKERSTAB:
                {
                    return SkillPSmallSwordBeserkerStab.getSeIdList();
                }
                case SkillEffectId.SKILL_SCREWDRIVER:
                {
                    return SkillPSmallSwordScrewDriver.getSeIdList();
                }
                case SkillEffectId.SKILL_FINAL_LETTER:
                {
                    return SkillPSmallSwordFinalLetter.getSeIdList();
                }
                case SkillEffectId.MAGIC_FIRE_FIREWEAPON:
                {
                    return SkillPMagicFireFireWeapon.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_WATERGUN:
                {
                    return SkillPMagicWaterWaterGun.getSeIdList();
                }
                case SkillEffectId.MAGIC_EARTH_FOOTGRIP:
                {
                    return SkillPMagicEarthFootGrip.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_DANCINGLEAF:
                {
                    return SkillPMagicWindDancingleaf.getSeIdList();
                }
                case SkillEffectId.MAGIC_HEAVEN_SUNRAY:
                {
                    return SkillPMagicHeavenSunRay.getSeIdList();
                }
                case SkillEffectId.MAGIC_HEAVEN_MOONLIGHTHEEL:
                {
                    return SkillPMagicHeavenMoonlightHeel.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_WEAKNESS:
                {
                    return SkillPMagicHadesweakness.getSeIdList();
                }
                case SkillEffectId.SKILL_SWORD_FALCONSLASH:
                {
                    return SkillPSwordFalconSlash.getSeIdList();
                }
                case SkillEffectId.SKILL_SWORD_DOUBLECUT:
                {
                    return SkillPSwordDoubleCut.getSeIdList();
                }
                case SkillEffectId.SKILL_SWORD_VACUUMCUT:
                {
                    return SkillPSwordVacuumCut.getSeIdList();
                }
                case SkillEffectId.SKILL_SWORD_MIRAGEBLADE:
                {
                    return SkillPSwordMirageBlade.getSeIdList();
                }
                case SkillEffectId.SKILL_BIGSWORD_DOUBLESTROKE:
                {
                    return SkillPBigSwordDoubleStroke.getSeIdList();
                }
                case SkillEffectId.SKILL_BIGSWORD_SWALLOWCUT:
                {
                    return SkillPBigSwordSwallowCut.getSeIdList();
                }
                case SkillEffectId.SKILL_BIGSWORD_PUMMELSTRIKE:
                {
                    return SkillPBigSwordPummelStrike.getSeIdList();
                }
                case SkillEffectId.SKILL_BIGSWORD_DROPCUT:
                {
                    return SkillPBigSwordDropCut.getSeIdList();
                }
                case SkillEffectId.SKILL_AXE_SKYDIVE:
                {
                    return SkillPAxeSkyDive.getSeIdList();
                }
                case SkillEffectId.SKILL_CLUB_TRIPLEHIT:
                {
                    return SkillPClubTripleHit.getSeIdList();
                }
                case SkillEffectId.SKILL_SPEAR_BRAIN_SCRAPE:
                {
                    return SkillPSpearBrainScrape.getSeIdList();
                }
                case SkillEffectId.SKILL_SMALLSWORD_FEINT:
                {
                    return SkillPSmallSwordFeint.getSeIdList();
                }
                case SkillEffectId.SKILL_SPEAR_SPIRALCHARGE:
                {
                    return SkillPSpearSpiralCharge.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_MACHINEGUNPUNCHES:
                {
                    return SkillPMartialArtMachineGunPunches.getSeIdList();
                }
                case SkillEffectId.MAGIC_FIRE_FIREBALL:
                {
                    return SkillPMagicFireFireBall.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_OILHELL:
                {
                    return SkillPMagicWaterOilHell.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_WHIRLPOOLS:
                {
                    return SkillEMagicWaterWhirlpools.getSeIdList();
                }
                case SkillEffectId.MAGIC_EARTH_STONESHOWER:
                {
                    return SkillPMagicEarthStoneShower.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_LIGHTNINGBOLT:
                {
                    return SkillEMagicWindLightningBolt.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_NAP:
                {
                    return SkillPMagicWindNap.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_TORNADO:
                {
                    return SkillPMagicWindTornado.getSeIdList();
                }
                case SkillEffectId.MAGIC_HEAVEN_SWORD_BARRIER:
                {
                    return SkillPMagicHeavenSwordBarrier.getSeIdList();
                }
                case SkillEffectId.MAGIC_HEAVEN_SUNWIND:
                {
                    return SkillPMagicHeavenSunWind.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_SHADOWBOLT:
                {
                    return SkillPMagicHadesShadowBolt.getSeIdList();
                }
                case SkillEffectId.MAGIC_EARTH_GOLDENSTRENGTH:
                {
                    return SkillPMagicEarthGoldenStrength.getSeIdList();
                }
                case SkillEffectId.SKILL_BOW_SHADOWPIN:
                {
                    return SkillPBowShadowPin.getSeIdList();
                }
                case SkillEffectId.SKILL_BOW_BLINDINGARROW:
                {
                    return SkillPBowBlindingArrow.getSeIdList();
                }
                case SkillEffectId.SKILL_ID_BREAK:
                {
                    return SkillPBowIdBreak.getSeIdList();
                }
                case SkillEffectId.SKILL_SPARROW_SHOT:
                {
                    return SkillPBowSparrowShot.getSeIdList();
                }
                case SkillEffectId.SKILL_RAPID_FIRE:
                {
                    return SkillPBowRapidFire.getSeIdList();
                }
                case SkillEffectId.SKILL_AXE_YOYO:
                {
                    return SkillPAxeYoyo.getSeIdList();
                }
                case SkillEffectId.SKILL_HEEL_CUT:
                {
                    return SkillPAxeHeelCut.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_HEALTHWATER:
                {
                    return SkillPMagicWaterHealthWater.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_ANTIDOTEWATER:
                {
                    return SkillPMagicWaterAntidoteWater.getSeIdList();
                }
                case SkillEffectId.MAGIC_EARTH_STONEBULLET:
                {
                    return SkillPMagicEarthStoneBullet.getSeIdList();
                }
                case SkillEffectId.MAGIC_EARTH_STONESKIN:
                {
                    return SkillPMagicEarthStoneSkin.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_PAIN:
                {
                    return SkillPMagicHadesPain.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_COLDWEAPON:
                {
                    return SkillPMagicWindColdWeapon.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_WINDCUTTER:
                {
                    return SkillPMagicWindWindCutter.getSeIdList();
                }
                case SkillEffectId.MAGIC_HEAVEN_LIGHTBALL:
                {
                    return SkillPMagicHeavenLightBall.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_SOULFREEZE:
                {
                    return SkillPMagicHadesSoulFreeze.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_SQUALL:
                {
                    return SkillPMagicWaterSquall.getSeIdList();
                }
                case SkillEffectId.MAGIC_FIRE_HARDFIRE:
                {
                    return SkillPMagicFireHardFire.getSeIdList();
                }
                case SkillEffectId.MAGIC_FIRE_FIREBIRD:
                {
                    return SkillPMagicFireFireBird.getSeIdList();
                }
                case SkillEffectId.MAGIC_FIRE_SELFBURNING:
                {
                    return SkillPMagicFireSelfBurning.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_THORNBIND:
                {
                    return SkillPMagicWindThornBind.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_WATERWHIRL:
                {
                    return SkillPMagicWaterWaterWhirl.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_DARKSWORD:
                {
                    return SkillPMagicHadesDarkSword.getSeIdList();
                }
                case SkillEffectId.MAGIC_EARTH_GOLDENSTRENGTHSHIELD:
                {
                    return SkillPMagicEarthGoldenStrengthShield.getSeIdList();
                }
                case SkillEffectId.MAGIC_EARTH_CRACK:
                {
                    return SkillPMagicEarthCrack.getSeIdList();
                }
                case SkillEffectId.MAGIC_HEAVEN_MOONGLOW:
                {
                    return SkillPMagicHeavenMoonGlow.getSeIdList();
                }
                case SkillEffectId.MAGIC_HEAVEN_STARFIXER:
                {
                    return SkillPMagicHeavenStarFixer.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_PAINDOUBLE:
                {
                    return SkillPMagicHadesPainDouble.getSeIdList();
                }
                case SkillEffectId.SKILL_SPEAR_METEORTHRUST:
                {
                    return SkillPSpearMeteorThrust.getSeIdList();
                }
                case SkillEffectId.SKILL_BIGSWORD_CRANEBLADE:
                {
                    return SkillPBigSwordCraneBlade.getSeIdList();
                }
                case SkillEffectId.SKILL_SWORD_PARRY:
                {
                    return SkillPSwordParryCounterInit.getSeIdList().concat(SkillPSwordParryCounterAttack.getSeIdList());
                }
                case SkillEffectId.SKILL_SMALLSWORD_MATADOR:
                {
                    return SkillPSmallSwordMatadorCounterInit.getSeIdList().concat(SkillPSmallSwordMatadorCounterAttack.getSeIdList());
                }
                case SkillEffectId.SKILL_SPEAR_WINDMILL:
                {
                    return SkillPSpearWindmillCounterInit.getSeIdList().concat(SkillPSpearWindmillCounterAttack.getSeIdList());
                }
                case SkillEffectId.SKILL_MARTIALART_COUNTER:
                {
                    return SkillPMartialArtCounterCounterInit.getSeIdList().concat(SkillPMartialArtCounterCounterAttack.getSeIdList());
                }
                case SkillEffectId.MAGIC_FIRE_FLAME:
                {
                    return SkillEMagicFireFlame.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_MAELSTROM:
                {
                    return SkillEMagicWaterMaelstrom.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_TEMPTATION:
                {
                    return SkillEMagicHadesTemptation.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_POISONMIST:
                {
                    return SkillEMagicWaterPoisonMist.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_SUCKINGBLOOD:
                {
                    return SkillEMagicHadesBloodSucking.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_HYPNOSIS:
                {
                    return SkillEMagicHadesHypnosis.getSeIdList();
                }
                case SkillEffectId.MAGIC_HEAVEN_PSYCHOBIND:
                {
                    return SkillEMagicHeavenPsychoBind.getSeIdList();
                }
                case SkillEffectId.SKILL_CLUB_GRANDSLAM:
                {
                    return SkillEClubGrandSlam.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_BLACKSPHERE:
                {
                    return SkillEMagicHadesBlackSphere.getSeIdList();
                }
                case SkillEffectId.MAGIC_EARTH_BERSERK:
                {
                    return SkillEMagicEarthBerserk.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_EVILSPIRIT:
                {
                    return SkillEMagicHadesEvilSpirit.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_ULTRASONIC:
                {
                    return SkillEMagicWindUltrasonic.getSeIdList();
                }
                case SkillEffectId.MAGIC_FIRE_STARE:
                {
                    return SkillEMagicFireStare.getSeIdList();
                }
                case SkillEffectId.MAGIC_FIRE_TRINITYBLAST:
                {
                    return SkillEMagicFireTrinityBlast.getSeIdList();
                }
                case SkillEffectId.SKILL_SWORD_SOULSTEAL:
                {
                    return SkillESwordSoulSteal.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_FANGCRASH:
                {
                    return SkillEMartialArtFangCrash.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_ANIMATE:
                {
                    return SkillEMagicHadesAnimate.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_POISONGAS:
                {
                    return SkillEMagicHadesPoisonGas.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_DEDDORIDORAIBU:
                {
                    return SkillEMagicHadesDeddoriDoraibu.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_STRONGESTBLOW:
                {
                    return SkillEMartialArtStrongestBlow.getSeIdList();
                }
                case SkillEffectId.MAGIC_FIRE_HEATWAVE:
                {
                    return SkillEMagicFireHeatWave.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_POLLEN:
                {
                    return SkillEMagicWindPollen.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_ENGINEFULLYOPENING:
                {
                    return SkillEMartialArtEngineFullyOpening.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_ABSORB:
                {
                    return SkillEMagicWindAbsorb.getSeIdList();
                }
                case SkillEffectId.SKILL_SWORD_DEATHSWORD:
                {
                    return SkillESwordDeathSword.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_MUCUS:
                {
                    return SkillEMagicWaterMucus.getSeIdList();
                }
                case SkillEffectId.SKILL_AXE_DEATHSSCYTHE:
                {
                    return SkillEAxeDeathsScythe.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_CYCLONESQUEEZE:
                {
                    return SkillEMagicWaterCycloneSqueeze.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_ELECTRICSHOCK:
                {
                    return SkillEMagicWaterElectricShock.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_CALLTHUNDER:
                {
                    return SkillEMagicWaterCallThunder.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_LIGHTNINGSTRIKE:
                {
                    return SkillEMagicWaterLightningStrike.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_MEGASUCTION:
                {
                    return SkillEMagicHadesMegaSuction.getSeIdList();
                }
                case SkillEffectId.ATTACK_MARTIALART_CLAW:
                {
                    return SkillEMartialArtClaw.getSeIdList();
                }
                case SkillEffectId.ATTACK_MARTIALART_CLAWPOISON:
                {
                    return SkillEMartialArtClawPoison.getSeIdList();
                }
                case SkillEffectId.ATTACK_MARTIALART_CLAWPARALYSIS:
                {
                    return SkillEMartialArtClawParalysis.getSeIdList();
                }
                case SkillEffectId.ATTACK_MARTIALART_FANG:
                {
                    return SkillEMartialArtFang.getSeIdList();
                }
                case SkillEffectId.ATTACK_MARTIALART_FANGPOISON:
                {
                    return SkillEMartialArtFangPoison.getSeIdList();
                }
                case SkillEffectId.ATTACK_MARTIALART_FANGPARALYSIS:
                {
                    return SkillEMartialArtFangParalysis.getSeIdList();
                }
                case SkillEffectId.ATTACK_MARTIALART_STRONGBLOW:
                {
                    return SkillEMartialArtStrongBlow.getSeIdList();
                }
                case SkillEffectId.ATTACK_MARTIALART_HORN:
                {
                    return SkillEMartialArtHorn.getSeIdList();
                }
                case SkillEffectId.ATTACK_MARTIALART_TACKLE:
                {
                    return SkillEMartialArtTackle.getSeIdList();
                }
                case SkillEffectId.ATTACK_MARTIALART_NEEDLEPOISON:
                {
                    return SkillEMartialArtNeedlePoison.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_DIAMONDDUST:
                {
                    return SkillEMagicWindDiamondDust.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_TONGUE:
                {
                    return SkillEMartialArtTongue.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_TONGUEPOISON:
                {
                    return SkillEMartialArtTonguePoison.getSeIdList();
                }
                case SkillEffectId.ATTACK_MARTIALART_MINOSCRASH:
                {
                    return SkillEMartialArtMinosCrash.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_VENOM:
                {
                    return SkillEMagicWaterVenom.getSeIdList();
                }
                case SkillEffectId.MAGIC_FIRE_FLAMEWIND:
                {
                    return SkillEMagicFireFlameWind.getSeIdList();
                }
                case SkillEffectId.MAGIC_FIRE_HOTIRON:
                {
                    return SkillEMagicFireHotIron.getSeIdList();
                }
                case SkillEffectId.SKILL_SWORD_BLADENET:
                {
                    return SkillESwordBladeNet.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_TAIL:
                {
                    return SkillEMartialArtTail.getSeIdList();
                }
                case SkillEffectId.SKILL_SMALLSWORD_RAPIER:
                {
                    return SkillPAttackSmallSword.getSeIdList();
                }
                case SkillEffectId.SKILL_AXE_BATTLEAXE:
                {
                    return SkillPAttackAxe.getSeIdList();
                }
                case SkillEffectId.SKILL_BOW_DART:
                {
                    return SkillPAttackBow.getSeIdList();
                }
                case SkillEffectId.SKILL_BOW_BULLSHITDIRT:
                {
                    return SkillPBowRandomArrow.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_PUNCH:
                {
                    return SkillPAttackMartialArt1.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_BODYATTACK:
                {
                    return SkillEMartialArtBodyAttack.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_STOMP:
                {
                    return SkillEMartialArtStomp.getSeIdList();
                }
                case SkillEffectId.SKILL_SWORD_FALLINGMOONCUT:
                {
                    return SkillESwordFallingMoonCut.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_DOUBLEATTACK:
                {
                    return SkillEMartialArtDoubleAttack.getSeIdList();
                }
                case SkillEffectId.SKILL_AXE_AXEBOMBER:
                {
                    return SkillEAxeAxeBomber.getSeIdList();
                }
                case SkillEffectId.SKILL_CLUB_HALT:
                {
                    return SkillEClubHalt.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_TRIPLEATTACK:
                {
                    return SkillEMartialArtTripleAttack.getSeIdList();
                }
                case SkillEffectId.SKILL_SWORD_GEKIKENHA:
                {
                    return SkillESwordGekikenha.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_DEATHHAND:
                {
                    return SkillEMartialArtDeathHand.getSeIdList();
                }
                case SkillEffectId.MAGIC_HADES_RESTRAINTSSHADOW:
                {
                    return SkillEMagicHadesRestraintsShadow.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_STRONGACID:
                {
                    return SkillEMagicWaterStrongAcid.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_THUNDERBALL:
                {
                    return SkillEMagicWaterThunderBall.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_ACIDSPRAY:
                {
                    return SkillEMagicWaterAcidSpray.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_COLDAIR:
                {
                    return SkillEMagicWindColdAir.getSeIdList();
                }
                case SkillEffectId.SKILL_MARTIALART_WINDAROUND:
                {
                    return SkillEMartialArtWindAround.getSeIdList();
                }
                case SkillEffectId.MAGIC_FIRE_FIREARTS:
                {
                    return SkillEMagicFireFireArt.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_LIGHTNINGARTS:
                {
                    return SkillEMagicWindLightningArt.getSeIdList();
                }
                case SkillEffectId.MAGIC_WIND_ICEARTS:
                {
                    return SkillEMagicWindIceArt.getSeIdList();
                }
                case SkillEffectId.SKILL_SPEAR_LIGHTNING_THRUST:
                {
                    return SkillESpearLightningThrust.getSeIdList();
                }
                case SkillEffectId.MAGIC_WATER_ILLSTORM:
                {
                    return SkillEMagicWaterIllStorm.getSeIdList();
                }
                case SkillEffectId.SKILL_SWORD_MOONSHADOW:
                {
                    return SkillPSwordMoonShadow.getSeIdList();
                }
                default:
                {
                    break;
                }
            }
            return [];
        }// end function

        public function getDefenceMcName(param1:int) : String
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case SkillEffectId.SKILL_SPEAR_WINDMILL:
                {
                    _loc_2 = SkillPSpearWindmillCounterInit.getDefenceMcName();
                    break;
                }
                case SkillEffectId.SKILL_SWORD_PARRY:
                {
                    _loc_2 = SkillPSwordParryCounterInit.getDefenceMcName();
                    break;
                }
                case SkillEffectId.SKILL_SMALLSWORD_MATADOR:
                {
                    _loc_2 = SkillPSmallSwordMatadorCounterInit.getDefenceMcName();
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_COUNTER:
                {
                    _loc_2 = SkillPMartialArtCounterCounterInit.getDefenceMcName();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function createSkill(param1:int, param2:LayerBattle, param3:BattleCharacterBase, param4:Array, param5:EffectManager, param6:BattleManager, param7:int = 0) : SkillBase
        {
            var _loc_8:* = null;
            var _loc_9:* = param3.characterAction;
            var _loc_10:* = param3.division == BattleConstant.DIVISION_ENEMY;
            switch(this.convertNotSupportedSkillId(param1))
            {
                case SkillEffectId.ATTACK_SWORD:
                {
                    _loc_8 = new SkillPAttackSword(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_LARGE_SWORD:
                {
                    _loc_8 = new SkillPAttackLargeSword(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_AXE:
                {
                    _loc_8 = new SkillPAttackAxe(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_CLUB:
                {
                    _loc_8 = new SkillPAttackClub(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_SPEAR:
                {
                    _loc_8 = new SkillPAttackSpear(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_SMALL_SWORD:
                {
                    _loc_8 = new SkillPAttackSmallSword(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_BOW:
                {
                    _loc_8 = new SkillPAttackBow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FRAMEWHIP:
                {
                    _loc_8 = new SkillPMagicFireFrameWhip(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SAMIDARE:
                {
                    _loc_8 = new SkillPSwordSamidare(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MIJIN:
                {
                    _loc_8 = new SkillPSwordTanzaku(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_ONSOKU:
                {
                    _loc_8 = new SkillPSwordSonicSword(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CROSSBREAK:
                {
                    _loc_8 = new SkillPSwordCrossBreak(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_ITIMONJI:
                {
                    _loc_8 = new SkillPSwordStraightSlash(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CROSS_SLASH:
                {
                    _loc_8 = new SkillPSwordCrossSlash(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_NAGIHARAI:
                {
                    _loc_8 = new SkillPSwordSweepDown(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_TUMUJIWIND:
                {
                    _loc_8 = new SkillPSwordTsumujiWind(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SPEAR_TRIP:
                {
                    _loc_8 = new SkillPSpearTrip(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SPEAR_AIMING:
                {
                    _loc_8 = new SkillPSpearAiming(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SPEAR_DOUBLESTAB:
                {
                    _loc_8 = new SkillPSpearDoubleStab(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SPEAR_CHARGE:
                {
                    _loc_8 = new SkillPSpearCharge(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SPEAR__DOUBLE_DRAGON_WAVE:
                {
                    _loc_8 = new SkillPSpearDoubleDragonWave(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SPEAR__BEAST_KILLER:
                {
                    _loc_8 = new SkillPSpearBeastKiller(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_RAPID_ARROW:
                {
                    _loc_8 = new SkillPBowRapidArrow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_RANDOM_ARROW:
                {
                    _loc_8 = new SkillPBowRandomArrow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_DOUBLE_ARROW:
                {
                    _loc_8 = new SkillPBowDoubleArrow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_BEAST_SLAYER:
                {
                    _loc_8 = new SkillPBowBeastSlayer(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_ARROW_RAIN:
                {
                    _loc_8 = new SkillPBowArrowRain(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_KICK:
                {
                    _loc_8 = new SkillPMartialArtKick(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_COUNTER:
                {
                    if (param7 == SkillConstant.INVOKE_TYPE_COUNTER)
                    {
                        _loc_8 = new SkillPMartialArtCounterCounterAttack(param2, _loc_9, param4, _loc_10, param5);
                    }
                    else
                    {
                        _loc_8 = new SkillPMartialArtCounterCounterInit(param2, _loc_9, param4, _loc_10, param5);
                    }
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_CHISHOT:
                {
                    _loc_8 = new SkillPMartialArtChiShot(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_CORKSCREW:
                {
                    _loc_8 = new SkillPMartialArtCorkscrew(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MATERIALART_AIR_THROW:
                {
                    _loc_8 = new SkillPMartialArtAirThrow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MATERIALART_LIGHTINING_KICK:
                {
                    _loc_8 = new SkillPMartialArtLightningKick(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_SUBMISSION:
                {
                    _loc_8 = new SkillPMartialArtSubmission(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_NIAGARA_BUSTER:
                {
                    _loc_8 = new SkillPMartialArtNiagaraBuster(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_1000HANDS_BUDDHA:
                {
                    _loc_8 = new SkillPMartialArt1000HandBuddha(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_AXE_TOMAHAWK:
                {
                    _loc_8 = new SkillPAxeTomahawk(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_ONE_PERSON_TIMELAG:
                {
                    _loc_8 = new SkillPAxeOnePersonTimelag(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_POWERHIT:
                {
                    _loc_8 = new SkillPBigSwordPowerHit(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SMASH:
                {
                    _loc_8 = new SkillPBigSwordSmash(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SNOWPLOW_BLADE:
                {
                    _loc_8 = new SkillPBigSwordSnowPlowBlade(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CHAOTIC_FLOWER_FALL:
                {
                    _loc_8 = new SkillPBigSwordChaoticFlowerfall(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_TRIPLECUT:
                {
                    _loc_8 = new SkillPBigSwordTripleCut(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_WINDUPSTRIKE:
                {
                    _loc_8 = new SkillPBigSwordWindUpStrike(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_WOODCUTTER:
                {
                    _loc_8 = new SkillPAxeWoodCutter(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_BLADEROLL:
                {
                    _loc_8 = new SkillPAxeBladeRoll(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_FLYBY:
                {
                    _loc_8 = new SkillPAxeFlyby(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_WOOD_SPLIT_DYNAMIC:
                {
                    _loc_8 = new SkillPAxeWoodSplitDynamic(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_HIGH_SPEED_NABLA:
                {
                    _loc_8 = new SkillPAxeHighSpeedNabla(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_PUNCH_LEFT:
                {
                    _loc_8 = new SkillPAttackMartialArt1(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_PUNCH_SCISSERS:
                {
                    _loc_8 = new SkillPAttackMartialArt1(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_PARALYSISSTAB:
                {
                    _loc_8 = new SkillPSmallSwordParalysisStab(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SIDEWINDER:
                {
                    _loc_8 = new SkillPSmallSwordSideWinder(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_LIGHTNING_PIERCE:
                {
                    _loc_8 = new SkillPSmallSwordLightningPierce(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_RONDO_SWORD:
                {
                    _loc_8 = new SkillPSmallSwordRondoSword(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SWORD_FLASH:
                {
                    _loc_8 = new SkillPSmallSwordSwordFlash(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_BESERKERSTAB:
                {
                    _loc_8 = new SkillPSmallSwordBeserkerStab(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SCREWDRIVER:
                {
                    _loc_8 = new SkillPSmallSwordScrewDriver(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_FINAL_LETTER:
                {
                    _loc_8 = new SkillPSmallSwordFinalLetter(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_BARB_THRUST:
                {
                    _loc_8 = new SkillPClubBarbThrust(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CLUB_CROWN_SPLITTER:
                {
                    _loc_8 = new SkillPClubCrownSplitter(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CLUB_GONG_BEAT:
                {
                    _loc_8 = new SkillPClubGongBeat(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CLUB_DOUBLE_HIT:
                {
                    _loc_8 = new SkillPClubDoubleHit(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CLUB_BONE_CRUSHER:
                {
                    _loc_8 = new SkillPClubBoneCrusher(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CLUB_EARTH_SPLIT_ATTACK:
                {
                    _loc_8 = new SkillPClubEarthSplitAttack(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CLUB_ROCK_BREAKER:
                {
                    _loc_8 = new SkillPClubRockBreaker(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CLUB_GRAND_SLAM:
                {
                    _loc_8 = new SkillPClubGrandSlam(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CLUB_TURTLE_SHELL_BREAK:
                {
                    _loc_8 = new SkillPClubTurtleShellBreak(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FIRE_FIREWEAPON:
                {
                    _loc_8 = new SkillPMagicFireFireWeapon(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_WATERGUN:
                {
                    _loc_8 = new SkillPMagicWaterWaterGun(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_EARTH_FOOTGRIP:
                {
                    _loc_8 = new SkillPMagicEarthFootGrip(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_DANCINGLEAF:
                {
                    _loc_8 = new SkillPMagicWindDancingleaf(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HEAVEN_SUNRAY:
                {
                    _loc_8 = new SkillPMagicHeavenSunRay(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HEAVEN_MOONLIGHTHEEL:
                {
                    _loc_8 = new SkillPMagicHeavenMoonlightHeel(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_WEAKNESS:
                {
                    _loc_8 = new SkillPMagicHadesweakness(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SWORD_FALCONSLASH:
                {
                    _loc_8 = new SkillPSwordFalconSlash(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SWORD_DOUBLECUT:
                {
                    _loc_8 = new SkillPSwordDoubleCut(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SWORD_VACUUMCUT:
                {
                    _loc_8 = new SkillPSwordVacuumCut(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SWORD_MIRAGEBLADE:
                {
                    _loc_8 = new SkillPSwordMirageBlade(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_BIGSWORD_DOUBLESTROKE:
                {
                    _loc_8 = new SkillPBigSwordDoubleStroke(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_BIGSWORD_SWALLOWCUT:
                {
                    _loc_8 = new SkillPBigSwordSwallowCut(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_BIGSWORD_PUMMELSTRIKE:
                {
                    _loc_8 = new SkillPBigSwordPummelStrike(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_BIGSWORD_DROPCUT:
                {
                    _loc_8 = new SkillPBigSwordDropCut(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_AXE_SKYDIVE:
                {
                    _loc_8 = new SkillPAxeSkyDive(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CLUB_TRIPLEHIT:
                {
                    _loc_8 = new SkillPClubTripleHit(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SPEAR_WINDMILL:
                {
                    if (param7 == SkillConstant.INVOKE_TYPE_COUNTER)
                    {
                        _loc_8 = new SkillPSpearWindmillCounterAttack(param2, _loc_9, param4, _loc_10, param5);
                    }
                    else
                    {
                        _loc_8 = new SkillPSpearWindmillCounterInit(param2, _loc_9, param4, _loc_10, param5);
                    }
                    break;
                }
                case SkillEffectId.SKILL_SPEAR_BRAIN_SCRAPE:
                {
                    _loc_8 = new SkillPSpearBrainScrape(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SMALLSWORD_FEINT:
                {
                    _loc_8 = new SkillPSmallSwordFeint(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SPEAR_SPIRALCHARGE:
                {
                    _loc_8 = new SkillPSpearSpiralCharge(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_MACHINEGUNPUNCHES:
                {
                    _loc_8 = new SkillPMartialArtMachineGunPunches(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FIRE_FIREBALL:
                {
                    _loc_8 = new SkillPMagicFireFireBall(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_OILHELL:
                {
                    _loc_8 = new SkillPMagicWaterOilHell(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_WHIRLPOOLS:
                {
                    _loc_8 = new SkillEMagicWaterWhirlpools(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_EARTH_STONESHOWER:
                {
                    _loc_8 = new SkillPMagicEarthStoneShower(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_LIGHTNINGBOLT:
                {
                    _loc_8 = new SkillEMagicWindLightningBolt(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_NAP:
                {
                    _loc_8 = new SkillPMagicWindNap(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_TORNADO:
                {
                    _loc_8 = new SkillPMagicWindTornado(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HEAVEN_SWORD_BARRIER:
                {
                    _loc_8 = new SkillPMagicHeavenSwordBarrier(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HEAVEN_SUNWIND:
                {
                    _loc_8 = new SkillPMagicHeavenSunWind(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_SHADOWBOLT:
                {
                    _loc_8 = new SkillPMagicHadesShadowBolt(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_EARTH_GOLDENSTRENGTH:
                {
                    _loc_8 = new SkillPMagicEarthGoldenStrength(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_BOW_SHADOWPIN:
                {
                    _loc_8 = new SkillPBowShadowPin(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_BOW_BLINDINGARROW:
                {
                    _loc_8 = new SkillPBowBlindingArrow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_ID_BREAK:
                {
                    _loc_8 = new SkillPBowIdBreak(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SPARROW_SHOT:
                {
                    _loc_8 = new SkillPBowSparrowShot(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_RAPID_FIRE:
                {
                    _loc_8 = new SkillPBowRapidFire(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_AXE_YOYO:
                {
                    _loc_8 = new SkillPAxeYoyo(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_HEEL_CUT:
                {
                    _loc_8 = new SkillPAxeHeelCut(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SWORD_PARRY:
                {
                    if (param7 == SkillConstant.INVOKE_TYPE_COUNTER)
                    {
                        _loc_8 = new SkillPSwordParryCounterAttack(param2, _loc_9, param4, _loc_10, param5);
                    }
                    else
                    {
                        _loc_8 = new SkillPSwordParryCounterInit(param2, _loc_9, param4, _loc_10, param5);
                    }
                    break;
                }
                case SkillEffectId.SKILL_SMALLSWORD_MATADOR:
                {
                    if (param7 == SkillConstant.INVOKE_TYPE_COUNTER)
                    {
                        _loc_8 = new SkillPSmallSwordMatadorCounterAttack(param2, _loc_9, param4, _loc_10, param5);
                    }
                    else
                    {
                        _loc_8 = new SkillPSmallSwordMatadorCounterInit(param2, _loc_9, param4, _loc_10, param5);
                    }
                    break;
                }
                case SkillEffectId.MAGIC_WATER_HEALTHWATER:
                {
                    _loc_8 = new SkillPMagicWaterHealthWater(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_ANTIDOTEWATER:
                {
                    _loc_8 = new SkillPMagicWaterAntidoteWater(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_EARTH_STONEBULLET:
                {
                    _loc_8 = new SkillPMagicEarthStoneBullet(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_EARTH_STONESKIN:
                {
                    _loc_8 = new SkillPMagicEarthStoneSkin(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_PAIN:
                {
                    _loc_8 = new SkillPMagicHadesPain(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_COLDWEAPON:
                {
                    _loc_8 = new SkillPMagicWindColdWeapon(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_WINDCUTTER:
                {
                    _loc_8 = new SkillPMagicWindWindCutter(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HEAVEN_LIGHTBALL:
                {
                    _loc_8 = new SkillPMagicHeavenLightBall(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_SOULFREEZE:
                {
                    _loc_8 = new SkillPMagicHadesSoulFreeze(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_SQUALL:
                {
                    _loc_8 = new SkillPMagicWaterSquall(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FIRE_HARDFIRE:
                {
                    _loc_8 = new SkillPMagicFireHardFire(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FIRE_FIREBIRD:
                {
                    _loc_8 = new SkillPMagicFireFireBird(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FIRE_SELFBURNING:
                {
                    _loc_8 = new SkillPMagicFireSelfBurning(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_THORNBIND:
                {
                    _loc_8 = new SkillPMagicWindThornBind(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_WATERWHIRL:
                {
                    _loc_8 = new SkillPMagicWaterWaterWhirl(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_DARKSWORD:
                {
                    _loc_8 = new SkillPMagicHadesDarkSword(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_EARTH_GOLDENSTRENGTHSHIELD:
                {
                    _loc_8 = new SkillPMagicEarthGoldenStrengthShield(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_EARTH_CRACK:
                {
                    _loc_8 = new SkillPMagicEarthCrack(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HEAVEN_MOONGLOW:
                {
                    _loc_8 = new SkillPMagicHeavenMoonGlow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HEAVEN_STARFIXER:
                {
                    _loc_8 = new SkillPMagicHeavenStarFixer(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_PAINDOUBLE:
                {
                    _loc_8 = new SkillPMagicHadesPainDouble(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SPEAR_METEORTHRUST:
                {
                    _loc_8 = new SkillPSpearMeteorThrust(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_BIGSWORD_CRANEBLADE:
                {
                    _loc_8 = new SkillPBigSwordCraneBlade(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FIRE_FLAME:
                {
                    _loc_8 = new SkillEMagicFireFlame(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_MAELSTROM:
                {
                    _loc_8 = new SkillEMagicWaterMaelstrom(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_TEMPTATION:
                {
                    _loc_8 = new SkillEMagicHadesTemptation(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_POISONMIST:
                {
                    _loc_8 = new SkillEMagicWaterPoisonMist(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_SUCKINGBLOOD:
                {
                    _loc_8 = new SkillEMagicHadesBloodSucking(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_HYPNOSIS:
                {
                    _loc_8 = new SkillEMagicHadesHypnosis(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HEAVEN_PSYCHOBIND:
                {
                    _loc_8 = new SkillEMagicHeavenPsychoBind(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CLUB_GRANDSLAM:
                {
                    _loc_8 = new SkillEClubGrandSlam(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_BLACKSPHERE:
                {
                    _loc_8 = new SkillEMagicHadesBlackSphere(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_EARTH_BERSERK:
                {
                    _loc_8 = new SkillEMagicEarthBerserk(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_EVILSPIRIT:
                {
                    _loc_8 = new SkillEMagicHadesEvilSpirit(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_ULTRASONIC:
                {
                    _loc_8 = new SkillEMagicWindUltrasonic(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FIRE_STARE:
                {
                    _loc_8 = new SkillEMagicFireStare(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FIRE_TRINITYBLAST:
                {
                    _loc_8 = new SkillEMagicFireTrinityBlast(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SWORD_SOULSTEAL:
                {
                    _loc_8 = new SkillESwordSoulSteal(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_FANGCRASH:
                {
                    _loc_8 = new SkillEMartialArtFangCrash(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_ANIMATE:
                {
                    _loc_8 = new SkillEMagicHadesAnimate(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_POISONGAS:
                {
                    _loc_8 = new SkillEMagicHadesPoisonGas(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_DEDDORIDORAIBU:
                {
                    _loc_8 = new SkillEMagicHadesDeddoriDoraibu(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_STRONGESTBLOW:
                {
                    _loc_8 = new SkillEMartialArtStrongestBlow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FIRE_HEATWAVE:
                {
                    _loc_8 = new SkillEMagicFireHeatWave(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_POLLEN:
                {
                    _loc_8 = new SkillEMagicWindPollen(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_ENGINEFULLYOPENING:
                {
                    _loc_8 = new SkillEMartialArtEngineFullyOpening(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_ABSORB:
                {
                    _loc_8 = new SkillEMagicWindAbsorb(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SWORD_DEATHSWORD:
                {
                    _loc_8 = new SkillESwordDeathSword(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_MUCUS:
                {
                    _loc_8 = new SkillEMagicWaterMucus(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_AXE_DEATHSSCYTHE:
                {
                    _loc_8 = new SkillEAxeDeathsScythe(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_CYCLONESQUEEZE:
                {
                    _loc_8 = new SkillEMagicWaterCycloneSqueeze(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_ELECTRICSHOCK:
                {
                    _loc_8 = new SkillEMagicWaterElectricShock(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_CALLTHUNDER:
                {
                    _loc_8 = new SkillEMagicWaterCallThunder(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_LIGHTNINGSTRIKE:
                {
                    _loc_8 = new SkillEMagicWaterLightningStrike(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_MEGASUCTION:
                {
                    _loc_8 = new SkillEMagicHadesMegaSuction(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_MARTIALART_CLAW:
                {
                    _loc_8 = new SkillEMartialArtClaw(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_MARTIALART_CLAWPOISON:
                {
                    _loc_8 = new SkillEMartialArtClawPoison(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_MARTIALART_CLAWPARALYSIS:
                {
                    _loc_8 = new SkillEMartialArtClawParalysis(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_MARTIALART_FANG:
                {
                    _loc_8 = new SkillEMartialArtFang(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_MARTIALART_FANGPOISON:
                {
                    _loc_8 = new SkillEMartialArtFangPoison(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_MARTIALART_FANGPARALYSIS:
                {
                    _loc_8 = new SkillEMartialArtFangParalysis(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_MARTIALART_STRONGBLOW:
                {
                    _loc_8 = new SkillEMartialArtStrongBlow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_MARTIALART_HORN:
                {
                    _loc_8 = new SkillEMartialArtHorn(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_MARTIALART_TACKLE:
                {
                    _loc_8 = new SkillEMartialArtTackle(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_MARTIALART_NEEDLEPOISON:
                {
                    _loc_8 = new SkillEMartialArtNeedlePoison(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_DIAMONDDUST:
                {
                    _loc_8 = new SkillEMagicWindDiamondDust(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_TONGUE:
                {
                    _loc_8 = new SkillEMartialArtTongue(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_TONGUEPOISON:
                {
                    _loc_8 = new SkillEMartialArtTonguePoison(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.ATTACK_MARTIALART_MINOSCRASH:
                {
                    _loc_8 = new SkillEMartialArtMinosCrash(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_VENOM:
                {
                    _loc_8 = new SkillEMagicWaterVenom(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FIRE_FLAMEWIND:
                {
                    _loc_8 = new SkillEMagicFireFlameWind(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FIRE_HOTIRON:
                {
                    _loc_8 = new SkillEMagicFireHotIron(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SWORD_BLADENET:
                {
                    _loc_8 = new SkillESwordBladeNet(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_TAIL:
                {
                    _loc_8 = new SkillEMartialArtTail(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SMALLSWORD_RAPIER:
                {
                    _loc_8 = new SkillPAttackSmallSword(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_AXE_BATTLEAXE:
                {
                    _loc_8 = new SkillPAttackAxe(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_BOW_DART:
                {
                    _loc_8 = new SkillPAttackBow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_BOW_BULLSHITDIRT:
                {
                    _loc_8 = new SkillPBowRandomArrow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_PUNCH:
                {
                    _loc_8 = new SkillPAttackMartialArt1(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_BODYATTACK:
                {
                    _loc_8 = new SkillEMartialArtBodyAttack(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_STOMP:
                {
                    _loc_8 = new SkillEMartialArtStomp(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SWORD_FALLINGMOONCUT:
                {
                    _loc_8 = new SkillESwordFallingMoonCut(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_DOUBLEATTACK:
                {
                    _loc_8 = new SkillEMartialArtDoubleAttack(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_AXE_AXEBOMBER:
                {
                    _loc_8 = new SkillEAxeAxeBomber(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_CLUB_HALT:
                {
                    _loc_8 = new SkillEClubHalt(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_TRIPLEATTACK:
                {
                    _loc_8 = new SkillEMartialArtTripleAttack(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SWORD_GEKIKENHA:
                {
                    _loc_8 = new SkillESwordGekikenha(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_DEATHHAND:
                {
                    _loc_8 = new SkillEMartialArtDeathHand(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_HADES_RESTRAINTSSHADOW:
                {
                    _loc_8 = new SkillEMagicHadesRestraintsShadow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_STRONGACID:
                {
                    _loc_8 = new SkillEMagicWaterStrongAcid(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_THUNDERBALL:
                {
                    _loc_8 = new SkillEMagicWaterThunderBall(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_ACIDSPRAY:
                {
                    _loc_8 = new SkillEMagicWaterAcidSpray(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_COLDAIR:
                {
                    _loc_8 = new SkillEMagicWindColdAir(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_MARTIALART_WINDAROUND:
                {
                    _loc_8 = new SkillEMartialArtWindAround(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_FIRE_FIREARTS:
                {
                    _loc_8 = new SkillEMagicFireFireArt(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_LIGHTNINGARTS:
                {
                    _loc_8 = new SkillEMagicWindLightningArt(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WIND_ICEARTS:
                {
                    _loc_8 = new SkillEMagicWindIceArt(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SPEAR_LIGHTNING_THRUST:
                {
                    _loc_8 = new SkillESpearLightningThrust(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.MAGIC_WATER_ILLSTORM:
                {
                    _loc_8 = new SkillEMagicWaterIllStorm(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                case SkillEffectId.SKILL_SWORD_MOONSHADOW:
                {
                    _loc_8 = new SkillPSwordMoonShadow(param2, _loc_9, param4, _loc_10, param5);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_8 != null)
            {
                _loc_8.setBattleManager(param6);
                _loc_8.setWeapon(param1);
            }
            else
            {
                Assert("作成出来なかったスキルです SkillEffectId:" + param1.toString());
            }
            return _loc_8;
        }// end function

        private function convertNotSupportedSkillId(param1:int) : int
        {
            switch(param1)
            {
                case 107003:
                case 109001:
                case 111001:
                case 107002:
                {
                    return 8;
                }
                default:
                {
                    break;
                }
            }
            return param1;
        }// end function

        public function getComeUpSkill(param1:int) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._aSkillInfo)
            {
                
                if (_loc_3.gliterDiffculty > 0 && _loc_3.comeUpType == param1)
                {
                    _loc_2.push(_loc_3.id);
                }
            }
            return _loc_2;
        }// end function

        public function getWeaponClassName(param1:int) : String
        {
            var _loc_2:* = "";
            if (param1 == SkillEffectId.SKILL_SWORD_FALLINGMOONCUT)
            {
                var _loc_4:* = "weapon_Sword2_Scimitar";
                _loc_2 = "weapon_Sword2_Scimitar";
                return _loc_4;
            }
            var _loc_3:* = this.getSkillInformationFromSkillEffectId(param1);
            if (_loc_3 != null)
            {
                _loc_2 = this.getWeaponClassNameFromSkillType(_loc_3.skillType);
            }
            return _loc_2;
        }// end function

        public function getWeaponClassNameFromSkillType(param1:int) : String
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case SkillConstant.SKILL_TYPE_SWORD:
                {
                    _loc_2 = "weapon_Sword1";
                    break;
                }
                case SkillConstant.SKILL_TYPE_LARGE_SWORD:
                {
                    _loc_2 = "weapon_Sword_Big";
                    break;
                }
                case SkillConstant.SKILL_TYPE_SPEAR:
                {
                    _loc_2 = "weapon_Spear";
                    break;
                }
                case SkillConstant.SKILL_TYPE_AX:
                {
                    _loc_2 = "weapon_Axe";
                    break;
                }
                case SkillConstant.SKILL_TYPE_SMALL_SWORD:
                {
                    _loc_2 = "weapon_Sword_Small";
                    break;
                }
                case SkillConstant.SKILL_TYPE_GRAPPLE:
                {
                    break;
                }
                case SkillConstant.SKILL_TYPE_BOW:
                {
                    _loc_2 = "weapon_Bow";
                    break;
                }
                case SkillConstant.SKILL_TYPE_STICK:
                {
                    _loc_2 = "weapon_Club";
                    break;
                }
                case SkillConstant.SKILL_TYPE_WATER:
                case SkillConstant.SKILL_TYPE_FLAME:
                case SkillConstant.SKILL_TYPE_EARTH:
                case SkillConstant.SKILL_TYPE_WIND:
                case SkillConstant.SKILL_TYPE_LIGHT:
                case SkillConstant.SKILL_TYPE_HADES:
                {
                    break;
                }
                case SkillConstant.SKILL_TYPE_NAIL:
                case SkillConstant.SKILL_TYPE_HALBERD:
                case SkillConstant.SKILL_TYPE_NON:
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

        public function getMagicTypeLabel(param1:int) : String
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case SkillConstant.SKILL_TYPE_FLAME:
                {
                    _loc_2 = SkillConstant.LABEL_MAGIC_TYPE_FIRE;
                    break;
                }
                case SkillConstant.SKILL_TYPE_WATER:
                {
                    _loc_2 = SkillConstant.LABEL_MAGIC_TYPE_WATER;
                    break;
                }
                case SkillConstant.SKILL_TYPE_EARTH:
                {
                    _loc_2 = SkillConstant.LABEL_MAGIC_TYPE_EARTH;
                    break;
                }
                case SkillConstant.SKILL_TYPE_WIND:
                {
                    _loc_2 = SkillConstant.LABEL_MAGIC_TYPE_WIND;
                    break;
                }
                case SkillConstant.SKILL_TYPE_LIGHT:
                {
                    _loc_2 = SkillConstant.LABEL_MAGIC_TYPE_HEAVEN;
                    break;
                }
                case SkillConstant.SKILL_TYPE_HADES:
                {
                    _loc_2 = SkillConstant.LABEL_MAGIC_TYPE_HADES;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function getInstance() : SkillManager
        {
            if (_instance == null)
            {
                _instance = new SkillManager;
            }
            return _instance;
        }// end function

        public static function isMagicSkill(param1:int) : Boolean
        {
            var _loc_2:* = getInstance().getSkillInformation(param1);
            return _loc_2.type == SkillConstant.TYPE_MAGIC;
        }// end function

        public static function isMagicSkillInfo(param1:SkillInformation) : Boolean
        {
            return param1.type == SkillConstant.TYPE_MAGIC;
        }// end function

        public static function getBadStateType(param1:SkillInformation) : int
        {
            switch(param1.addStatus)
            {
                case BattleConstant.ADD_STATUS_POISON:
                {
                    return BattleConstant.BAD_STATE_TYPE_POISON;
                }
                case BattleConstant.ADD_STATUS_PARALYSIS:
                {
                    return BattleConstant.BAD_STATE_TYPE_PARALYSIS;
                }
                case BattleConstant.ADD_STATUS_DARKNESS:
                {
                    return BattleConstant.BAD_STATE_TYPE_DARKNESS;
                }
                case BattleConstant.ADD_STATUS_SLEEP:
                {
                    return BattleConstant.BAD_STATE_TYPE_HYPNOTIC;
                }
                case BattleConstant.ADD_STATUS_CONFUSION:
                {
                    return BattleConstant.BAD_STATE_TYPE_CONFUSION;
                }
                case BattleConstant.ADD_STATUS_STAN:
                {
                    return BattleConstant.BAD_STATE_TYPE_STAN;
                }
                case BattleConstant.ADD_STATUS_CHARM:
                {
                    return BattleConstant.BAD_STATE_TYPE_CHARM;
                }
                case BattleConstant.ADD_STATUS_CHARM_MAN:
                {
                    return BattleConstant.BAD_STATE_TYPE_CHARM;
                }
                case BattleConstant.ADD_STATUS_INSTANT_DEATH:
                {
                    return BattleConstant.BAD_STATE_TYPE_INSTANT_DEATH;
                }
                case BattleConstant.ADD_STATUS_STONE:
                {
                    return BattleConstant.BAD_STATE_TYPE_STONE;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return Constant.EMPTY_ID;
        }// end function

    }
}
