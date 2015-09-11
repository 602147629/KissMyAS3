package herovsdragon.game.char
{
    import flash.display.*;
    import flash.geom.*;

    public class CharacterColorChanger extends Object
    {
        private var mainFunction:Function;
        private const DAMAGE_OFFSET_MAX:int = 140;
        private const DAMAGE_OFFSET_DECREMENT:int = 10;
        private const DEFENSE_SUCCESS_OFFSET_MAX:int = 160;
        private const DEFENSE_SUCCESS_OFFSET_DECREMENT:int = 40;
        private var offset:int;
        private var viewLayer:Sprite;
        private var hitAresSprite:Sprite;

        public function CharacterColorChanger(param1:Sprite)
        {
            this.viewLayer = param1;
            this.mainFunction = this.stop;
            return;
        }// end function

        public function initializeAfterGameOver() : void
        {
            this.viewLayer.transform.colorTransform = new ColorTransform();
            this.mainFunction = this.stop;
            return;
        }// end function

        public function run() : void
        {
            this.mainFunction();
            return;
        }// end function

        private function stop() : void
        {
            return;
        }// end function

        public function isStoped() : Boolean
        {
            return this.mainFunction == this.stop;
        }// end function

        public function isSameAsProcessingHitArea(param1:Sprite) : Boolean
        {
            return param1 == this.hitAresSprite;
        }// end function

        public function viewDamage(param1:Sprite = null) : void
        {
            this.hitAresSprite = param1;
            this.viewLayer.transform.colorTransform = new ColorTransform();
            this.offset = this.DAMAGE_OFFSET_MAX;
            this.mainFunction = this.damage;
            return;
        }// end function

        private function damage() : void
        {
            this.viewLayer.transform.colorTransform = new ColorTransform(1, 1, 1, 1, this.offset, 0, 0, 0);
            this.offset = this.offset - this.DAMAGE_OFFSET_DECREMENT;
            if (this.viewLayer.transform.colorTransform.redOffset <= 0)
            {
                this.viewLayer.transform.colorTransform = new ColorTransform();
                this.hitAresSprite = null;
                this.mainFunction = this.stop;
            }
            return;
        }// end function

        public function viewDefenseSuccess() : void
        {
            this.viewLayer.transform.colorTransform = new ColorTransform();
            this.offset = this.DEFENSE_SUCCESS_OFFSET_MAX;
            this.mainFunction = this.changeColorForDefenseSuccess;
            return;
        }// end function

        private function changeColorForDefenseSuccess() : void
        {
            this.viewLayer.transform.colorTransform = new ColorTransform(1, 1, 1, 1, this.offset, this.offset, this.offset, 0);
            this.offset = this.offset - this.DEFENSE_SUCCESS_OFFSET_DECREMENT;
            if (this.viewLayer.transform.colorTransform.redOffset <= 0)
            {
                this.viewLayer.transform.colorTransform = new ColorTransform();
                this.mainFunction = this.stop;
            }
            return;
        }// end function

    }
}
