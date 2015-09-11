package herovsdragon.game.ui.life
{
    import flash.display.*;

    public class Life extends Object
    {
        private var mainFunction:Function;
        protected var gage:MovieClip;
        private var MAX_LIFE:int = 100;
        private var life:int;
        private static const DAMAGE_NUM_FOR_STOMP:uint = 15;
        private static const DAMAGE_NUM_FOR_FIRE:uint = 30;
        private static const DAMAGE_NUM_FOR_CLAW:uint = 20;
        private static const DAMAGE_NUM_FOR_NORMAL_ATTACK:uint = 1;
        private static const DAMAGE_NUM_FOR_SECOND_ATTACK:uint = 2;
        private static const DAMAGE_NUM_FOR_THIRD_ATTACK:uint = 2;
        private static const DAMAGE_NUM_FOR_SPECIAL_ATTACK:uint = 3;
        private static const LIFE_UP_NUM_FOR_DEFENSE:uint = 1;
        private static const RANDOM_DAMAGE_PER:uint = 10;
        private static const RANDOM_DAMAGE_FONT:uint = 10;

        public function Life()
        {
            return;
        }// end function

        public function initialize(param1:Sprite) : void
        {
            param1.addChild(this.gage);
            this.initializeAfterGameOver();
            return;
        }// end function

        public function initializeAfterGameOver() : void
        {
            this.life = this.MAX_LIFE;
            this.gage.gotoAndStop(this.gage.totalFrames);
            this.mainFunction = this.stopGage;
            return;
        }// end function

        public function downLifeByNormalAttack() : void
        {
            this.downLife(DAMAGE_NUM_FOR_NORMAL_ATTACK);
            return;
        }// end function

        public function downLifeBySecondAttack() : void
        {
            this.downLife(DAMAGE_NUM_FOR_SECOND_ATTACK);
            return;
        }// end function

        public function downLifeByThirdAttack() : void
        {
            this.downLife(DAMAGE_NUM_FOR_THIRD_ATTACK);
            return;
        }// end function

        public function downLifeBySpecialAttack() : void
        {
            this.downLife(DAMAGE_NUM_FOR_SPECIAL_ATTACK);
            return;
        }// end function

        public function downLifeByStomp() : void
        {
            this.downLife(DAMAGE_NUM_FOR_STOMP);
            return;
        }// end function

        public function downLifeByFire() : void
        {
            this.downLife(DAMAGE_NUM_FOR_FIRE);
            return;
        }// end function

        public function downLifeByClaw() : void
        {
            this.downLife(DAMAGE_NUM_FOR_CLAW);
            return;
        }// end function

        private function downLife(param1:uint) : void
        {
            this.life = this.life - param1;
            this.mainFunction = this.moveGage;
            return;
        }// end function

        public function upLifeByDefense() : void
        {
            this.upLife(LIFE_UP_NUM_FOR_DEFENSE);
            return;
        }// end function

        private function upLife(param1:uint) : void
        {
            this.life = this.life + param1;
            this.mainFunction = this.moveGage;
            return;
        }// end function

        public function run() : void
        {
            this.mainFunction();
            return;
        }// end function

        private function stopGage() : void
        {
            return;
        }// end function

        private function moveGage() : void
        {
            var _loc_1:* = this.life + 1;
            if (this.gage.currentFrame > _loc_1)
            {
                this.gage.gotoAndStop((this.gage.currentFrame - 1));
            }
            else if (this.gage.currentFrame < _loc_1)
            {
                this.gage.gotoAndStop((this.gage.currentFrame + 1));
            }
            else
            {
                this.mainFunction = this.stopGage;
            }
            return;
        }// end function

        public function isZero() : Boolean
        {
            return this.gage.currentFrame == 1;
        }// end function

        private static function getRandamDamageForFont(param1:uint) : int
        {
            var _loc_2:* = Math.floor(Math.random() * RANDOM_DAMAGE_FONT);
            if (Math.floor(Math.random() * 2))
            {
                _loc_2 = _loc_2 * -1;
            }
            return (param1 + _loc_2) * RANDOM_DAMAGE_PER;
        }// end function

        public static function getStompDamageForFont() : int
        {
            return getRandamDamageForFont(DAMAGE_NUM_FOR_STOMP * 2);
        }// end function

        public static function getFireDamageForFont() : int
        {
            return getRandamDamageForFont(DAMAGE_NUM_FOR_FIRE);
        }// end function

        public static function getClawDamageForFont() : int
        {
            return getRandamDamageForFont(DAMAGE_NUM_FOR_CLAW);
        }// end function

        public static function getNormalAttackDamageForFont() : int
        {
            return getRandamDamageForFont(DAMAGE_NUM_FOR_NORMAL_ATTACK * 10);
        }// end function

        public static function getSecondAttackDamageForFont() : int
        {
            return getRandamDamageForFont(DAMAGE_NUM_FOR_SECOND_ATTACK * 10);
        }// end function

        public static function getThirdAttackDamageForFont() : int
        {
            return getRandamDamageForFont(DAMAGE_NUM_FOR_THIRD_ATTACK * 10);
        }// end function

        public static function getSpecialAttackDamageForFont() : int
        {
            return getRandamDamageForFont(DAMAGE_NUM_FOR_SPECIAL_ATTACK * 10);
        }// end function

    }
}
