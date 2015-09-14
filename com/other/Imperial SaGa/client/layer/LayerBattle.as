package layer
{

    public class LayerBattle extends LayerBase
    {
        public static const BACKGROUND:int = 0;
        public static const BACK_EFFECT:int = 1;
        public static const CHARACTER:int = 2;
        public static const FRONT_EFFECT:int = 3;
        public static const DAMAGE:int = 4;
        public static const POPUP_MESSAGE:int = 5;
        public static const MAX:int = 6;

        public function LayerBattle()
        {
            super(MAX);
            return;
        }// end function

    }
}
