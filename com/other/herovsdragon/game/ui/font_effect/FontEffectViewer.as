package herovsdragon.game.ui.font_effect
{
    import __AS3__.vec.*;
    import flash.display.*;
    import herovsdragon.font_effect.*;

    public class FontEffectViewer extends Object
    {
        private var mainFunction:Function;
        private var fontEffectLayer:Sprite;
        private var sentenceSet:Vector.<Sentence>;
        private var fontEffectBehindLayer:Sprite;
        private var FONT_SCALE:int = 2;

        public function FontEffectViewer(param1:Sprite, param2:Sprite)
        {
            this.fontEffectBehindLayer = param1;
            this.fontEffectLayer = param2;
            this.sentenceSet = new Vector.<Sentence>;
            return;
        }// end function

        public function initializeAfterGameOver() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.sentenceSet)
            {
                
                _loc_1.destroy();
            }
            this.sentenceSet = new Vector.<Sentence>;
            return;
        }// end function

        public function addSentenceForDamagePoint(param1:int, param2:Number, param3:Number) : void
        {
            this.addSentence(FontEffect.createSentenceOfTypeA(this.getScoreStr(param1), param2, param3, null, this.FONT_SCALE), this.fontEffectLayer);
            return;
        }// end function

        private function getScoreStr(param1:int) : String
        {
            return String(param1);
        }// end function

        public function addSentenceForNormal(param1:String, param2:Number, param3:Number) : void
        {
            this.addSentence(FontEffect.createSentenceOfTypeA(param1, param2, param3, null, this.FONT_SCALE), this.fontEffectLayer);
            return;
        }// end function

        public function addSentenceForGreen(param1:String, param2:Number, param3:Number) : void
        {
            this.addSentence(FontEffect.createSentenceOfGreenTypeA(param1, param2, param3, this.FONT_SCALE), this.fontEffectLayer);
            return;
        }// end function

        private function addSentence(param1:Sentence, param2:Sprite) : void
        {
            param1.addChild(param2);
            param1.initializeForRun();
            this.sentenceSet.push(param1);
            return;
        }// end function

        public function run() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this.sentenceSet.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this.sentenceSet[_loc_2];
                _loc_3.run();
                if (!_loc_3.checkFinished())
                {
                }
                else
                {
                    _loc_3.removeChild();
                    this.sentenceSet.splice(_loc_2, 1);
                    _loc_1 = _loc_1 - 1;
                    _loc_2 = _loc_2 - 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

    }
}
