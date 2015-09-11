package herovsdragon.font_effect
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;

    public class Sentence extends Object
    {
        private var mainFunction:Function;
        private var characterSet:Vector.<Character>;
        private var layer:Sprite;
        private var alphaValueForErasingSentence:Number;

        public function Sentence(param1:String, param2:Number, param3:Number, param4:Class, param5:uint, param6:Number = 0, param7:ColorTransform = null, param8:Number = 0.1, param9:Number = 1)
        {
            var _loc_13:* = null;
            this.alphaValueForErasingSentence = param8;
            this.layer = new Sprite();
            this.layer.x = param2;
            this.layer.y = param3;
            this.layer.scaleX = param9;
            this.layer.scaleY = param9;
            var _loc_10:* = 0;
            var _loc_11:* = param1.length;
            this.characterSet = new Vector.<Character>(_loc_11, true);
            var _loc_12:* = 0;
            while (_loc_12 < _loc_11)
            {
                
                _loc_13 = new Character(param1.charAt(_loc_12), _loc_10, param4, param5 * _loc_12, param7);
                this.characterSet[_loc_12] = _loc_13;
                _loc_10 = _loc_10 + (_loc_13.getWidth() + param6);
                _loc_12 = _loc_12 + 1;
            }
            this.layer.x = this.layer.x - int(_loc_10 / 2) * param9;
            return;
        }// end function

        public function destroy() : void
        {
            this.removeChild();
            return;
        }// end function

        public function addChild(param1:Sprite) : void
        {
            var _loc_2:* = null;
            param1.addChild(this.layer);
            for each (_loc_2 in this.characterSet)
            {
                
                _loc_2.addChild(this.layer);
            }
            return;
        }// end function

        public function removeChild() : void
        {
            if (this.layer.parent.contains(this.layer))
            {
                this.layer.parent.removeChild(this.layer);
            }
            return;
        }// end function

        public function run() : void
        {
            this.mainFunction();
            return;
        }// end function

        public function checkFinished() : Boolean
        {
            return this.mainFunction == this.end;
        }// end function

        public function initializeForRun() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.characterSet)
            {
                
                _loc_1.initializeForRun();
            }
            this.mainFunction = this.dispCharacter;
            return;
        }// end function

        private function dispCharacter() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.characterSet)
            {
                
                _loc_1.run();
            }
            if (_loc_1.checkFinished())
            {
                this.mainFunction = this.erase;
            }
            return;
        }// end function

        private function erase() : void
        {
            this.layer.alpha = this.layer.alpha - this.alphaValueForErasingSentence;
            if (this.layer.alpha <= 0)
            {
                this.mainFunction = this.end;
            }
            return;
        }// end function

        private function end() : void
        {
            return;
        }// end function

    }
}
