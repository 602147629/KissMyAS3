package layer
{

    public class LayerCharacter extends LayerBase
    {
        public static const BACK_EFFECT:int = 0;
        public static const CHARACTER:int = 1;
        public static const FRONT_EFFECT:int = 2;
        public static const MAX:int = 3;

        public function LayerCharacter()
        {
            super(MAX);
            return;
        }// end function

    }
}
