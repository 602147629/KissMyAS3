package herovsdragon.game.hero.hiteffect
{
    import __AS3__.vec.*;
    import flash.display.*;

    public class HitEffectMap extends Object
    {
        private var layer:Sprite;
        private var hitEffectSet:Vector.<HitEffect>;

        public function HitEffectMap(param1:Sprite)
        {
            this.layer = param1;
            this.hitEffectSet = new Vector.<HitEffect>;
            return;
        }// end function

        public function createHitEffect(param1:Number, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = new HitEffect(this.layer, param1, param2, param3);
            this.hitEffectSet.push(_loc_4);
            return;
        }// end function

        public function run() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this.hitEffectSet.length)
            {
                
                _loc_2 = this.hitEffectSet[_loc_1];
                if (!_loc_2.run())
                {
                }
                else
                {
                    _loc_2.removeChild();
                    this.hitEffectSet.splice(_loc_1, 1);
                    _loc_1 = _loc_1 - 1;
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function initializeAfterGameOver() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.hitEffectSet)
            {
                
                _loc_1.removeChild();
            }
            this.hitEffectSet = new Vector.<HitEffect>;
            return;
        }// end function

    }
}
