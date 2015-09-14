package layer
{

    public class LayerEvent extends LayerBase
    {
        public static const SCREEN:int = 0;
        public static const FADE_ALPHA:int = 1;
        public static const BALLOON:int = 2;
        public static const SELECT:int = 3;
        public static const NARRATION:int = 4;
        public static const MOVIE:int = 5;
        public static const MONOLOGUE:int = 6;
        public static const INFORMATION:int = 7;
        public static const FADE:int = 8;
        public static const SKIP:int = 9;
        public static const MAX:int = 10;

        public function LayerEvent()
        {
            super(MAX);
            return;
        }// end function

    }
}
