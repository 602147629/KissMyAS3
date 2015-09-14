package layer
{

    public class LayerHome extends LayerBase
    {
        public static const BG:int = 0;
        public static const MAIN:int = 1;
        public static const PARTY:int = 2;
        public static const BALLOON:int = 3;
        public static const STATUS_POP:int = 4;
        public static const SCRIPT:int = 5;
        public static const NOTICE:int = 6;
        public static const MAX:int = 7;

        public function LayerHome()
        {
            super(MAX);
            return;
        }// end function

    }
}
