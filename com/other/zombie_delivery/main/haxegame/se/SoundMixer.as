package haxegame.se
{
    import com.dango_itimi.as3_and_createjs.sound.*;
    import flash.*;
    import flash.media.*;

    public class SoundMixer extends Object
    {
        public static var soundEffectMap:SoundEffectMap;
        public static var clickId:String;
        public static var onId:String;
        public static var gameClearId:String;
        public static var explosionId:String;
        public static var nextTurnId:String;
        public static var gameOutId:String;
        public static var achievementId:String;
        public static var tapId:String;
        public static var selectId:String;
        public static var bgmId1:String;
        public static var bgmId2:String;
        public static var powerUpId:String;
        public static var powerUpId2:String;
        public static var powerUpId3:String;
        public static var coinSmallId:String;
        public static var coinMiddleId:String;
        public static var coinBigId:String;
        public static var coinSpecialId:String;
        public static var comboSpecialId:String;

        public function SoundMixer() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            var _loc_1:* = 1;
            SoundMixer.clickId = register(ClickSound);
            SoundMixer.onId = register(OnSound);
            SoundMixer.gameClearId = register(GameClearSound);
            SoundMixer.explosionId = register(ExplosionSound);
            SoundMixer.nextTurnId = register(NextTurnSound);
            SoundMixer.gameOutId = register(GameOutSound);
            SoundMixer.achievementId = register(AchievementSound);
            SoundMixer.tapId = register(TapSound);
            SoundMixer.selectId = register(SelectSound);
            SoundMixer.powerUpId = register(PowerUpSound);
            SoundMixer.powerUpId2 = register(PowerUpSound2);
            SoundMixer.powerUpId3 = register(PowerUpSound3);
            SoundMixer.coinSmallId = register(CoinSmallSound, _loc_1);
            SoundMixer.coinMiddleId = register(CoinMiddleSound, _loc_1);
            SoundMixer.coinBigId = register(CoinBigSound, _loc_1);
            SoundMixer.coinSpecialId = register(CoinSpecialSound, _loc_1);
            SoundMixer.comboSpecialId = register(ComboSpecialSound, _loc_1);
            SoundMixer.bgmId1 = register(BgmSound1, 0, 1, 0, "", 0, 0, 10000);
            SoundMixer.bgmId2 = register(BgmSound2, 0, 1, 0, "", 0, 0, 10000);
            return;
        }// end function

        public function registerInstance(param1:Class, param2:Sound, param3:Object = undefined, param4:Object = undefined, param5:Object = undefined, param6:String = undefined, param7:Object = undefined, param8:Object = undefined, param9:Object = undefined) : String
        {
            if (param3 == null)
            {
                param3 = 5;
            }
            if (param4 == null)
            {
                param4 = 1;
            }
            if (param5 == null)
            {
                param5 = 0;
            }
            if (param6 == null)
            {
                param6 = "";
            }
            if (param7 == null)
            {
                param7 = 0;
            }
            if (param8 == null)
            {
                param8 = 0;
            }
            if (param9 == null)
            {
                param9 = 0;
            }
            return null;
        }// end function

        public function register(param1, param2:Object = undefined, param3:Object = undefined, param4:Object = undefined, param5:String = undefined, param6:Object = undefined, param7:Object = undefined, param8:Object = undefined) : String
        {
            if (param2 == null)
            {
                param2 = 5;
            }
            if (param3 == null)
            {
                param3 = 1;
            }
            if (param4 == null)
            {
                param4 = 0;
            }
            if (param5 == null)
            {
                param5 = "";
            }
            if (param6 == null)
            {
                param6 = 0;
            }
            if (param7 == null)
            {
                param7 = 0;
            }
            if (param8 == null)
            {
                param8 = 0;
            }
            return null;
        }// end function

        public static function playClick() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.clickId);
            return;
        }// end function

        public static function playOn() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.onId);
            return;
        }// end function

        public static function playGameClear() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.gameClearId);
            return;
        }// end function

        public static function playExplosion() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.explosionId);
            return;
        }// end function

        public static function playNextTurn() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.nextTurnId);
            return;
        }// end function

        public static function playCoinSmall() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.coinSmallId);
            return;
        }// end function

        public static function playCoinMiddle() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.coinMiddleId);
            return;
        }// end function

        public static function playCoinBig() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.coinBigId);
            return;
        }// end function

        public static function playCoinSpecial() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.coinSpecialId);
            return;
        }// end function

        public static function playComboSpecial() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.comboSpecialId);
            return;
        }// end function

        public static function playGameOut() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.gameOutId);
            return;
        }// end function

        public static function playAchievement() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.achievementId);
            return;
        }// end function

        public static function playTap() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.tapId);
            return;
        }// end function

        public static function playSelect() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.selectId);
            return;
        }// end function

        public static function playPowerUp() : void
        {
            var _loc_2:* = null as String;
            var _loc_1:* = Math.random();
            if (_loc_1 < 0.3)
            {
                _loc_2 = SoundMixer.powerUpId;
            }
            else if (_loc_1 < 0.6)
            {
                _loc_2 = SoundMixer.powerUpId2;
            }
            else
            {
                _loc_2 = SoundMixer.powerUpId3;
            }
            SoundMixer.soundEffectMap.play(_loc_2);
            return;
        }// end function

        public static function playBgm1() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.bgmId1);
            return;
        }// end function

        public static function stopBgm1() : void
        {
            SoundMixer.soundEffectMap.stop(SoundMixer.bgmId1);
            return;
        }// end function

        public static function playBgm2() : void
        {
            SoundMixer.soundEffectMap.play(SoundMixer.bgmId2);
            return;
        }// end function

        public static function stopBgm2() : void
        {
            SoundMixer.soundEffectMap.stop(SoundMixer.bgmId2);
            return;
        }// end function

    }
}
