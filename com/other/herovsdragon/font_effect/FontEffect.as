package herovsdragon.font_effect
{
    import flash.geom.*;
    import herovsdragon.font_effect.motion_guide.*;

    public class FontEffect extends Object
    {
        private static const COLOR_GREEN:ColorTransform = new ColorTransform(0.2, 0.8, 0, 0.6);
        private static const COLOR_YELLOW:ColorTransform = new ColorTransform(1, 0.8, 0, 1);
        private static const COLOR_RED:ColorTransform = new ColorTransform(1, 0.65, 0, 1);

        public function FontEffect()
        {
            return;
        }// end function

        public static function createSentenceOfGreenTypeA(param1:String, param2:Number, param3:Number, param4:Number = 1) : Sentence
        {
            return createSentenceOfTypeA(param1, param2, param3, COLOR_GREEN, param4);
        }// end function

        public static function createSentenceOfYellowTypeA(param1:String, param2:Number, param3:Number, param4:Number = 1) : Sentence
        {
            return createSentenceOfTypeA(param1, param2, param3, COLOR_YELLOW, param4);
        }// end function

        public static function createSentenceOfTypeA(param1:String, param2:Number, param3:Number, param4:ColorTransform = null, param5:Number = 1) : Sentence
        {
            return createSentence(param1, param2, param3, TypeA, param4, param5);
        }// end function

        public static function createSentenceOfYellowTypeB(param1:String, param2:Number, param3:Number, param4:Number = 1) : Sentence
        {
            return createSentenceOfTypeB(param1, param2, param3, COLOR_YELLOW, param4);
        }// end function

        public static function createSentenceOfTypeB(param1:String, param2:Number, param3:Number, param4:ColorTransform = null, param5:Number = 1) : Sentence
        {
            return createSentence(param1, param2, param3, TypeB, param4, param5);
        }// end function

        public static function createSentenceOfRedTypeC(param1:String, param2:Number, param3:Number, param4:Number = 1) : Sentence
        {
            return createSentenceOfTypeC(param1, param2, param3, COLOR_RED, param4);
        }// end function

        public static function createSentenceOfTypeC(param1:String, param2:Number, param3:Number, param4:ColorTransform = null, param5:Number = 1) : Sentence
        {
            return createSentence(param1, param2, param3, TypeC, param4, param5);
        }// end function

        public static function createSentence(param1:String, param2:Number, param3:Number, param4:Class, param5:ColorTransform = null, param6:Number = 1) : Sentence
        {
            return new Sentence(param1, param2, param3, param4, 2, 0, param5, 0.5, param6);
        }// end function

    }
}
