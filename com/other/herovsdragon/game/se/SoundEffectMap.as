package herovsdragon.game.se
{
    import __AS3__.vec.*;
    import flash.utils.*;

    public class SoundEffectMap extends Object
    {
        private var seSet:Vector.<SoundEffect>;
        private var playSeMap:Dictionary;

        public function SoundEffectMap()
        {
            this.playSeMap = new Dictionary();
            this.seSet = new Vector.<SoundEffect>;
            this.create(Walk);
            this.create(HittedBlade, 1);
            this.create(Blade);
            this.create(DefenseSuccess, 1);
            this.create(PlayerDamage);
            this.create(Defense);
            this.create(SpecialAttack, 5, 0.8);
            this.create(Bluster);
            this.create(Fire);
            this.create(Stomp);
            this.create(ClawAttack);
            this.create(Blade2);
            this.create(Blade3);
            return;
        }// end function

        private function create(param1:Class, param2:uint = 5, param3:Number = 1) : void
        {
            this.seSet.push(new SoundEffect(param1, param2, param3));
            return;
        }// end function

        public function run() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            for (_loc_1 in this.playSeMap)
            {
                
                _loc_2 = _loc_1;
                _loc_2.run();
                if (!_loc_2.isEnd())
                {
                    continue;
                }
                this.playSeMap[_loc_1] = null;
                delete this.playSeMap[_loc_1];
            }
            return;
        }// end function

        private function playCmn(param1:SoundEffect) : void
        {
            if (this.playSeMap[param1])
            {
                return;
            }
            param1.playSound();
            this.playSeMap[param1] = true;
            return;
        }// end function

        public function playForWalk() : void
        {
            this.playCmn(this.seSet[0]);
            return;
        }// end function

        public function playForHittedBlade() : void
        {
            this.playCmn(this.seSet[1]);
            return;
        }// end function

        public function playForBlade() : void
        {
            this.playCmn(this.seSet[2]);
            return;
        }// end function

        public function playForDefenseSuccess() : void
        {
            this.playCmn(this.seSet[3]);
            return;
        }// end function

        public function playForPlayerDamage() : void
        {
            this.playCmn(this.seSet[4]);
            return;
        }// end function

        public function playForDefense() : void
        {
            this.playCmn(this.seSet[5]);
            return;
        }// end function

        public function playForSpecialAttack() : void
        {
            this.playCmn(this.seSet[6]);
            return;
        }// end function

        public function playForBluster() : void
        {
            this.playCmn(this.seSet[7]);
            return;
        }// end function

        public function playForFire() : void
        {
            this.playCmn(this.seSet[8]);
            return;
        }// end function

        public function playForStomp() : void
        {
            this.playCmn(this.seSet[9]);
            return;
        }// end function

        public function playForClawAttack() : void
        {
            this.playCmn(this.seSet[10]);
            return;
        }// end function

        public function playForBlade2() : void
        {
            this.playCmn(this.seSet[11]);
            return;
        }// end function

        public function playForBlade3() : void
        {
            this.playCmn(this.seSet[12]);
            return;
        }// end function

    }
}
